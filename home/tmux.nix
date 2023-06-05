{ ... }: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    keyMode = "vi";
    newSession = true;
    prefix = "M-s";
    # terminal = "tmux-256color";

    disableConfirmationPrompt =
      false; # Disable confirmation prompt before killing a pane or window
    customPaneNavigationAndResize =
      false; # Override the hjkl and HJKL bindings for pane navigation and resizing in VI mode.

    extraConfig = ''
      # turiual
      # commands:
      #     tmux: start tmux
      #     tmux new -s <name>: start tmux with a tag <name>
      #     tmux ls: list all of sessions
      #     tmux a #: attach session
      #     tmux kill-session -t <name>: kill session by session name
      # keymap:
      #     prefix:
      #         ?: help docs
      #         q: kill pane
      #         Q: kill window
      #         ctrl+q: kill session
      #         d: detach session
      #         s: list sessions
      #         r: rename window
      #         R: rename session
      #         n: create new window
      #         f: maximize pane
      #         
      # unbind default keymap.
      # 解绑一些默认的按键
      unbind C-b
      unbind "'"
      unbind '"'
      unbind "%"
      unbind "n"
      unbind "0"
      unbind "1"
      unbind "2"
      unbind "3"
      unbind "4"
      unbind "5"
      unbind "6"
      unbind "7"
      unbind "8"
      unbind "9"
      unbind "f"
      unbind "b"
      # personal keymap.
      # 自用的按键映射
      bind "'" split-window -h
      bind '"' split-window -b
      bind k selectp -U
      bind j selectp -D
      bind h selectp -L
      bind l selectp -R
      bind ^k resizep -U 10
      bind ^j resizep -D 10
      bind ^h resizep -L 10
      bind ^l resizep -R 10
      bind n new-window
      bind r command-prompt -I "#W" "rename-window '%%'"
      bind R command-prompt -I "#W" "rename-session '%%'"
      bind q kill-pane
      bind Q kill-window
      bind ^q kill-session
      bind 1 select-window -t 1
      bind 2 select-window -t 2
      bind 3 select-window -t 3
      bind 4 select-window -t 4
      bind 5 select-window -t 5
      bind 6 select-window -t 6
      bind 7 select-window -t 7
      bind 8 select-window -t 8
      bind 9 select-window -t 9
      bind f resize-pane -Z
      bind t set -g status
      # bind f next-window
      # bind b previous-window
      # global settings
      set-option -g mouse on # enable mouse support(启动鼠标的支持)
      # set -g prefix M-s # set your prefix(replace C-b)(设置前缀键)
      # set -s escape-time 0 # disable ecsape reaction time(按下esc停留的时间)
      # setw -g mode-keys vi # vi mode(vi 模式的支持)
      # set -g default-terminal "tmux-256color" # enable 256 colors (终端启动256色的支持，默认并不开启)
      # set-option -ga terminal-overrides ",xterm-256color:Tc"
      # set -g base-index 1 # pane set base index start on 1(设置base-index是从1开始的)
      # set-window-option -g pane-base-index 1 # pane set base index start on 1
      # theme setting
      # inpresied from tokyo-night-tmux(https://github.com/janoamaral/tokyo-night-tmux)
      #################################################
      #                 colors variable               #
      #################################################
      dark_background="#1F2937"
      gray="#475569"
      warnning="#EAB308"
      green="#34D399"
      violet="#A78BFA"
      lightrose="#FB7185"
      #################################################
      #                 theme option                  #
      #################################################
      set-option -g status-style fg=colour15,bg=$dark_background
      set -g pane-active-border-style fg=#84B7D9
      set -g pane-border-style fg=#827B7C
      #################################################
      #                     scripts                   #
      #################################################
      # git_status="#(~/.scripts/git-status.sh #{pane_current_path})"
      #################################################
      #                 window status                 #
      #################################################
      set -g window-status-current-format "#[fg=white,bg=#1F2335]   #I #W  " # focus status
      set -g window-status-format "#[fg=brightwhite,bg=default,nobold,noitalics,nounderscore]   #I #W #F  " # unfocus status
      set -g window-status-separator ""
      # left component setting
      set -g status-left "#[fg=black,bg=#{?client_prefix,yellow,green},bold] #S #[fg=blue,bg=default,nobold,noitalics,nounderscore]"
      # right component
      # set -g status-right "#[fg=white,bg=$gray, bold] %Y-%m-%d %H:%M $git_status#[fg=$green, bold]PM "
      set -g status-right "#[fg=white,bg=$gray, bold] %Y-%m-%d %H:%M "
      set -g status-right-length 150
      # Plugins of list
      # TPM管理的插件
      # set -g @plugin 'tmux-plugins/tpm'
      # set -g @plugin 'tmux-plugins/tmux-sensible'
      # set -g @plugin "janoamaral/tokyo-night-tmux"
      # run '~/.tmux/plugins/tpm/tpm'
    '';
  };

}
