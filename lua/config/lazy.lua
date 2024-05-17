local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.uv = vim.uv or vim.loop
if not vim.loop.fs_stat(lazypath) then
  vim.uv.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
-- Add lazy to the `runtimepath`, this allows us to `require` it.
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ import = "plugins"},{
     change_detection = {
    notify = false,
  },
})
