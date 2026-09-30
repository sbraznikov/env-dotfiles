-- Active theme (omarchy-style). To switch: copy another file from
-- ~/.config/nvim/omarchy-themes/ over this one and restart nvim.
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
