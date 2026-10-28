local width = 80

local function apply(buf)
    local options = vim.bo[buf]
    options.textwidth = width

    local formatoptions = options.formatoptions:gsub("t", "")
    options.formatoptions = width > 0 and (formatoptions .. "t") or formatoptions
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function(args)
        apply(args.buf)
    end,
})

local function set_width(value)
    if value == "off" then
        width = 0
    else
        local number = tonumber(value)
        if not number or number < 1 or number % 1 ~= 0 then
            vim.notify("MarkdownWrap: use a positive width or 'off'", vim.log.levels.ERROR)
            return
        end
        width = number
    end

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == "markdown" then
            apply(buf)
        end
    end
end

vim.api.nvim_create_user_command("MarkdownWrap", function(args)
    if args.args ~= "" then
        set_width(args.args)
        return
    end

    vim.ui.input({ prompt = "Markdown wrap width (or off): ", default = width == 0 and "off" or tostring(width) }, function(value)
        if value and value ~= "" then
            set_width(value)
        end
    end)
end, { nargs = "?", complete = function() return { "off", "80", "100", "120" } end,
    desc = "Set the hard-wrap width for Markdown buffers, or disable it" })
