
# ===== Catppuccin Mocha =====

set -g status-bg "#1E1E2E"
set -g status-fg "#516D80"

set -g pane-border-style "fg=#45475A"
set -g pane-active-border-style "fg=#FAB387"

set -g message-style "bg=#313244,fg=#CDD6F4"
set -g mode-style "bg=#313244,fg=#FAB387"

# Dotbar
set -g @tmux-dotbar-bg "#1E1E2E"
set -g @tmux-dotbar-fg "#516D80"
set -g @tmux-dotbar-fg-current "#FAB387"
set -g @tmux-dotbar-fg-session "#CDD6F4"
set -g @tmux-dotbar-fg-prefix "#E46A78"

set -g @tmux-dotbar-window-status-format " #W "
set -g @tmux-dotbar-window-status-separator " • "
set -g @tmux-dotbar-position top
set -g @tmux-dotbar-right true

run '~/.tmux/plugins/tmux-dotbar/dotbar.tmux'
