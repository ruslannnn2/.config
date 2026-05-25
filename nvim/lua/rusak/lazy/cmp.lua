return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "pyright",
        "clangd",
        "vtsls",
        "eslint",
        "svelte",
      },
      automatic_installation = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      local lsp = vim.lsp
      local blink = require("blink.cmp")
      local capabilities = blink.get_lsp_capabilities()

      lsp.config("lua_ls", {
        capabilities = capabilities,
      })

      lsp.config("pyright", {
        capabilities = capabilities,
      })

      lsp.config("clangd", {
        capabilities = capabilities,
      })

      lsp.config("vtsls", {
        capabilities = capabilities,
      })

      lsp.config("svelte", {
        capabilities = capabilities,
      })

      lsp.config("eslint", {
        capabilities = capabilities,
        settings = {
          workingDirectory = { mode = "location" },
        },
      })

      vim.lsp.enable({ "lua_ls", "pyright", "clangd", "vtsls", "eslint", "svelte" })
    end,
  },

  {
    "saghen/blink.cmp",
    build = "cargo build --release",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "*",
    config = function()
      local blink = require("blink.cmp")
      blink.setup({
        keymap = {
          preset = "default",
          ["<CR>"] = { "accept", "fallback" },
          ["<Tab>"] = { "select_next", "fallback" },
          ["<S-Tab>"] = { "select_prev", "fallback" },
        },
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
}
