-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"
require "configs.clipboard"

-- load plugins
require("lazy").setup({
  { import = "plugins" },
}, lazy_config)

require "options"
require "autocmds"
require "configs.lspconfig"

vim.schedule(function()
  require "mappings"
end)
