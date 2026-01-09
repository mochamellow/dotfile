
# ===== Bearded Arc =====

set -g status-bg "#1c2433"          # Background
set -g status-fg "#444c5b"          # Dark Gray

set -g pane-border-style "fg=#444c5b"    # Faded Blue/Gray
set -g pane-active-border-style "fg=#69C3FF" # Active/Cursor Blue

set -g message-style "bg=#1c2433,fg=#c3cfd9" # Background, Foreground
set -g mode-style "bg=#1c2433,fg=#FF738A"    # Background, Accent Red

set -g @tmux-dotbar-bg "#1c2433"
set -g @tmux-dotbar-fg "#444c5b"
set -g @tmux-dotbar-fg-current "#EACD61"
set -g @tmux-dotbar-fg-session "#c3cfd9"
set -g @tmux-dotbar-fg-prefix "#3CEC85"   

run '~/.tmux/plugins/tmux-dotbar/dotbar.tmux'
