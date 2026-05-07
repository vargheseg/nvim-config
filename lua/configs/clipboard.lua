local is_ssh = vim.env.SSH_TTY or vim.env.SSH_CONNECTION
local is_docker = vim.loop.fs_stat("/.dockerenv") ~= nil

if is_ssh or is_docker then
  local ok, osc52 = pcall(require, "vim.ui.clipboard.osc52")
  if ok then
    vim.g.clipboard = {
      name = "OSC52 (SSH/Docker)",
      copy = {
        ["+"] = osc52.copy("+"),
        ["*"] = osc52.copy("*"),
      },
      paste = {
        ["+"] = osc52.paste("+"),
        ["*"] = osc52.paste("*"),
      },
    }

  end
end
