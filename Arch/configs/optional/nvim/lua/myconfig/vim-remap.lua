-- Remake / set keymaps 
vim.g.mapleader = " "

-- Open file explorer faster
vim.keymap.set("n", "<leader>t", vim.cmd.Ex)

-- Copy to and from clipboard
vim.keymap.set({"n", "v"}, "<leader>gy", '"+y<CR>', { noremap = true, silent = true })
vim.keymap.set({"n", "v"}, "<leader>gp", '"+p<CR>', { noremap = true, silent = true })

-- Open snippets file for current extension type
vim.keymap.set("n", "<leader>e", ":lua require(\"luasnip.loaders\").edit_snippet_files()<CR>", { noremap = true, silent = true})

-- LSP stuff
vim.keymap.set("n", "F", vim.lsp.buf.format, {})
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
        
-- Make this file an executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {silent = true})
