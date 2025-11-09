-- You probably always want to set this in your vim file
vim.opt.background = "dark"
vim.g.colors_name = "wine_theme"

-- By setting our module to nil, we clear lua's cache,
-- which means the require ahead will *always* occur.
--
-- This isn't strictly required but it can be a useful trick if you are
-- incrementally editing your config a lot and want to be sure your themes
-- changes are being picked up without restarting neovim.
--
-- Note if you're working in on your theme and have :Lushify'd the buffer,
-- your changes will be applied with our without the following line.
--
-- The performance impact of this call can be measured in the hundreds of
-- *nanoseconds* and such could be considered "production safe".
package.loaded["lush_theme.wine_theme"] = nil

-- include our theme file and pass it to lush to apply
require("lush")(require("lush_theme.wine_theme"))

-- Set terminal colors for TUI applications
-- These must be set outside the Lush spec as vim.g is not accessible within Lush's sandboxed environment
vim.g.terminal_color_0 = "#E8E4CF"   -- black (term_black)
vim.g.terminal_color_1 = "#A8473B"   -- red (term_red)
vim.g.terminal_color_2 = "#76BA53"   -- green (term_green)
vim.g.terminal_color_3 = "#E1D797"   -- yellow (term_yellow)
vim.g.terminal_color_4 = "#6d94e9"   -- blue (term_blue) - matches accent_blue
vim.g.terminal_color_5 = "#AE30C2"   -- magenta (term_magenta)
vim.g.terminal_color_6 = "#3DB6B0"   -- cyan (term_cyan)
vim.g.terminal_color_7 = "#131313"   -- white (term_white)
vim.g.terminal_color_8 = "#57564F"   -- bright black (term_bright_black)
vim.g.terminal_color_9 = "#DD6F61"   -- bright red (term_bright_red)
vim.g.terminal_color_10 = "#9DE478"  -- bright green (term_bright_green)
vim.g.terminal_color_11 = "#857F5C"  -- bright yellow (term_bright_yellow)
vim.g.terminal_color_12 = "#81A9F6"  -- bright blue (term_bright_blue)
vim.g.terminal_color_13 = "#D86DE9"  -- bright magenta (term_bright_magenta)
vim.g.terminal_color_14 = "#5BDFD8"  -- bright cyan (term_bright_cyan)
vim.g.terminal_color_15 = "#3A3A3A"  -- bright white (term_bright_white)
