---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "chadracula",

	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
}

M.ui = {
  statusline = {
    theme = "default", 
    separator_style = "arrow",
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "lsp", "cwd", "cursor" },
    modules = {
      abc = function()
        return "hi"
      end,

      xyz =  "hi",
      f = "%F"
    }
  },
}
-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

return M
