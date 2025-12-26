bind L split-window -h
bind | split-window -h
bind J split-window -v
bind - split-window -v

bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

bind f resize-pane -Z

bind -n C-\[ previous-window
bind -n C-\] next-window

unbind -T root C-l
unbind -T prefix C-l
unbind -T copy-mode-vi C-l
bind -n C-l send-keys C-l
