-- (method 1, For heavy lazyloaders)
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- (method 2, for non lazyloaders) to load all highlights at once
-- for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
-- 	dofile(vim.g.base46_cache .. v)
-- end
