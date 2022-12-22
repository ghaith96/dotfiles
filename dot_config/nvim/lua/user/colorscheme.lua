vim.o.termguicolors = true
-- vim.o.background = "light"
-- vim.g.everforest_better_performance = 1
-- vim.g.everforest_background = "soft"
-- vim.g.gruvbox_contrast_light = "hard"

local nord_status_ok, nord = pcall(require, "nord")
if nord_status_ok then
	vim.g.nord_borders = true

	nord.set()
end

local colorscheme = "nord"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end
