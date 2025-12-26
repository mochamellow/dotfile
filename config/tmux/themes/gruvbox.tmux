
# ===== Gruvbox Dark =====

set -g status-bg "#1D2021"
set -g status-fg "#5C564A"

set -g pane-border-style "fg=#504945"
set -g pane-active-border-style "fg=#EBDBB2"

set -g message-style "bg=#3C3836,fg=#EBDBB2"
set -g mode-style "bg=#3C3836,fg=#F74935"

# Dotbar
set -g @tmux-dotbar-bg "#1D2021"
set -g @tmux-dotbar-fg "#5C564A"
set -g @tmux-dotbar-fg-current "#FE8018"
set -g @tmux-dotbar-fg-session "#EBDBB2"
set -g @tmux-dotbar-fg-prefix "#F74935"

set -g @tmux-dotbar-window-status-format " #W "
set -g @tmux-dotbar-window-status-separator " • "
set -g @tmux-dotbar-position top
set -g @tmux-dotbar-right true

run '~/.tmux/plugins/tmux-dotbar/dotbar.tmux'
