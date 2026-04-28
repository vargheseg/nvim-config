local is_ssh = vim.env.SSH_TTY or vim.env.SSH_CONNECTION
local is_docker = vim.loop.fs_stat("./dockerenv") ~= nil

if is_ssh or is_docker then
  local ok, osc52 = pcall(require, "vim.ui.clipboard.osc52")
  if ok then
    -- Helper: paste from Neovim's internal "" register (so local p/yy still work)
    local function smart_paste()
      return {
        vim.fn.split(vim.fn.getreg('"'), "\n"),
        vim.fn.getregtype('"'),
      }
    end

    vim.g.clipboard = {
      name = "OSC 52 (SSH)",
      copy = {
        ["+"] = osc52.copy("+"),
        ["*"] = osc52.copy("*"),
      },
      paste = {
        ["+"] = smart_paste,
        ["*"] = smart_paste,
      },
    }

    vim.notify("OSC52 clipboard enabled (SSH session)", vim.log.levels.INFO, { title = "Clipboard" })
  end
end
