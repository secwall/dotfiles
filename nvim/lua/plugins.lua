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
        "vim-airline/vim-airline",
        lazy = false,
        priority = 999,
        config = function()
            vim.cmd([[let g:airline_theme='onedark']])
        end,
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
                            experimentalPostfixCompletions = true,
                            gofumpt = true,
                            staticcheck = true,
                            usePlaceholders = true,
                        },
                    },
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
            for server, server_opts in pairs(servers) do
                require("lspconfig")[server].setup(server_opts)
            end
        end,
    },
}
