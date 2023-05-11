--vim.g.base16colorspace=256
--
--vim.g.base16colorsheme='gruvbox-dark-hard'
--vim.g.theprimeagen_colorscheme = "tokyonight"

function color_theme()

    color = color or "tokyonight"

    vim.g.gruvbox_contrast_dark = 'hard'
    vim.g.tokyonight_transparent_sidebar = true
    vim.g.tokyonight_transparent = true
    vim.g.gruvbox_invert_selection = '0'
    vim.opt.background = "dark"

    vim.cmd.colorscheme(color)

end

--color_theme()
