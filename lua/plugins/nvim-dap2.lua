return {
	{ "nvim-lua/popup.nvim" },
	{ "nvim-neotest/nvim-nio" },
	{ "nvim-lua/plenary.nvim" },
	{
		"tomblind/local-lua-debugger-vscode",
		config = function() end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
			"tomblind/local-lua-debugger-vscode",
			"leoluz/nvim-dap-go",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"mxsdev/nvim-dap-vscode-js",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
            -- DAP Configuration for .NET WebAPI, JavaScript, C, C++ on Windows

-- Core dependencies (ensure these are in your plugin manager):
-- 'mfussenegger/nvim-dap'
-- 'rcarriga/nvim-dap-ui'
-- 'nvim-neotest/nvim-nio'
-- 'nvim-lua/plenary.nvim'
-- 'mxsdev/nvim-dap-vscode-js'
-- 'theHamsta/nvim-dap-virtual-text'
-- 'williamboman/mason.nvim'

local dap = require("dap")
local dapui = require("dapui")

-- ============================================================================
-- UI Setup
-- ============================================================================
dapui.setup()

-- Auto-open/close UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- ============================================================================
-- Virtual Text (with secret redaction)
-- ============================================================================
require("nvim-dap-virtual-text").setup({
  display_callback = function(variable, buf, stackframe, node, options)
    local value = variable.value
    if #value > 50 then
      value = string.sub(value, 1, 50) .. "..."
    end
    if string.match(value:lower(), "secret") or string.match(value:lower(), "api") then
      value = "[REDACTED]"
    end
    return " = " .. value
  end,
})

-- ============================================================================
-- C# / .NET WebAPI Debugging (netcoredbg)
-- ============================================================================
dap.adapters.coreclr = {
  type = "executable",
  command = "C:/tools/netcoredbg/netcoredbg.exe",
  args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
      local cwd = vim.fn.getcwd()
      local dll = vim.fn.glob(cwd .. "/bin/Debug/**/*.dll")
      if dll == "" then
        dll = vim.fn.glob(cwd .. "/bin/Release/**/*.dll")
      end
      if dll == "" then
        return vim.fn.input("Path to dll: ", cwd .. "/bin/Debug/", "file")
      end
      return dll
    end,
  },
  {
    type = "coreclr",
    name = "launch webapi",
    request = "launch",
    program = function()
      local cwd = vim.fn.getcwd()
      local dll = vim.fn.glob(cwd .. "/bin/Debug/**/*.dll")
      if dll == "" then
        dll = vim.fn.glob(cwd .. "/bin/Release/**/*.dll")
      end
      if dll == "" then
        return vim.fn.input("Path to dll: ", cwd .. "/bin/Debug/", "file")
      end
      return dll
    end,
    env = {
      ASPNETCORE_ENVIRONMENT = "Development",
      ASPNETCORE_URLS = "http://localhost:5000",
    },
  },
  {
    type = "coreclr",
    name = "attach - netcoredbg",
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
}

-- ============================================================================
-- JavaScript/TypeScript Debugging
-- ============================================================================
require("dap-vscode-js").setup({
  debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
  adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
})

for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Launch Chrome",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
    },
  }
end

-- ============================================================================
-- C/C++ Debugging (codelldb)
-- ============================================================================
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.exepath("codelldb"), -- Install via Mason or add to PATH
    args = { "--port", "${port}" },
  },
}

dap.configurations.c = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
  {
    name = "Attach to process",
    type = "codelldb",
    request = "attach",
    pid = require("dap.utils").pick_process,
  },
}

dap.configurations.cpp = dap.configurations.c

-- ============================================================================
-- Lua Debugging (local-lua-debugger-vscode)
-- ============================================================================
dap.adapters["local-lua"] = {
  type = "executable",
  command = "node",
  args = {
    vim.fn.stdpath("data") .. "/lazy/local-lua-debugger-vscode/extension/debugAdapter.js",
  },
  enrich_config = function(config, on_config)
    if not config["extensionPath"] then
      local c = vim.deepcopy(config)
      c.extensionPath = vim.fn.stdpath("data") .. "/lazy/local-lua-debugger-vscode/"
      on_config(c)
    else
      on_config(config)
    end
  end,
}

dap.configurations.lua = {
  {
    name = "Current file (local-lua-dbg, lua)",
    type = "local-lua",
    request = "launch",
    cwd = "${workspaceFolder}",
    program = {
      lua = "lua",
      file = "${file}",
    },
    args = {},
  },
}

-- ============================================================================
-- Go
        end
	},
}
