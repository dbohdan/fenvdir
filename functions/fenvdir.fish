# Copyright (c) 2023 D. Bohdan. License: MIT.

function fenvdir --argument-names dir
    argparse --min-args 1 --max-args 1 v/verbose -- $argv
    or return

    if not test -r $dir
        printf 'directory not readable: "%s"\n' $dir >/dev/stderr
        return 111
    end

    # We ignore hidden files.
    for f in $dir/*
        set --local name (path basename $f)

        if test -d $f
            printf 'found a subdirectory: "%s"\n' $f >/dev/stderr
            return 111
        end

        if not test -r $f
            printf 'file not readable: "%s"\n' $f >/dev/stderr
            return 111
        end

        if not set --global $name '' 2>/dev/null
            printf 'invalid variable name: "%s"\n' $name >/dev/stderr
            return 111
        end

        # If the file is empty, erase the variable.
        if not test -s $f
            set --erase --global $name

            set --query _flag_verbose
            and echo set -e $name

            continue
        end

        set --local value "$(read < "$f" \
            | string trim --chars "\t " --right \
            | string split0)"

        # Reset $status.
        true
        if not set --export --global $name $value
            # This should not happen with the checks above.
            printf 'can\'t set variable "%s" to value from file "%s"\n' $name $f >/dev/stderr
            return 111
        end

        if set --query _flag_verbose
            echo set -gx $name (string escape $value)
        end
    end
end
