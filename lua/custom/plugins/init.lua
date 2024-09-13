-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.keymap.set('n', '-', vim.cmd.Ex)

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.list = true
vim.opt.listchars:append 'space:⋅'
vim.opt.listchars:append 'eol:↴'

vim.opt.signcolumn = 'yes'
vim.opt.isfname:append '@-@'
vim.opt.wrap = false
vim.opt.termguicolors = true

vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

vim.keymap.set('n', 'Q', '<nop>')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

local lspconfig = require 'lspconfig'
lspconfig.gleam.setup {}

return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup {}
      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = 'M[a]n the harpoons!' })
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
    end,
  },
  {
    -- Theme inspired by Atom
    'Mofiqul/dracula.nvim',
    priority = 1,
    config = function()
      vim.cmd.colorscheme 'dracula'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          theme = 'auto',
        },
        sections = {
          lualine_a = {
            'mode',
          },
          lualine_b = {
            { 'branch', icon = 'þ' },
            'diff',
          },
          lualine_c = {
            { 'filename', path = 1 },
          },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {
            'location',
          },
        },
      }
    end,
  },
  {
    'davidmh/mdx.nvim',
    config = true,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = false, auto_trigger = true },
        panel = { enabled = false },
      }
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  },
  { 'numToStr/Comment.nvim', opts = {} },
  { 'tpope/vim-fugitive' },
}
