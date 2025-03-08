{ nixvim, ... }:
let
  f = { pkgs, config, ... }:
    let
      helpers = config.lib.nixvim;
    in
    {
      imports = [ nixvim.homeManagerModules.nixvim ];
      programs.nixvim = {
        package = pkgs.neovim;
        enable = true;
        opts = {
          number = true;
          cursorline = true;

          backup = false;
          swapfile = false;

          history = 2000;

          ignorecase = true;
          smartcase = true;
          infercase = true;

          laststatus = 3;
          signcolumn = "yes";

          linebreak = true;

          whichwrap = "<,>,[,],~";
          breakindentopt = "shift:2,min:20";
          showbreak = "↳ ";

          shiftwidth = 2;
          tabstop = 2;
          softtabstop = 2;
          expandtab = true;

          termguicolors = true;

          foldcolumn = "0";

          foldlevel = 99;
          foldlevelstart = 99;
          foldenable = true;
          foldmethod = "manual";

        };

        withNodeJs = true;
        extraPackages = with pkgs; [
          lua-language-server
          nil

          watchman # for coc watch dependence
        ];

        autoCmd = [
          {
            event = [
              "FileType"
            ];
            callback = helpers.mkRaw ''
              function()
                vim.keymap.set('n', 'q', '<Cmd>q<CR>', { silent = true, buffer = true })
              end
            '';
            group = "patch_augroup";
            pattern = [
              "help"
              "dashboard"
              "coctree"
            ];
          }
        ];

        autoGroups = {
          patch_augroup.clear = true;
        };


        globals = {
          mapleader = " ";
        };

        plugins.lazy = {
          enable = true;
          plugins =
            let
              fn = content: ''
                  function ()
                ${content}
                  end
              '';
            in
            (with pkgs.vimPlugins; [
              {
                pkg = nvim-spectre;
                lazy = true;
                cmd = [ "Spectre" ];
              }
              {
                pkg = lazygit-nvim;
                lazy = true;
                cmd = [ "Lazygit" ];
              }
              {
                pkg = vim-dadbod-ui;
                lazy = true;
                dependencies = [ vim-dadbod vim-dadbod-completion ];
                cmd = [ "DBUI" ];
              }
              {
                pkg = fzf-lua;
                lazy = true;
                opts = {
                  winopts = {
                    height = 0.65;
                    row = 0.7;
                  };
                };
                cmd = "FzfLua";
              }
              {
                pkg = supermaven-nvim;
                config = true;
              }
              {
                pkg = hlsearch-nvim;
                config = true;
              }

              {
                pkg = nvim-lastplace;
                config = fn ''
                  require('nvim-lastplace').setup({
                    lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
                    lastplace_ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' },
                    lastplace_open_folds = true,
                  })
                '';
              }

              {
                pkg = comment-nvim;
                lazy = true;
                config = fn ''
                  require('Comment').setup({
                    mappings = {
                      basic = true,
                      extra = false,
                    },
                    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
                  })
                '';
              }
              {
                pkg = nvim-osc52;
                # TODO: add lazy key map
                config = fn ''
                  vim.keymap.set('v', 'fy', require('osc52').copy_visual)
                '';
              }
              {
                pkg = nvim-ufo;
                dependencies = [ promise-async ];
                config = true;
              }
              {
                pkg = pkgs.coc-nvim;
                config = fn ''
                  require('nixvim-extra.coc')
                '';
                dependencies = [
                  coc-git
                  coc-pairs
                  coc-lists
                  coc-snippets
                  coc-explorer
                  pkgs.coc-eslint-tools
                  pkgs.coc-tsserver
                  pkgs.coc-sumneko-lua
                ];
              }

              {
                pkg = codecompanion-nvim;
                config = fn ''
                  require('nixvim-extra.codecompanion')
                '';
              }
              {
                pkg = nvim-treesitter;
                config =
                  let
                    nvim-plugintree = pkgs.vimPlugins.nvim-treesitter.withPlugins (
                      p: with p; [
                        bash
                        go
                        javascript
                        typescript
                        tsx
                        json
                        lua
                        markdown
                        markdown_inline
                        nix
                        rust
                        yaml
                        ocaml
                      ]
                    );

                    treesitter-parsers = pkgs.symlinkJoin {
                      name = "treesitter-parsers";
                      paths = nvim-plugintree.dependencies;
                    };
                  in
                  fn ''
                    vim.opt.runtimepath:append("${nvim-plugintree}")
                    vim.opt.runtimepath:append("${treesitter-parsers}")

                    require('nvim-treesitter.configs').setup({
                      parser_install_dir = "${treesitter-parsers}",
                      auto_install = false,
                      indent = {enable = true};
                      highlight = {
                        enable = true,
                        additional_vim_regex_highlighting = false,
                      },
                    })
                  '';
                dependencies = [ nvim-treesitter-context nvim-ts-context-commentstring ];
              }
              {
                pkg = vitesse-nvim;
                config = fn "vim.cmd [[colorscheme vitesse]]";
              }

              {
                pkg = toggleterm-nvim;
                config = fn ''
                  require("toggleterm").setup {
                    size = 20,
                    open_mapping = [[<c-t>]],
                  }
                '';
              }

            ]) ++ (map (p: { pkg = p; }) (with pkgs.vimPlugins; [ vim-smoothie vim-surround fcitx-nvim plenary-nvim ]));


        };

        keymaps =
          let
            map = mode: key: action: options: { inherit mode key action options; };
            nmap = k: a: (map [ "n" ] k a { silent = true; nowait = true; });
            nmapl = k: a: nmap k ("<CMD>lua ${a}<CR>");
            nmapc = k: a: nmap k ("<CMD>${a}<CR>");
            nmapp = k: a: nmap k ("<Plug>(${a})");

            vnmap = k: a: (map [ "v" "n" ] k a { silent = true; nowait = true; });

            fzfLuaKeys = [
              (nmapc "<leader>fb" "FzfLua buffers")
              (nmapc "<leader>fw" "FzfLua live_grep")
              (nmapc "<leader>ff" "FzfLua files")
              (nmapc "<leader>fo" "FzfLua oldfiles")
              (nmapc "<leader>fr" "FzfLua resume")
            ];

            ufoKeys = [
              (nmapl "zR" "require('ufo').openAllFolds")
              (nmapl "zM" "require('ufo').closeAllFolds")
            ];

            cocKeys = [
              (nmapc "<C-n>" "CocExplorer")
              (nmapc "<leader>cf" "CocFormat")
              (nmapp "<leader>ca" "coc-codeaction-cursor")
              (nmapp "<leader>rn" "coc-rename")
              (nmapp "<leader>j" "coc-diagnostic-next")
              (nmapp "<leader>k" "coc-diagnostic-prev")
              (nmapp "gd" "coc-definition")
              (nmapp "gr" "coc-references")
              (nmapp "gy" "coc-type-definition")
              (nmapp "gi" "coc-implementation")
              (nmapc "<leader>fs" "CocList symbols")
              (nmapp "gk" "coc-git-prevchunk")
              (nmapp "gj" "coc-git-nextchunk")
              (nmapp "<leader>gp" "coc-git-chunkinfo")
            ];

            keys = [
              (map [ "v" "n" ] ";" ":" { })
              (nmapc "<leader>bd" "bd")
              (vnmap "<C-j>" "3j")
              (vnmap "<C-k>" "3k")
              (vnmap "<C-h>" "4h")
              (vnmap "<C-l>" "4l")
            ];
          in
          keys ++ fzfLuaKeys ++ ufoKeys ++ cocKeys;

        extraConfigLua =
          ''
            require('nixvim-extra.stsline')
          '';
      };

      home.file.".config/nvim/lua/nixvim-extra" = {
        source = ../config/nixvim-extra;
        recursive = true;
      };

      home.file.".config/nvim/coc-settings.json" = {
        source = ../config/coc-settings.json;
      };
    };
in
{
  hmModules = [ f ];
}
