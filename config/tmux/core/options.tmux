set -g prefix `
unbind C-b
bind ` send-prefix

setw -g mode-keys vi
set -g mouse off

set -g base-index 1
set -g pane-base-index 1
set -g renumber-windows on
set -g detach-on-destroy off
set -g escape-time 0
set -g set-clipboard on

set -g default-shell /opt/homebrew/bin/fish
set -g default-terminal "screen-256color"

set -g pane-border-lines double

# Allow italics and 24-bit color (TrueColor) support
set -g default-terminal "tmux-256color"
set -as terminal-overrides ",xterm-256color:Tc"
set -as terminal-overrides ",xterm-256color:RGB"

# Specifically tell tmux to support the 'sitm' (start italic mode) capability
set -as terminal-overrides ',xterm*:sitm=\E[3m'
