let
  f =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ sesh ];
      programs.tmux = {
        enable = true;
        baseIndex = 1;
        clock24 = true;
        escapeTime = 0;
        keyMode = "vi";
        prefix = "M-s";
        # terminal = "tmux-256color";

        disableConfirmationPrompt = false; # Disable confirmation prompt before killing a pane or window
        customPaneNavigationAndResize = false; # Override the hjkl and HJKL bindings for pane navigation and resizing in VI mode.

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
          # bind t set -g status
          # bind f next-window
          # bind b previous-window

          bind-key "t" run-shell "sesh connect \"$(
            sesh list --icons | fzf-tmux -p 80%,70% \
              --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
              --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
              --bind 'tab:down,btab:up' \
              --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
              --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
              --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
              --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
              --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
              --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
              --preview-window 'right:55%' \
              --preview 'sesh preview {}'
          )\""

          # global settings
          set -g prefix M-s # set your prefix(replace C-b)(设置前缀键)
          set -s escape-time 0 # disable ecsape reaction time(按下esc停留的时间)
          setw -g mode-keys vi # vi mode(vi 模式的支持)
          set-option -g mouse on # enable mouse support(启动鼠标的支持)
          set -g default-terminal "xterm-256color" # enable 256 colors (终端启动256色的支持，默认并不开启)
          set-option -ga terminal-overrides ",xterm-256color:Tc"
          set -g base-index 1 # pane set base index start on 1(设置base-index是从1开始的)
          set-window-option -g pane-base-index 1 # pane set base index start on 1
          set-option -g status-left-length 20
          set -s set-clipboard on

          #################################################
          #                 colors variable               #
          #################################################
          base00="#fafafa"
          base01="#7c9f4b"
          base02="#d69822"
          base03="#5e646f"
          base04="#6587bf"
          base05="#5e646f"
          base06="#b870ce"
          base07="#5e646f"
          base08="#db7070"
          base09="#db7070"
          base0A="#d69822"
          base0B="#7c9f4b"
          base0C="#509c93"
          base0D="#6587bf"
          base0E="#b870ce"
          base0F="#509c93"

          bg=$base00
          fg=$base07

          # github dark from https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/ghostty/GitHub%20Dark
          base00=#000000
          base01=#f78166
          base02=#56d364
          base03=#e3b341
          base04=#6ca4f8
          base05=#db61a2
          base06=#2b7489
          base07=#ffffff
          base08=#4d4d4d
          base09=#f78166
          base0A=#56d364
          base0B=#e3b341
          base0C=#6ca4f8
          base0D=#db61a2
          base0E=#2b7489
          base0F=#ffffff

          bg=$base00
          fg=$base06
          #################################################
          #                 theme option                  #
          #################################################
          set-option -g status-style fg=$fg,bg=$bg
          #################################################
          #                 window status                 #
          #################################################
          set -g window-status-format "#[fg=$bg,bg=$fg,nobold,noitalics,nounderscore] #[fg=$bg,bg=$fg]#I #[bg=$fg,nobold,noitalics,nounderscore] #[fg=$bg,bg=$fg]#W #F #[fg=$fg,bg=$bg,nobold,noitalics,nounderscore]"
          current_bg=$base07
          set -g window-status-current-format "#[fg=$bg,bg=$current_bg,nobold,noitalics,nounderscore] #[fg=$bg,bg=$current_bg]#I #[bg=$current_bg,nobold,noitalics,nounderscore] #[fg=$bg,bg=$current_bg]#W #F #[fg=$current_bg,bg=$bg,nobold,noitalics,nounderscore]"
          set -g window-status-separator ""

          # left component setting
          bright_color=$base0C
          set -g status-left "#[fg=$bg,bg=$bright_color,bold] #S #[fg=$bright_color,bg=$bg,nobold,noitalics,nounderscore]"

          # right component
          bright_color=$base0D
          set -g status-right "#[fg=$fg,bg=$bg,nobold,noitalics,nounderscore]#[fg=$bg,bg=$fg,bold] #H #[fg=$bright_color,bg=$fg,nobold,noitalics,nounderscore]#[fg=$bg,bg=$bright_color,bold] %Y.%m.%d %H:%M "

          set -g pane-border-style bg=default,fg=$base08
          set -g pane-active-border-style bg=default,fg=$base08,bold
          set -g display-panes-colour $fg
          set -g display-panes-active-colour $base08
        '';
      };
    };
in
{
  hmModules = [ f ];
}
