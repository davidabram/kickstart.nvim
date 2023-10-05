-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'ThePrimeagen/harpoon',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = true,
    keys = {
      { "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>",        desc = "Mark file with harpoon" },
      { "<C-e>",     "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Show harpoon marks" },
    },
  },
  {
    'github/copilot.vim',
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
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      opts = true
    },
    config = function()
      local function harpoon_component()
        local mark_idx = require("harpoon.mark").get_current_index()
        if mark_idx == nil then
          return ""
        end

        return string.format("󱡅 %d", mark_idx)
      end

      require("lualine").setup({
        options = {
          theme = 'auto',
        },
        sections = {
          lualine_b = {
            { "branch", icon = "", fmt = truncate_branch_name },
            { harpoon_component },
            "diff",
            "diagnostics",
          },
          lualine_c = {
            { "filename", path = 1 },
          },
        },
      })
    end,
  },
}
