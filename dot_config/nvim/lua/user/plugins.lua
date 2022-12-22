local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use({ "wbthomason/packer.nvim", commit = "6afb67460283f0e990d35d229fd38fdc04063e0a" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" }) -- Useful lua functions used by lots of plugins
	use({ "windwp/nvim-autopairs", commit = "9fa996123031b4cad100bd5afad04384a622c8a7" }) -- Autopairs, integrates with both cmp and treesitter
	use({ "windwp/nvim-ts-autotag", commit = "fdefe46c6807441460f11f11a167a2baf8e4534b" })
	use({ "numToStr/Comment.nvim", commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "4d3a68c41a53add8804f471fcc49bb398fe8de08" })
	use({ "kyazdani42/nvim-web-devicons", commit = "563f3635c2d8a7be7933b9e547f7c178ba0d4352" })
	use({ "kyazdani42/nvim-tree.lua", commit = "7282f7de8aedf861fe0162a559fc2b214383c51c" })
	use({ "akinsho/bufferline.nvim", commit = "83bf4dc7bff642e145c8b4547aa596803a8b4dc4" })
	use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
	use({ "nvim-lualine/lualine.nvim", commit = "a52f078026b27694d2290e34efa61a6e4a690621" })
	use({ "lewis6991/impatient.nvim", commit = "9f7eed8133d62457f7ad2ca250eb9b837a4adeb7" })
	use({ "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" })
	use({ "goolord/alpha-nvim", commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31" })
	use({ "folke/which-key.nvim" })
	use({ "folke/trouble.nvim", commit = "897542f90050c3230856bc6e45de58b94c700bbf" })

	-- Colorschemes
	-- use({ "folke/tokyonight.nvim", commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764" })
	-- use({ "lunarvim/darkplus.nvim", commit = "13ef9daad28d3cf6c5e793acfc16ddbf456e1c83" })
	-- use({ "srcery-colors/srcery-vim", commit = "cdb0bc36fda80eb58d38ecddfb1c7b2fab3a4d53", as = "srcery" })
	-- use({ "rose-pine/neovim", as = "rose-pine" })
	-- use({ "ellisonleao/gruvbox.nvim" })
	-- use({ "Yazeed1s/oh-lucy.nvim" })
	-- use({ "rebelot/kanagawa.nvim" })

	-- LIGHT THEMES
	-- use({ "NLKNguyen/papercolor-theme" })
	-- use({ "Shatur/neovim-ayu" })
	-- use({ "mcchrish/zenbones.nvim" })
	-- use({ "sainnhe/everforest" })
	-- use({ "morhetz/gruvbox" })
	-- use({ "sainnhe/everforest" })
	use({ "shaunsingh/nord.nvim" })

	-- Cmp
	use({ "hrsh7th/nvim-cmp", commit = "b0dff0ec4f2748626aae13f011d1a47071fe9abc" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" }) -- buffer completions
	use({ "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", commit = "3cf38d9c957e95c397b66f91967758b31be4abe6" })
	use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })
	use({ "hrsh7th/cmp-nvim-lsp-signature-help", commit = "d2768cb1b83de649d57d967085fe73c5e01f8fd7" })

	-- Snippets
	use({ "L3MON4D3/LuaSnip", commit = "8b25e74761eead3dc47ce04b5e017fd23da7ad7e" }) --snippet engine
	use({ "rafamadriz/friendly-snippets", commit = "2379c6245be10fbf0ebd057f0d1f89fe356bf8bc" }) -- a bunch of snippets to use

	-- LSP
	use({ "neovim/nvim-lspconfig", commit = "cbf8762f15fac03a51eaa2c6f983d4a5045c95b4" }) -- enable LSP
	use({ "williamboman/mason.nvim", commit = "b3c82a23b26818e18e20036452bdcf7821ddc37d" }) -- simple to use language server installer
	use({ "williamboman/mason-lspconfig.nvim", commit = "e8bd50153b94cc5bbfe3f59fc10ec7c4902dd526" })
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "716dec7be9f92a516d968ad534548187384c4089" }) -- for formatters and linters
	use({ "RRethy/vim-illuminate", commit = "a6d0b28ea7d6b9d139374be1f94a16bd120fcda3" })
	use({ "glepnir/lspsaga.nvim", commit = "b7b4777369b441341b2dcd45c738ea4167c11c9e" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", commit = "cabf991b1d3996fa6f3232327fc649bbdf676496" })
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
		commit = "ae9d95da9ff5669eb8e35f758fbf385b3e2fb7cf",
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac",
	})

	-- Git
	use({ "TimUntersberger/neogit", commit = "0d6002c6af432343937283fb70791fc76fa7227c" })
	use({ "sindrets/diffview.nvim", commit = "c6a3d3f1de85bc67b2da62eaf266d4f8cf714fab" })
	use({ "lewis6991/gitsigns.nvim", commit = "903ebbb3e55bd4c3a9f9dd55f9b1d6e54672992e" })

	-- ds - delete surrounding
	-- cs - change surrounding
	-- ys - add surrounding
	use({ "kylechui/nvim-surround", commit = "93380716d94e451c340e653ce09d73e9cabe54c6" })

	-- better f/F/t/T
	use({ "justinmk/vim-sneak", commit = "93395f5b56eb203e4c8346766f258ac94ea81702" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
