require('lint').linters_by_ft = {
    markdown = {'vale'},
    typst = {'vale'},
}

vim.api.nvim_create_autocmd({"InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
