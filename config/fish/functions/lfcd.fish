function lfcd --wraps="lf" --description="lf - Terminal file manager (changing directory on exit)"
    set tmp (mktemp)
    command lf -last-dir-path=$tmp $argv
    if test -f "$tmp"
        set dir (cat "$tmp")
        rm -f "$tmp"
        if test -d "$dir" -a "$dir" != (pwd)
            cd "$dir"
        end
    end
end
