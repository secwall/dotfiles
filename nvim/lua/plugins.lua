return {
    {
        "joshdick/onedark.vim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[let g:onedark_color_overrides = {"background": {"gui": "#000000", "cterm": "000", "cterm16": "0" }}]])
            vim.cmd([[colorscheme onedark]])
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        priority = 999,
        opts = {
            options = {
                icons_enabled = true,
                theme = 'onedark',
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'buffers'},
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }
    },
    {
        "preservim/nerdcommenter",
        lazy = false,
    },
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        version = false,
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
        },
        opts = function()
            vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
            local cmp = require("cmp")
            local defaults = require("cmp.config.default")()
            return {
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            local entry = cmp.get_selected_entry()
                            if not entry then
                                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                            else
                                cmp.confirm()
                            end
                        else
                            fallback()
                        end
                    end, {"i","s","c",}),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "buffer" },
                },
                experimental = {
                    ghost_text = {
                        hl_group = "CmpGhostText",
                    },
                },
                sorting = defaults.sorting,
            }
        end,
        config = function(_, opts)
        for _, source in ipairs(opts.sources) do
            source.group_index = source.group_index or 1
        end
            require("cmp").setup(opts)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        init = function(plugin)
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        config = function ()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "cmake",
                    "css",
                    "dockerfile",
                    "go",
                    "gomod",
                    "gowork",
                    "hcl",
                    "html",
                    "http",
                    "javascript",
                    "json",
                    "lua",
                    "make",
                    "markdown",
                    "python",
                    "regex",
                    "rust",
                    "toml",
                    "yaml",
                },
                highlight = {
                    enable = true,
                },
                rainbow = {
                    enable = true,
                    extended_mode = true,
                    max_file_lines = nil,
                },
            })
        end
    },
    {
        "m-demare/hlargs.nvim",
        config = function()
            require('hlargs').setup()
            require('hlargs').enable()
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { 'MysticalDevil/inlay-hints.nvim', opts = {}, },
        },
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            servers = {
                clangd = {
                    root_dir = function(fname)
                        return require("lspconfig.util").root_pattern(
                            "Makefile",
                            "configure.ac",
                            "configure.in",
                            "config.h.in",
                            "meson.build",
                            "meson_options.txt",
                            "build.ninja"
                        )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname) or require("lspconfig.util").find_git_ancestor(fname)
                    end,
                    capabilities = {
                        offsetEncoding = { "utf-16" },
                    },
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "--fallback-style=llvm",
                    },
                    init_options = {
                        usePlaceholders = true,
                        completeUnimported = true,
                        clangdFileStatus = true,
                    },
                    settings = {
                        clangd = {
                            InlayHints = {
                                Designators = true,
                                Enabled = true,
                                ParameterNames = true,
                                DeducedTypes = true,
                            }
                        },
                    },
                    on_attach = function(client, bufnr)
                        if client.server_capabilities.inlayHintProvider then
                            require("inlay-hints").on_attach(client, bufnr)
                        end
                    end,
                },
                gopls = {
                    settings = {
                        gopls = {
                            analyses = {
                                nilness = true,
                                unusedparams = true,
                                unusedwrite = true,
                                useany = true,
                            },
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                            experimentalPostfixCompletions = true,
                            gofumpt = true,
                            staticcheck = true,
                            usePlaceholders = true,
                        },
                    },
                    on_attach = function(client, bufnr)
                        if client.server_capabilities.inlayHintProvider then
                            require("inlay-hints").on_attach(client, bufnr)
                        end
                    end,
                },
                pylsp = {
                    settings = {
                        pylsp = {
                            plugins = {
                                autopep8 = {
                                    enabled = false
                                },
                                flake8 = {
                                    enabled = true
                                },
                                pylint = {
                                    enabled = true
                                },
                                pycodestyle = {
                                    maxLineLength = 120
                                },
                            },
                        },
                    },
                },
            },
        },
        config = function(_, opts)
            local servers = opts.servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            for server, server_opts in pairs(servers) do
                local opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, server_opts)

                require("lspconfig")[server].setup(opts)
            end
        end,
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^3',
        dependencies = {
            { 'MysticalDevil/inlay-hints.nvim', opts = {}, },
        },
        ft = { 'rust' },
        opts = {
            server = {
                on_attach = function(client, bufnr)
                    require("inlay-hints").on_attach(client, bufnr)
                end,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                            loadOutDirsFromCheck = true,
                            runBuildScripts = true,
                        },
                        checkOnSave = {
                            allFeatures = true,
                            command = "clippy",
                            extraArgs = { "--no-deps" },
                        },
                        procMacro = {
                            enable = true,
                            ignored = {
                                ["async-trait"] = { "async_trait" },
                                ["napi-derive"] = { "napi" },
                                ["async-recursion"] = { "async_recursion" },
                            },
                        },
                    },
                },
            },
        },
        config = function(_, opts)
            vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        version = false,
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                enabled = vim.fn.executable("make") == 1,
                config = function()
                    require("telescope").load_extension("fzf")
                end,
            },
        },
        keys = {
            { "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<CR>", desc = "Switch Buffer" },
            { "<leader><space>", "<cmd>Telescope find_files<CR>", desc = "Files" },
            { "<leader>/", "<cmd>Telescope live_grep<CR>", desc = "Grep" },
            { "<leader>:", "<cmd>Telescope command_history<CR>", desc = "Command History" },
            { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git commits" },
            { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git status" },
            { "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>", desc = "LSP symbols" },
        },
    },
}
