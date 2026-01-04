# Clear conflicting universal variables
set -e fish_user_paths

# Build PATH step by step
set -gx PATH /opt/homebrew/opt/ruby/bin
set -gx PATH $PATH /opt/homebrew/bin /opt/homebrew/sbin
set -gx PATH $PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin

# Mason (Neovim) and pipx
set -gx PATH $PATH /Users/gil/.local/share/nvim/mason/bin /Users/gil/.local/bin

# Starship prompt
starship init fish | source

# zoxide
zoxide init fish | source

# Set a custom data file for z
set -gx Z_DATA ~/.z_single_dir
# Optional: Set maximum entries to keep it focused
set -gx Z_MAX_SCORE 9000

# Disable fish greeting
set -U fish_greeting ""
set -U fish_color_command magenta --bold
set -U fish_color_autosuggestion brblack

# Bind fuzzy search to ctrl + f
fzf_configure_bindings --directory=\cf

# fnm setup for fish (this will add to PATH, but after our setup)
fnm env | source

# Ruby gems setup (uncommented for proper Ruby gem support)
set -gx GEM_HOME (brew --prefix)/lib/ruby/gems/(ruby -e "puts RUBY_VERSION[/\d+\.\d+/]")
set -gx PATH $GEM_HOME/bin $PATH

# alias
# alias lf "lfcd"
alias gs "git status"
alias gb "git branch"

set -gx LS_COLORS "di=97"

# keybind lfcd
function lfcd
    set tmp (mktemp)
    command lf -last-dir-path=$tmp
    if test -f $tmp
        set dir (cat $tmp)
        rm $tmp
        if test -d "$dir"
            cd "$dir"
        end
    end
end

# Ctrl-n → lfcd
function __lfcd_keybind
    lfcd
    commandline -f repaint
end

# Key bindings
bind \cn __lfcd_keybind
bind -M insert \cn __lfcd_keybind
