-- Symmetria IDE integration.
--
-- When nvim is launched inside Symmetria IDE (the PySide6 GUI wrapper),
-- `runtime/init.lua` in that repo sets `vim.g.symmetria_ide = 1` as a
-- detection flag. This mirrors the `vim.g.neovide` convention used by
-- other GUI frontends (neovide, goneovim, fvim).
--
-- The IDE claims `ext_cmdline` + `ext_popupmenu` on `ui_attach` and
-- renders its own floating cmdline + completion overlay. Plugins that
-- draw colliding UI (noice.nvim, wilder.nvim, etc.) should skip loading
-- when running inside the IDE, via:
--
--   cond = function() return not require("jc.symmetria").active end
--
-- This module is required from `init.lua` during startup (gated on the
-- flag, same pattern as `jc.neovide`). IDE-only settings are applied
-- below the early-return guard — anything above runs in plain nvim too
-- so that plugin `cond` checks always get a correctly-populated module.

local M = {}

M.active = vim.g.symmetria_ide == 1

if not M.active then
	return M
end

-- ---------- IDE-specific configuration ----------
-- (future home for Symmetria-IDE-only keymaps, highlights, options.
-- Nothing here yet — the IDE's own `runtime/init.lua` handles the
-- essential setup like hiding laststatus.)

return M
