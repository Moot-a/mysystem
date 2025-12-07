-----------------------------------------------------------
-- Basic settings
-----------------------------------------------------------
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Use system clipboard (Wayland: needs wl-clipboard)
opt.clipboard = "unnamedplus"

-- True color
opt.termguicolors = true

-- Global: no wrapping anywhere
opt.wrap = false

-- Global: 4-space indentation by default
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true

-- indentation and matching
opt.smartindent = true
opt.showmatch = true

-- Backspace behavior
opt.backspace = {"indent", "eol", "start"}

-----------------------------------------------------------
-- Open URLs in browser (gx / netrw)
-----------------------------------------------------------

-- netrw browser setup
vim.g.netrw_browsex_viewer = "xdg-open"
vim.g.netrw_browsex_handler = function(url)
    vim.fn.jobstart({ "xdg-open", url }, { detach = true })
end

-- gx: open URL/file under cursor with xdg-open
vim.keymap.set("n", "gx", function()
    local url = vim.fn.expand("<cfile>")
    if url ~= "" then
        vim.fn.jobstart({ "xdg-open", url }, { detach = true })
    end
end, { desc = "Open URL/file under cursor with xdg-open" })


-----------------------------------------------------------
-- Nix files: 2-space indent, still no wrap
-----------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
    pattern = "nix",
    callback = function()
        local o = vim.opt_local

        -- 2-space indent for nix files
        o.shiftwidth = 2
        o.tabstop = 2
        o.softtabstop = 2
        o.expandtab = true
    end,
})

