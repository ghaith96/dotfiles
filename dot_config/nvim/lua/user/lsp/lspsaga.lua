local status_ok, lspsaga = pcall(require, "lspsaga")
if not status_ok then
	return
end

lspsaga.init_lsp_saga({
	border_style = "rounded",
	code_action_lightbulb = {
		virtual_text = false,
	},
})
