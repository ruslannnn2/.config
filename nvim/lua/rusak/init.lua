vim.g.mapleader = " "
require("rusak.lazy_init")
require("rusak.remap")
require("rusak.set")

require('telescope').setup{
  defaults = {
    file_ignore_patterns = {
      "node_modules"
    }
  }
}
