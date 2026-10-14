# Jellybeans tmux theme (updated for tmux 2.9+)

set -g status-style "fg=colour255,bg=colour236"
set -g status-justify "left"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status "on"

set -g pane-active-border-style "fg=colour103"
set -g pane-border-style "fg=colour239"

set -g message-style "fg=colour236,bg=colour103"
set -g message-command-style "fg=colour236,bg=colour103"

setw -g window-status-style "fg=colour255,bg=colour236"
setw -g window-status-activity-style "fg=colour255,bg=colour236"
setw -g window-status-separator ""

set -g status-left "#[fg=colour236,bg=colour103] #S #[fg=colour103,bg=colour236,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=colour239,bg=colour236,nobold,nounderscore,noitalics]#[fg=colour255,bg=colour239] %Y-%m-%d | %H:%M #[fg=colour103,bg=colour239,nobold,nounderscore,noitalics]#[fg=colour236,bg=colour103] #h "
setw -g window-status-format "#[fg=colour255,bg=colour236] #I |#[fg=colour255,bg=colour236] #W "
setw -g window-status-current-format "#[fg=colour236,bg=colour103,nobold,nounderscore,noitalics]#[fg=colour236,bg=colour103] #I |#[fg=colour236,bg=colour103] #W #[fg=colour103,bg=colour236,nobold,nounderscore,noitalics]"
