local M = {}

function M.open_url()
  local line = vim.api.nvim_get_current_line()
  local url = string.match(line, "https?://[%w-_%.%?%.:/%+=&]+")
  if url then
    vim.fn.system("open " .. url)
    vim.api.nvim_out_write("Opening URL: " .. url .. "\n")
  else
    vim.api.nvim_err_writeln("No URL found on the current line")
  end
end

return M
