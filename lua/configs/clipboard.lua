if vim.env.SSH_TTY or vim.env.SSH_CONNECTION then
  local ok, osc52 = pcall(require, "vim.ui.clipboard.osc52")
  if ok then
    vim.g.clipboard = {
      name = "OSC 52 (SSH)",
      copy = {
        ["+"] = osc52.copy("+"),
        ["*"] = osc52.copy("*"),
      },
      paste = {
        ["+"] = function() return { {}, "" } end,   -- no-op to avoid freezes
        ["*"] = function() return { {}, "" } end,
      },
    }
    vim.notify("OSC52 clipboard enabled (SSH session)", vim.log.levels.INFO, { title = "Clipboard" })
  end
end
