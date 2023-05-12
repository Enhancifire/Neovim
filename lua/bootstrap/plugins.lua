local present, packer = pcall(require, "packer")

local packer_init = function()
	return {
		auto_clean = true,
		compile_on_sync = true,
		git = { clone_timeout = 6000 },
		display = {
			working_sym = "ﲊ",
			error_sym = "✗ ",
			done_sym = " ",
			removed_sym = " ",
			moved_sym = "",
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	}
end

if present then
	vim.cmd("packadd packer.nvim")
	local init_options = packer_init()
	packer.init(init_options)
	packer.startup(function()
		-- Packer can manage itself
		use({
			"wbthomason/packer.nvim"
		})

		-- Help with Nvim Lua
		use({
			"tjdevries/nlua.nvim"
		})


		-- Debugger and Debugging
		use({
			{
				"mfussenegger/nvim-dap",
				config = function()
					require("dev.debugger")
				end,
			},
			{
				"rcarriga/nvim-dap-ui"
			},
			{
				"mfussenegger/nvim-dap-python"
			},

			{
				"theHamsta/nvim-dap-virtual-text"
			},

			{
				"nvim-telescope/telescope-dap.nvim",
				after = "telescope.nvim",
				config = function()
					require("telescope").load_extension("dap")
				end,
			},
		})



		-- Mason, Null LS and LSP
		use({
			{
				"williamboman/mason.nvim"
			},
			{
				"williamboman/mason-lspconfig.nvim"
			},
			{
				"jayp0521/mason-null-ls.nvim"
			},
		})

		use({
			{
				"neovim/nvim-lspconfig"
			},
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = "require('lsp.null-ls-config')",
			},


			{
				"tami5/lspsaga.nvim",
				branch = "nvim6.0",
			},

			{ "onsails/lspkind-nvim" },
			{
				"j-hui/fidget.nvim",
				config = "require('fidget').setup()",
			},
		})

		-- Everything CMP
		use({
			{
				"hrsh7th/nvim-cmp",
				event = "BufWinEnter",
				config = "require('lsp/cmp-config')",
			},


			{
				"hrsh7th/cmp-nvim-lsp"
			},
			{
				"hrsh7th/cmp-buffer",
				after = "nvim-cmp",
			},
			{
				"hrsh7th/cmp-nvim-lua",
				after = "nvim-cmp",
			},
			{
				"hrsh7th/cmp-path",
				after = "nvim-cmp",
			},
			{
				"hrsh7th/cmp-cmdline",
				after = "nvim-cmp",
			},
			{
				"hrsh7th/cmp-vsnip",
				after = "nvim-cmp",
			},
			{
				"hrsh7th/vim-vsnip",
				after = "nvim-cmp",
			},
			{
				"saadparwaiz1/cmp_luasnip",
				after = "nvim-cmp",
			},
		})


		-- FZF: Searching through the files
		use({
			"junegunn/fzf.vim",
			event = "BufWinEnter",
		})


		-- Treesitter: The Essential Part of Neovim PDE
		use({
			{
				"nvim-treesitter/nvim-treesitter",
				run = ":TSUpdate",
				config = function()
					require("lsp.tsconfig")
				end,
			},

			{
				"nvim-treesitter/playground",
				event = "BufRead",
			},
		})

		-- Keybindings
		use({
			-- WhichKey: Defining and Showing Hotkeys
			{ "folke/which-key.nvim" },

			-- Hydra: For epic and quick vim usage
			{
				"anuvyklack/hydra.nvim",
				requires = "anuvyklack/keymap-layer.nvim", -- needed only for pink hydras
			},

			-- Command Pallette
			{ "mrjones2014/legendary.nvim" },

		})

		-- Flutter Development
		use({
			"akinsho/flutter-tools.nvim",
			requires = "nvim-lua/plenary.nvim",
			after = "telescope.nvim",
			config = "require('dev.flutter')",
		})

		-- Dispatch: To Quickly Build
		use({
			{
				"tpope/vim-dispatch",
				opt = true,
				cmd = { "Dispatch", "Make", "Focus", "Start" },
				event = "BufWinEnter",
			},
			{
				"radenling/vim-dispatch-neovim"
			},
		})

		use({
			"olimorris/persisted.nvim",
			config = function()
				require("persisted").setup()
			end,
		})

		-- Go Through Matching Text
		use({
			"andymass/vim-matchup",
			event = "BufWinEnter",
		})

		-- Checking the Starup Time for Neovim
		use({ "tweekmonster/startuptime.vim" })

		-- For Markdown Previews
		use({
			"iamcco/markdown-preview.nvim",
			run = "cd app && yarn install",
			cmd = "MarkdownPreview",
			event = "BufWinEnter",
		})

		-- Devicons
		use({ "kyazdani42/nvim-web-devicons" })

		-- Nvim-Tree-Lua
		use({
			"kyazdani42/nvim-tree.lua",
			cmd = "NvimTreeToggle",
			config = "require('dev.tree')",
		})

		-- Snippets
		use({
			"honza/vim-snippets",
			event = "BufWinEnter",
		})
		use({
			"sirver/ultisnips",
			event = "BufWinEnter",
		})
		use({ "cstrap/flask-snippets" })
		use({
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		})

		-- CSS Color Preview
		use({
			"uga-rosa/ccc.nvim",
			config = "require('dev.colorizer-config')",
			event = "BufWinEnter",
		})

		-- Telescope
		use({ "nvim-lua/plenary.nvim" })
		use({ "nvim-lua/popup.nvim" })
		use({
			"nvim-telescope/telescope.nvim",
			config = "require('telescope-config')",
		})

		-- use({
		-- 	"nvim-telescope/telescope-fzf-native.nvim",
		-- 	run = "make",
		-- 	config = function()
		-- 		require("telescope").load_extension("fzf")
		-- 	end,
		-- 	after = "telescope.nvim",
		-- })

		use({
			"nvim-telescope/telescope-media-files.nvim",
			after = "telescope.nvim",
			config = function()
				require("telescope").load_extension("media_files")
			end,
		})
		-- use({
		-- 	"nvim-telescope/telescope-packer.nvim",
		-- 	config = function()
		-- 		require("telescope").load_extension("packer")
		-- 	end,
		-- 	after = "telescope.nvim",
		-- })
		use({
			"nvim-telescope/telescope-file-browser.nvim",
			config = function()
				require("telescope").load_extension("file_browser")
			end,
			after = "telescope.nvim",
		})
		-- use({
		-- 	"nvim-telescope/telescope-arecibo.nvim",
		-- 	-- rocks = { "openssl", "lua-http-parser" },
		-- 	config = function()
		-- 		require("telescope").load_extension("arecibo")
		-- 		require("telescope").setup({
		-- 			extensions = {

		-- 				arecibo = {
		-- 					["selected_engine"] = "google",
		-- 					["url_open_command"] = "xdg-open",
		-- 					["show_http_headers"] = false,
		-- 					["show_domain_icons"] = false,
		-- 				},
		-- 			},
		-- 		})
		-- 	end,
		-- 	after = "telescope.nvim",
		-- })

		-- Marks Navigation
		use({
			"theprimeagen/harpoon",
			config = function()
				require("dev.harpoon-config")
			end,
			event = "BufWinEnter",
		})

		-- -- Statusline
		-- use({
		-- 	"tamton-aquib/staline.nvim",
		-- 	requires = { "kyazdani42/nvim-web-devicons", opt = true },
		-- 	-- config = "require('statline-config')"
		-- })

		-- Tabline
		use({
			"romgrk/barbar.nvim",
		})

		use({
			"glepnir/galaxyline.nvim",
			branch = "main",
		})

		-- Treesitter plugins
		use({
			"windwp/nvim-ts-autotag",
			after = "nvim-treesitter",
		})
		use({
			"junegunn/rainbow_parentheses.vim",
			event = "BufWinEnter",
		})

		-- Dashboard
		use({
			"glepnir/dashboard-nvim",
			event = "VimEnter",
			config = function()
				require('appearance.dashboard')
			end
		})

		-- Git Signs
		use({
			"lewis6991/gitsigns.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
			},
			config = function()
				require("gitsigns").setup({
					current_line_blame = false,
				})
			end,
		})

		-- Neogit: A Magit Clone
		use({
			"TimUntersberger/neogit",
			config = function()
				require("dev.git")
			end,
		})

		-- Appearance--
		-- Indent Guides
		use({
			"lukas-reineke/indent-blankline.nvim",
			event = "BufRead",
			config = function()
				require("appearance.indents")
			end,
		})

		-- Fancy UI

		-- use({ "MunifTanjim/nui.nvim" })

		use({
			"stevearc/dressing.nvim",
			event = "VimEnter",
			config = function()
				require("appearance.ui.dressing-config")
			end,
		})

		-- use({
		-- 	"folke/noice.nvim",
		-- 	event = "VimEnter",
		--
		-- 	config = function()
		-- 		require("appearance.ui.noice-config")
		-- 	end,
		-- })

		use({
			"rcarriga/nvim-notify",
		})

		-- use({
		-- 	"gorbit99/codewindow.nvim",
		-- 	config = function()
		-- 		require("appearance.ui.minimap")
		-- 	end,
		-- 	event = "BufWinEnter",
		-- })

		-- use({
		-- 	"rainbowhxch/beacon.nvim",
		-- 	config = function()
		-- 		require("appearance.ui.flasher")
		-- 	end,
		-- 	event = "BufRead",
		-- })

		use({
			"xiyaowong/nvim-transparent",
			config = function()
				require("appearance.ui.transparent_config")
			end,
		})

		-- Themes
		use({
			{
				"catppuccin/nvim",
				as = "catppuccin",
			},
			{
				"rose-pine/neovim",
				as = "rose-pine",
			},
			{
				"tiagovla/tokyodark.nvim",
			},
			-- {
			-- 	"dracula/vim",
			-- 	as = "dracula",
			-- },
			-- {
			-- 	"ellisonleao/gruvbox.nvim",
			-- },
			-- {
			-- 	"joshdick/onedark.vim",
			-- },
			-- {
			-- 	"sainnhe/everforest",
			-- },
			-- {
			-- 	"sainnhe/sonokai",
			-- },
			-- {
			-- 	"sainnhe/gruvbox-material",
			-- },
		})

		-- Embedded Terminal
		use({
			"akinsho/toggleterm.nvim",
			config = "require('toggleterm-config')",
		})

		-- Comments
		use({
			"numToStr/Comment.nvim",
			event = "BufWinEnter",
			config = function()
				require("dev.comment-config")
			end,
		})

		-- Autopairs
		use({
			"windwp/nvim-autopairs",
			wants = "nvim-treesitter",
			module = {
				"nvim-autopairs.completion.cmp",
				"nvim-autopairs",
			},
			config = "require('lsp.autopairs-config')",
			after = "nvim-cmp",
		})

		-- Hopper for Hopping through the Code
		-- use({
		-- 	"phaazon/hop.nvim",
		-- 	branch = "v1", -- optional but strongly recommended
		-- 	config = function()
		-- 		require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		-- 	end,
		-- 	event = "BufWinEnter",
		-- })


		-- Wakatime: Keeping Track of your Coding Progress
		use({
			"wakatime/vim-wakatime",
		})

		use({
			"folke/lsp-colors.nvim",
			config = function()
				require("lsp.color-config")
			end,
			event = "BufWinEnter",
		})



		use({
			"folke/trouble.nvim",
			config = "require('lsp.trouble-config')",
			-- event = "BufWinEnter",
		})

		-- use({
		-- 	"sotte/presenting.vim",
		-- 	event = "BufRead",
		-- })

		-- Code Structure Navigation
		use({
			"stevearc/aerial.nvim",
			config = "require('dev.aerial-config')",
			event = "BufWinEnter",
		})

		-- Zen/Presentation Mode
		-- use({
		-- 	{
		-- 		"folke/twilight.nvim",
		-- 		config = "require('appearance.zen.twilight-config')",
		-- 		event = "BufWinEnter",
		-- 	},
		-- 	{
		-- 		"folke/zen-mode.nvim",
		-- 		config = "require('appearance.zen.mode')",
		-- 		event = "BufWinEnter",
		-- 	},
		-- })


		use({
			"simnalamburt/vim-mundo",
			event = "BufWinEnter",
		})

		use({
			"aserowy/tmux.nvim",
			config = function()
				require("tmux").setup({
					copy_sync = {
						enable = true,
						redirect_to_clipboard = true,
					},
					navigation = {
						enable_default_keybindings = true,
					},
					resize = {
						enable_default_keybindings = true,
					},
					sync_clipboard = true,
				})
			end,
		})

		use({
			"epwalsh/obsidian.nvim",
			config = function()
				require("notes.obsidian")
			end,
		})

		-- AI Tools
		-- Almighty Github Copilot
		use({
			"github/copilot.vim",
		})

	end)
end