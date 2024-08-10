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
      harpoon:setup()
      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      vim.keymap.set('n', '<C-e>', function()
        toggle_telescope(harpoon:list())
      end, { desc = 'Open harpoon window' })
      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
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
          theme = 'dracula-nvim',
        },
        sections = {
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
}
