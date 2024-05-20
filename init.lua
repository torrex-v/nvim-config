vim.g.mapleader = " "
vim.g.maplocalleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
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

require("lazy").setup({ import = "plugins" }, {
    change_detection = {
        notify = false,
    },
})

require("config")
-- ColorMyPencils('tokyonight-moon')
ColorMyPencils("gruvbox", false)
-- ColorMyPencils('rose-pine', true)
