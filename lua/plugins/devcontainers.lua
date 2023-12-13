require('devcontainer').setup{
  attach_mounts = {
    neovim_config = {
      enabled = true,
      options = {"readonly"},
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
