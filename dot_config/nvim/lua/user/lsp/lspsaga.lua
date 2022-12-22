local status_ok, lspsaga = pcall(require, "lspsaga")
if not status_ok then
	return
end

lspsaga.init_lsp_saga({
	border_style = "rounded",
	code_action_lightbulb = {
		enable = false,
	},
	move_in_saga = { prev = "<Tab>", next = "<S-Tab>" },
	definition_action_keys = {
		edit = "<C-c>o",
		vsplit = "<C-c>v",
		split = "<C-c>x",
		tabe = "<C-c>t",
		quit = "q",
	},
	finder_action_keys = {
		open = { "o", "<CR>" },
		vsplit = "v",
		split = "x",
		tabe = "t",
		quit = { "q", "<ESC>" },
	},
	rename_action_quit = "<ESC>",
})
