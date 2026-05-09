require "nvchad.autocmds"

-- Disable folding specifically in kulala's floating response window
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "http", "rest" },
  callback = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      buffer = vim.api.nvim_get_current_buf(),
      callback = function()
        local cfg = vim.api.nvim_win_get_config(vim.api.nvim_get_current_win())
        if cfg.relative ~= "" then
          vim.wo.foldenable = false
        end
      end,
    })
  end,
})

-- Treat .env, .env.local, .env.production etc. as sh for syntax highlighting
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".env", ".env.*", "*.env" },
  callback = function()
    vim.bo.filetype = "sh"
  end,
})

-- Detect docker-compose files so docker_compose_language_service LSP attaches correctly
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "docker-compose*.yml",
    "docker-compose*.yaml",
    "compose*.yml",
    "compose*.yaml",
  },
  callback = function()
    vim.bo.filetype = "yaml.docker-compose"
  end,
})
