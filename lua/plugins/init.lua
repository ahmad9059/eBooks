return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" }, -- load only when a file is about to be opened
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Lua LSP workspace awareness (replaces manual vim.api.nvim_get_runtime_file)
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {},
  },

  -- Lazygit integration in Neovim
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- VS Code-like template string converter
  {
    "axelvc/template-string.nvim",
    ft = {
      "html",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "vue",
      "svelte",
      "python",
      "cs",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("template-string").setup {
        filetypes = {
          "html",
          "typescript",
          "javascript",
          "typescriptreact",
          "javascriptreact",
          "vue",
          "svelte",
          "python",
          "cs",
        },
        jsx_brackets = true,
        remove_template_string = false,
        restore_quotes = {
          normal = [['']],
          jsx = [[""]],
        },
      }
    end,
  },

  -- UI enhancement: Replace vim.ui.select with Telescope dropdown
  {
    "nvim-telescope/telescope-ui-select.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      -- Load the extension only; telescope is already configured by NvChad.
      -- Calling require("telescope").setup() here would overwrite NvChad's settings.
      require("telescope").load_extension "ui-select"
    end,
  },

  -- Auto-close & rename HTML/JSX tags using Treesitter
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-ts-autotag").setup {
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
      }
    end,
  },

  -- Markdown rendering and preview
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim",
    },
    opts = {},
  },

  -- HTTP REST client for testing Node.js/Express API endpoints (.http files)
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    opts = {
      display_mode = "float",
      ui = {
        win_opts = {
          border = "rounded",
          height = math.floor(vim.o.lines * 0.85),
          row = 1,
        },
      },
    },
  },

  -- Neovim Tmux Navigation
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },

  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      dofile(vim.g.base46_cache .. "whichkey")
      return {
        preset = "helix",
      }
    end,
  },

  -- blink completion
  { import = "nvchad.blink.lazyspec" },

  {
    "saghen/blink.cmp",
    opts = {
      enabled = function()
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local line = vim.api.nvim_get_current_line()
        local char_before = line:sub(col, col)
        local char_after = line:sub(col + 1, col + 1)
        -- suppress completion inside empty {} so Enter expands braces normally
        if char_before == "{" and char_after == "}" then
          return false
        end
        -- suppress completion immediately after a closing }
        if char_before == "}" then
          return false
        end
        return true
      end,
      sources = {
        providers = {
          snippets = { score_offset = 7 },
        },
      },
      completion = {
        menu = { border = "rounded" },
        documentation = { window = { border = "rounded" } },
      },
      signature = { enabled = true, window = { border = "rounded" } },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    -- CRITICAL: main branch is required for Neovim 0.12+ (tree-sitter 0.25).
    -- The old master branch explicitly does NOT support Neovim 0.12.
    branch = "main",
    build = ":TSUpdate | TSInstallAll",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "luadoc",
        "vimdoc",
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "jsonc",
        "yaml",
        "dockerfile",
        "graphql",
        "prisma",
        "markdown",
        "markdown_inline",
        "c",
        "cpp",
      },
      auto_install = true,
    },
  },
}
