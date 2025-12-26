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
