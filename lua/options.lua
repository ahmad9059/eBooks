require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
vim.opt.relativenumber = true

-- Global border style for all LSP floating windows (hover, signature help, diagnostics, etc.)
-- Replaces the deprecated vim.lsp.with() handler override pattern
vim.o.winborder = "rounded"
