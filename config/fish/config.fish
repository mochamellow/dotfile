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

# Bind fuzzy search to ctrl + f
bind \cf fzf_search_directory
bind -M insert \cf fzf_search_directory

# Bind shell history to ctrl + h
bind \ch fzf_search_history
bind -M insert \ch fzf_search_history

# fnm setup for fish (this will add to PATH, but after our setup)
fnm env | source

# Ruby gems setup (uncommented for proper Ruby gem support)
set -gx GEM_HOME (brew --prefix)/lib/ruby/gems/(ruby -e "puts RUBY_VERSION[/\d+\.\d+/]")
set -gx PATH $GEM_HOME/bin $PATH
