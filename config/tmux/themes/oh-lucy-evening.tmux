
# ===== Oh Lucy Evening =====

set -g status-bg "#1E1D23"
set -g status-fg "#686069"

set -g pane-border-style "fg=#413E41"
set -g pane-active-border-style "fg=#7F737D"

set -g message-style "bg=#1E1D23,fg=#DED7D0"
set -g mode-style "bg=#1E1D23,fg=#EFD472"

##### Dotbar (Oh Lucy Evening) #####
set -g @tmux-dotbar-bg "#1E1D23"
set -g @tmux-dotbar-fg "#686069"
set -g @tmux-dotbar-fg-current "#E39A65"
set -g @tmux-dotbar-fg-session "#1E1D23"
set -g @tmux-dotbar-fg-prefix "#FF7DA3"

set -g @tmux-dotbar-window-status-format " #W "
set -g @tmux-dotbar-window-status-separator " • "
set -g @tmux-dotbar-position top
set -g @tmux-dotbar-right true

run '~/.tmux/plugins/tmux-dotbar/dotbar.tmux'
