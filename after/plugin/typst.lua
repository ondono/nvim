local typst_group = vim.api.nvim_create_augroup("xavi-typst", { clear = true })

local function typst_pdf_for_current_buffer()
    if vim.bo.filetype == "typst" then
        return vim.fn.expand("%:r") .. ".pdf"
    end

    return vim.api.nvim_buf_get_name(0)
end

vim.api.nvim_create_user_command("TypstOpenPdf", function()
    vim.fn.jobstart({ "zathura", typst_pdf_for_current_buffer() }, { detach = true })
end, {
    desc = "Open the current Typst PDF in zathura",
})

vim.g.typst_auto_open_quickfix = false
vim.api.nvim_create_user_command("TypstWatchBuffer", function()
    if vim.b.typst_watch_started then
        return
    end

    vim.b.typst_watch_started = true
    vim.cmd("TypstWatch")
end, {
    desc = "Start TypstWatch once for the current buffer",
})

vim.api.nvim_create_autocmd("FileType", {
    group = typst_group,
    pattern = "typst",
    callback = function(args)
        vim.keymap.set("n", "<leader>tw", "<cmd>TypstWatchBuffer<cr>", { buffer = args.buf, desc = "Watch Typst buffer" })
        vim.keymap.set("n", "<leader>tp", "<cmd>TypstOpenPdf<cr>", { buffer = args.buf, desc = "Open Typst PDF" })
    end,
})
