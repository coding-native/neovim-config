local status, devcontainer = pcall(require, 'devcontainer')
if (not status) then return end

local opts = {
  attach_mounts = {
    neovim_config = {
      enabled = true,
      options = { "readonly" },
    },
    neovim_data = {
      enabled = false,
      options = {}
    },
    neovim_state = {
      enabled = false,
      options = {}
    }
  }
}

devcontainer.setup(opts)
