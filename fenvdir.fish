function fenvdir --argument-names dir
    argparse --min-args 1 --max-args 1 v/verbose -- $argv
    or return

    # Should we ignore hidden files?
    for f in $dir/*
        set --local name (path basename $f)

        if not test -s $f
            set --erase --global $name

            set --query _flag_verbose
            and printf 'erased "%s"\n' $name

            continue
        end

        set --local value "$(read < "$f" | string trim --chars "\t " --right | string split0)"

        # Reset $status.
        true
        if not set --export --global $name $value
            printf 'can\'t set variable "%s" to "%s"\n' $name $value
            return 111
        end

        if set --query _flag_verbose
            set -s $name
        end
    end
end
