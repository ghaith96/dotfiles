local status_ok, neogit = pcall(require, "neogit")
if not status_ok then
	return
end

neogit.setup({
	integrations = {
		diffview = true,
	},
})

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("n", "<leader>gg", function()
	neogit.open({ kind = "split" })
end, opts)

keymap("n", "<leader>gd", ":DiffviewOpen<CR>", opts)
keymap("n", "<leader>gD", ":DiffviewOpen master<CR>", opts)
keymap("n", "<leader>gl", "Neogit log", opts)
keymap("n", "<leader>gp", "Neogit push", opts)

keymap("n", "<leader>gc", function()
	neogit.open({ "commit" })
end, opts)
