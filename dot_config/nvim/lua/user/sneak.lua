local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Sneak
keymap("n", "f", "<Plug>Sneak_f", opts)
keymap("n", "F", "<Plug>Sneak_F", opts)
keymap("n", "t", "<Plug>Sneak_t", opts)
keymap("n", "T", "<Plug>Sneak_T", opts)
