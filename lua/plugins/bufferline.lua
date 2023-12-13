require('bufferline').setup{
  options = {
    mode = "tabs",
    themable = true,
    indicator = {
      style = "underline"
    },
    separator_style = 'slant',
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "left",
        separator = true
      }
    },
    color_icons = true,
  }
}
