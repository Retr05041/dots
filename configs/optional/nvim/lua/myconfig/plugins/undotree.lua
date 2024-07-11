return {
    "mbbill/undotree",

    config = function()
        -- Toggle undo tree
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
}
