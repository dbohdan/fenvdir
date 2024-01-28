#! /usr/bin/env fish
# Copyright (c) 2023 D. Bohdan. License: MIT.

cd "$(path dirname "$(status filename)")"
source functions/fenvdir.fish

begin
    fenvdir d
    or return

    test "$foo" = bar
    or return 2

    set --query empty
    and return 3

    test "$no_newline" = "hello fish world"
    or return 4

    set --local null_sep_ref hello\nfish\nworld
    test "$null_sep" = "$null_sep_ref"
    or return 5

    fenvdir d/ --verbose >/dev/null
    or return 6
end
