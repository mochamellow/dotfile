# ===== Kanagawa (wave) =====

set -g status-bg "#1F1F28"
set -g status-fg "#54546D"

set -g pane-border-style "fg=#54546D"
set -g pane-active-border-style "fg=#C25963"

# Dotbar
set -g @tmux-dotbar-bg "#1F1F28"
set -g @tmux-dotbar-fg "#54546D"
set -g @tmux-dotbar-fg-current "#E6C384"
set -g @tmux-dotbar-fg-session "#DCD7BA"
set -g @tmux-dotbar-fg-prefix "#C25963"

set -g @tmux-dotbar-window-status-format " #W "
set -g @tmux-dotbar-window-status-separator " • "
set -g @tmux-dotbar-position top
set -g @tmux-dotbar-right true

# Apply dotbar AFTER colors
run '~/.tmux/plugins/tmux-dotbar/dotbar.tmux'
