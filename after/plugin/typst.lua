-- open pdfs in zathura
vim.cmd([[autocmd BufEnter *.pdf execute "!zathura '%'" | bdelete %]])

-- run watch on filetype typst
vim.g.typst_auto_open_quickfix = false
vim.cmd([[autocmd BufEnter *.typ execute "TypstWatch"]])

