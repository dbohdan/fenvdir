#! /usr/bin/env fish

cd "$(path dirname "$(status filename)")"

set --local src functions/fenvdir.fish
set --local dst $__fish_config_dir/functions/fenvdir.fish

if not cp $src $dst
    return 1
end

printf 'copied "%s" to "%s"\n' $src $dst
