local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = false,
	sources = {
		-- node
		-- formatting.prettier_d_slim.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		formatting.eslint_d,
		diagnostics.eslint_d,
		code_actions.eslint_d,

		-- python
		formatting.black.with({ extra_args = { "--fast" } }),
		null_ls.builtins.diagnostics.ruff,
		diagnostics.mypy,

		-- lua
		formatting.stylua,

		-- git
		code_actions.gitsigns,
	},
})
