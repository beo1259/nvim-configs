return {
    -- color scheme
    -- {
    --     "neanias/everforest-nvim",
    --     version = false,
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("everforest").setup({
    --             background = "hard",
    --             diagnostic_text_highlight = true,
    --             diagnostic_virtual_text = "colored",
    --             diagnostic_line_highlight = 1,
    --         })
    --      vim.cmd.colorscheme("everforest")
    --     end,
    -- },

    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        opts = { },
        config = function()
            vim.o.background = "dark"
            vim.cmd.colorscheme("gruvbox")
        end,
    },

    -- file explorer
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup({
                sort = {
                    sorter = "case_sensitive",
                },
                view = {
                    width = 40,
                    side = "right",
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = true,
                },
            })
        vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { silent = true, noremap = true })
        end,
    },

    -- auto-pair brackets/quotes
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true,
    },

    -- telescope (fuzzy find)
    {
        {
            'nvim-telescope/telescope.nvim',
            config = function()
                local builtin = require('telescope.builtin')
                vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
                vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
                vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
                vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
            end,
            tag = '0.1.8',
            dependencies = { 'nvim-lua/plenary.nvim' },
        }
    },

    -- git diffs
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose" },
        keys = {
            { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
            { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
        },
        opts = {},
    },

    -- lua line
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("lualine").setup({
                theme = 'ayu-mirage'
            })
        end,
    },

    -- auto complete
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
        },
        config = function()
        local cmp = require("cmp")

        -- regular completion (LSP, buffer, path, etc)
        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },

            completion = {
                completeopt = 'menu,menuone,noinsert'
            },

            mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),

                    ["<C-Space>"] = cmp.mapping.complete(),

                    -- ["<Tab>"] = cmp.mapping(function(fallback)
                    --   if cmp.visible() then
                    --     cmp.select_next_item()
                    --   elseif luasnip.expand_or_jumpable() then
                    --     luasnip.expand_or_jump()
                    --   else
                    --     fallback()
                    --   end
                    -- end, { "i", "s" }),
                    --
                    -- ["<S-Tab>"] = cmp.mapping(function(fallback)
                    --   if cmp.visible() then
                    --     cmp.select_prev_item()
                    --   elseif luasnip.jumpable(-1) then
                    --     luasnip.jump(-1)
                    --   else
                    --     fallback()
                    --   end
                    -- end, { "i", "s"}),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },  -- LSP
                    { name = "buffer" },    -- buffer words
                    { name = "path" },      -- filesystem
                }),
            })


            -- cmdline completion ( : commands )
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "path" },
                    { name = "cmdline" },
                },
            })

            -- search completion ( / or ? )
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" }
                },
            })
        end,
    },

    -- ui for cmdline, popup menu, search
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                      ["vim.lsp.util.stylize_markdown"] = true,
                      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                presets = {
                    bottom_search = false, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
                cmdline = {
                    view = "cmdline_popup",
                },
                views = {
                    cmdline_popup = {
                        position = {
                            row = "40%",
                            col = "50%",
                        }
                    }
                }
            })
        end,
        dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
    },

    {
        "rcarriga/nvim-notify",
        opts = {
            timeout = 1000,
        },
    },

    -- show possible leader commands
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },

    -- show indent lines
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },

    -- git wrapper
    {
        "tpope/vim-fugitive",
    },

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/playground",
            "nvim-treesitter/nvim-treesitter-context",
        },
        build = ":TSUpdate",
        opts = {
            indent = { enable = true }, ---@type lazyvim.TSFeat
            highlight = { enable = true }, ---@type lazyvim.TSFeat
            folds = { enable = true }, ---@type lazyvim.TSFeat
            ensure_installed = {
                "bash",
                "c",
                "diff",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "jsonc",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "printf",
                "python",
                "query",
                "regex",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
                "rust",
                "latex",
            },
        }
    },

    -- LSP config
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.diagnostic.config({
                virtual_text = true,
                signs = false,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })
        end,
    },

    -- LSP package manager
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "pyright",
                "html",
                "gopls",
                "rust_analyzer",
                "cssls",
                "csharp_ls",
                "clangd",
                "markdown",
                "markdown_inline",
                "latex",
                "typst",
                "yaml",
            },
        },
    },

    -- buffer line
    {
        "akinsho/bufferline.nvim",
        opts = { },
    },

    -- scrollbar
    {
        "petertriho/nvim-scrollbar",
        config = function()
            require("scrollbar").setup({ })
        end
    },

    -- save and reopen previous session
    {
        "rmagatti/auto-session",
        lazy = false,

        ---enables autocomplete for opts
        ---@module "auto-session"
        ---@type AutoSession.Config
        opts = {
            suppressed_dirs = { "~/repos"},
        },
    },

    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- Library paths can be absolute
          "~/projects/my-awesome-lib",
          -- Or relative, which means they will be resolved from the plugin dir.
          "lazy.nvim",
          -- It can also be a table with trigger words / mods
          -- Only load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          -- always load the LazyVim library
          "LazyVim",
          -- Only load the lazyvim library when the `LazyVim` global is found
          { path = "LazyVim", words = { "LazyVim" } },
          -- Load the wezterm types when the `wezterm` module is required
          -- Needs `DrKJeff16/wezterm-types` to be installed
          { path = "wezterm-types", mods = { "wezterm" } },
          -- Load the xmake types when opening file named `xmake.lua`
          -- Needs `LelouchHe/xmake-luals-addon` to be installed
          { path = "xmake-luals-addon/library", files = { "xmake.lua" } },
        },
        -- always enable unless `vim.g.lazydev_enabled = false`
        -- This is the default
        enabled = function(root_dir)
          return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
        end,
        -- disable when a .luarc.json file is found
        enabled = function(root_dir)
          return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
        end,
      },
    },

    -- code actions
    {
        "rachartier/tiny-code-action.nvim",
        dependencies = {
            {"nvim-lua/plenary.nvim"},

            -- optional picker via telescope
            {"nvim-telescope/telescope.nvim"},
            -- optional picker via fzf-lua
            {"ibhagwan/fzf-lua"},
            -- .. or via snacks
            {
              "folke/snacks.nvim",
              opts = {
                terminal = {},
              }
            }
        },
        event = "LspAttach",
        opts = {},
        config = function()
            vim.keymap.set({ "n", "x" }, "<leader>ca", function()
                require("tiny-code-action").code_action({})
                vim.defer_fn(function()
                    vim.api.nvim_input("<Esc>")
                end, 50)
            end, { noremap = true, silent = true })
        end,
    },

    -- mardown preview
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        markdown = {

        }
    },
}
