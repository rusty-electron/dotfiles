-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use({'rose-pine/neovim', as = 'rose-pine' })

	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
	use('mbbill/undotree')
	use('tpope/vim-fugitive')
    use('tpope/vim-commentary')
    use('lukas-reineke/indent-blankline.nvim')
    use('github/copilot.vim')
    use('nvim-tree/nvim-web-devicons')

    use {
        'akinsho/bufferline.nvim',
        tag = '*',
        requires = 'nvim-tree/nvim-web-devicons',
    }

    use {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
            }
        end,
        requires = {'nvim-tree/nvim-web-devicons'}
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-web-devicons', opt = true }
    }

    -- file explorer
    use {
        'stevearc/oil.nvim',
        config = function() require('oil').setup() end
    }

    -- toggleable terminal
    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end}

    -- single plugin for all lsp stuff (for now)
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{'williamboman/mason.nvim'},           -- Optional
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required
		}
	}

    -- nvim sshfs - mount remote filesystems
    use('DanielWeidinger/nvim-sshfs')

    -- c++ stuff
    use('rhysd/vim-clang-format')
    -- debugger
    use('mfussenegger/nvim-dap')
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

    -- zen mode
    use('folke/zen-mode.nvim')
end)
