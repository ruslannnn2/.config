return {
  {
    "mason-org/mason.nvim",
    init = function()
      local shim_dir = vim.fn.stdpath("data") .. "/mason-pnpm-shim"
      local shim = shim_dir .. "/npm"
      vim.fn.mkdir(shim_dir, "p")
      local f = assert(io.open(shim, "w"))
      f:write([[#!/usr/bin/env bash
args=()
for arg in "$@"; do
  case "$arg" in
    --include=dev|--silent|--no-audit|--no-fund|--no-package-lock|--no-save|--global-style|--install-strategy=*|--legacy-peer-deps|--yes|-y|--scope=*)
      ;;
    *)
      args+=("$arg")
      ;;
  esac
done
pnpm "${args[@]}"
rc=$?
# Mason invokes us from a staging dir, then moves the package to mason/packages/.
# pnpm's cmd-shim bins derive $basedir from $0, which after the move resolves to
# the symlink at mason/bin/ rather than the real script — so $basedir/.. points
# at the wrong place. Patch the bins to resolve $0 through symlinks instead.
if [ $rc -eq 0 ] && [ "${args[0]:-}" = "install" ] && [ -d node_modules/.bin ]; then
  for shim in node_modules/.bin/*; do
    [ -f "$shim" ] && [ ! -L "$shim" ] || continue
    sed -i 's|^basedir=.*$|basedir=$(dirname "$(readlink -f "$0")")|' "$shim"
  done
fi
exit $rc
]])
      f:close()
      vim.loop.fs_chmod(shim, 493)
      if not vim.env.PATH:find(shim_dir, 1, true) then
        vim.env.PATH = shim_dir .. ":" .. vim.env.PATH
      end
    end,
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "pyright",
        "vtsls",
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
