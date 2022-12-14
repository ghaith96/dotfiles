local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
-- M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = {
			severity = vim.diagnostic.severity.ERROR,
			spacing = 4,
			prefix = "●",
		},
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
		update_in_insert = false,
		virtual_text = { severity = vim.diagnostic.severity.ERROR, spacing = 4, prefix = "●" },
		severity_sort = true,
	})

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap

	keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

	-- conflict with window jumping
	-- keymap(bufnr, "n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)

	keymap(bufnr, "n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
	keymap(bufnr, "i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", opts)
	keymap(bufnr, "n", "gd", "<Cmd>Lspsaga peek_definition<CR>", opts)
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
	keymap(bufnr, "n", "gh", "<Cmd>Lspsaga lsp_finder<CR>", opts)

	keymap(bufnr, "n", "<leader>la", "<cmd>Lspsaga code_action<CR>", opts)
	keymap(bufnr, "v", "<leader>la", "<cmd>Lspsaga code_action<CR>", opts)

	-- Diagnsotic jump can use `<c-o>` to jump back
	keymap(bufnr, "n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	keymap(bufnr, "n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

	-- Only jump to error
	vim.keymap.set("n", "[E", function()
		require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, opts)
	vim.keymap.set("n", "]E", function()
		require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, opts)

	-- Outline
	keymap(bufnr, "n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })

	-- keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	-- keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	-- keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	-- keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	-- keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	-- keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	-- keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
	-- keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
	-- keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
	-- keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	-- keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
	-- keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=1})<cr>", opts)
	-- keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	-- keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	-- keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

local illuminate_status_ok, illuminate = pcall(require, "illuminate")

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "sumneko_lua" then
		client.server_capabilities.documentFormattingProvider = false
	end

	lsp_keymaps(bufnr)

	if illuminate_status_ok then
		illuminate.on_attach(client)
	end
end

return M
