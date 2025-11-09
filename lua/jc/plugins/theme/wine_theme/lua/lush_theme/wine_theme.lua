--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is a lua file, vim will append it to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

local lush = require("lush")
local hsl = lush.hsl

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
	local sym = injected_functions.sym

	local colors = {
		-- Background colors
		bg_primary = hsl("#131313"),
		bg_elevated = hsl("#1E1D1E"),
		bg_panel = hsl("#272727"),
		bg_element = hsl("#373636"),
		bg_hover = hsl("#353436"),
		bg_selected = hsl("#474646"),

		-- Border colors
		border = hsl("#404040"),
		border_variant = hsl("#3A3A3A"),

		-- Text colors
		fg_primary = hsl("#DDDDDD"),
		fg_muted = hsl("#9E9E9E"),
		fg_inactive = hsl("#8F8F8F"),

		-- Syntax colors
		comment = hsl("#9E9E9E"),
		string = hsl("#62BA46"),
		keyword = hsl("#c28b12"),
		func = hsl("#fdd888"),
		type_color = hsl("#c75828"),
		constant = hsl("#E1D797"),
		attribute = hsl("#e7cb8f"),
		constructor = hsl("#b5af9a"),
		variable_special = hsl("#E19773"),

		-- UI accent colors
		accent_blue = hsl("#6d94e9"),
		warning_yellow = hsl("#B0A878"),
		error_red = hsl("#D2602D"),

		-- Terminal colors
		term_black = hsl("#E8E4CF"),
		term_bright_black = hsl("#57564F"),
		term_red = hsl("#A8473B"),
		term_bright_red = hsl("#DD6F61"),
		term_green = hsl("#76BA53"),
		term_bright_green = hsl("#9DE478"),
		term_yellow = hsl("#E1D797"),
		term_bright_yellow = hsl("#857F5C"),
		term_blue = hsl("#6d94e9"),
		term_bright_blue = hsl("#81A9F6"),
		term_magenta = hsl("#AE30C2"),
		term_bright_magenta = hsl("#D86DE9"),
		term_cyan = hsl("#3DB6B0"),
		term_bright_cyan = hsl("#5BDFD8"),
		term_white = hsl("#131313"),
		term_bright_white = hsl("#3A3A3A"),
	}

	return {
		-- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
		-- groups, mostly used for styling UI elements.
		-- Comment them out and add your own properties to override the defaults.
		-- An empty definition `{}` will clear all styling, leaving elements looking
		-- like the 'Normal' group.
		-- To be able to link to a group, it must already be defined, so you may have
		-- to reorder items as you go.
		--
		-- See :h highlight-groups
		--

        -- stylua: ignore start

		-- ColorColumn({}), -- Columns set with 'colorcolumn'
		-- Conceal        { }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
		-- Cursor         { }, -- Character under the cursor
		-- CurSearch      { }, -- Highlighting a search pattern under the cursor (see 'hlsearch')
		-- lCursor        { }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
		-- CursorIM       { }, -- Like Cursor, but used when in IME mode |CursorIM|
		-- CursorColumn   { }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
		-- CursorLine     { }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
		Directory      { fg = colors.accent_blue }, -- Directory names (and other special names in listings)
		-- DiffAdd        { }, -- Diff mode: Added line |diff.txt|
		-- DiffChange     { }, -- Diff mode: Changed line |diff.txt|
		-- DiffDelete     { }, -- Diff mode: Deleted line |diff.txt|
		-- DiffText       { }, -- Diff mode: Changed text within a changed line |diff.txt|
		-- EndOfBuffer    { }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
		-- TermCursor     { }, -- Cursor in a focused terminal
		-- TermCursorNC   { }, -- Cursor in an unfocused terminal
		-- ErrorMsg       { }, -- Error messages on the command line
		-- VertSplit      { }, -- Column separating vertically split windows
		-- Folded         { }, -- Line used for closed folds
		-- FoldColumn     { }, -- 'foldcolumn'
		-- SignColumn     { }, -- Column where |signs| are displayed

		Search         { fg = colors.bg_primary, bg = colors.accent_blue }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
		IncSearch      { Search }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
		Substitute     { Search }, -- |:substitute| replacement text highlighting

		LineNr         { fg = colors.fg_inactive }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
		LineNrAbove    { fg = colors.fg_inactive }, -- Line number for when the 'relativenumber' option is set, above the cursor line
		LineNrBelow    { fg = colors.fg_inactive }, -- Line number for when the 'relativenumber' option is set, below the cursor line
		CursorLineNr   { fg = colors.fg_primary, gui = "bold" }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.

		-- CursorLineFold { }, -- Like FoldColumn when 'cursorline' is set for the cursor line
		-- CursorLineSign { }, -- Like SignColumn when 'cursorline' is set for the cursor line
		-- MatchParen     { }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
		-- ModeMsg        { }, -- 'showmode' message (e.g., "-- INSERT -- ")
		-- MsgArea        { }, -- Area for messages and cmdline
		-- MsgSeparator   { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
		MoreMsg        { fg = colors.string }, -- |more-prompt|
		-- NonText        { }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
		Normal            { fg = colors.fg_primary, bg = "NONE" }, -- Normal text
		NormalFloat    { fg = colors.fg_primary, bg = "NONE" }, -- Normal text in floating windows.
		FloatBorder    { fg = colors.border, bg = "NONE" }, -- Border of floating windows.
		FloatTitle        { fg = colors.fg_primary, gui = "bold", bg = "NONE" }, -- Title of floating windows.
		-- NormalNC       { }, -- normal text in non-current windows

		-- Pmenu          { }, -- Popup menu: Normal item.
		-- PmenuSel       { bg = colors.blue }, -- Popup menu: Selected item.
		-- PmenuKind      { }, -- Popup menu: Normal item "kind"
		-- PmenuKindSel   { bg = colors.blue }, -- Popup menu: Selected item "kind"
		-- PmenuExtra     { }, -- Popup menu: Normal item "extra text"
		-- PmenuExtraSel  { bg = colors.blue }, -- Popup menu: Selected item "extra text"
		-- PmenuSbar      { }, -- Popup menu: Scrollbar.
		-- PmenuThumb     { }, -- Popup menu: Thumb of the scrollbar.
		--
		Question       { fg = colors.string }, -- |hit-enter| prompt and yes/no questions
		-- QuickFixLine   { fg = colors.green_celadon }, -- Current |quickfix| item in gui = "underline", guisp = "#ff0000" the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
		-- SpecialKey     { }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|

        -- TODO: Straight underline with color only in the underline group.
		-- SpellBad       { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
		-- SpellCap       { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
		-- SpellLocal     { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
		-- SpellRare      { }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.

		StatusLine        { fg = colors.fg_primary, bg = "NONE" }, -- Status line of current window
		StatusLineNC      { fg = colors.fg_muted, bg = "NONE" }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.

		-- TabLine        { }, -- Tab pages line, not active tab page label
		-- TabLineFill    { }, -- Tab pages line, where there are no labels
		-- TabLineSel     { }, -- Tab pages line, active tab page label

		-- Title          { }, -- Titles for output from ":set all", ":autocmd" etc.
		-- Visual         { }, -- Visual mode selection
		-- VisualNOS      { }, -- Visual mode selection when vim is "Not Owning the Selection".
		-- WarningMsg     { }, -- Warning messages
		-- Whitespace     { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
		-- Winseparator   { }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
		-- WildMenu       { }, -- Current match in 'wildmenu' completion
		-- WinBar         { }, -- Window bar of current window
		-- WinBarNC       { }, -- Window bar of not-current windows

		-- Common vim syntax groups used for all kinds of code and markup.
		-- Commented-out groups should chain up to their preferred (*) group
		-- by default.
		--
		-- See :h group-name
		--
		-- Uncomment and edit if you want more specific syntax highlighting.

		Comment        { fg = colors.comment, gui = "italic" }, -- Any comment

		Constant       { fg = colors.constant }, -- (*) Any constant
		String         { fg = colors.string }, --   A string constant: "this is a string"
		-- Character      { }, --   A character constant: 'c', '\n'
		Number         { fg = colors.constant }, --   A number constant: 234, 0xff
		Boolean        { fg = colors.constant }, --   A boolean constant: TRUE, false
		-- Float          { }, --   A floating point constant: 2.3e10

		Identifier     { fg = colors.fg_primary }, -- (*) Any variable name
		Function       { fg = colors.func, gui = "italic,bold" }, --   Function name (also: methods for classes)

		-- Statement      { }, -- (*) Any statement
		Conditional    { fg = colors.keyword, gui = "italic" }, --   if, then, else, endif, switch, etc.
		Repeat         { fg = colors.keyword, gui = "italic,bold" }, --   for, do, while, etc.
		-- Label          { }, --   case, default, etc.
		-- Operator       { }, --   "sizeof", "+", "*", etc.
		Keyword        { fg = colors.keyword, gui = "italic,bold" }, --   any other keyword
		Exception      { fg = colors.keyword, gui = "italic,bold" }, --   try, catch, throw

		-- PreProc        { }, -- (*) Generic Preprocessor
		-- Include        { }, --   Preprocessor #include
		-- Define         { }, --   Preprocessor #define
		-- Macro          { }, --   Same as Define
		-- PreCondit      { }, --   Preprocessor #if, #else, #endif, etc.

		Type           { fg = colors.type_color }, -- (*) int, long, char, etc.
		-- StorageClass   { }, --   static, register, volatile, etc.
		-- Structure      { }, --   struct, union, enum, etc.
		-- Typedef        { }, --   A typedef

		Special        { fg = colors.variable_special }, -- (*) Any special symbol
		SpecialChar    { Function }, --   Special character in a constant
		-- Tag            { }, --   You can use CTRL-] on this
		-- Delimiter      { }, --   Character that needs attention
		-- SpecialComment { }, --   Special things inside a comment (e.g. '\n')
		-- Debug          { }, --   Debugging statements

		-- Underlined     { gui = "underline" }, -- Text that stands out, HTML links
		-- Ignore         { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
		-- Error          { }, -- Any erroneous construct
		-- Todo           { }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

		-- These groups are for the native LSP client and diagnostic system. Some
		-- other LSP clients may use these groups, or use their own. Consult your
		-- LSP client's documentation.

		-- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
		--
		-- LspReferenceText            { } , -- Used for highlighting "text" references
		-- LspReferenceRead            { } , -- Used for highlighting "read" references
		-- LspReferenceWrite           { } , -- Used for highlighting "write" references
		-- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
		-- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
		-- LspSignatureActiveParameter { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

		-- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!

		-- DiagnosticError            { colors.orange_flame } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		-- DiagnosticVirtualTextError { colors.orange_flame } , -- Used for "Error" diagnostic virtual text.
		-- DiagnosticUnderlineError   { colors.orange_flame } , -- Used to underline "Error" diagnostics.
		-- DiagnosticFloatingError    { colors.orange_flame } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|

		-- DiagnosticWarn             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		-- DiagnosticVirtualTextWarn  { } , -- Used for "Warn" diagnostic virtual text.
		-- DiagnosticUnderlineWarn    { } , -- Used to underline "Warn" diagnostics.
		-- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
		-- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.

		DiagnosticInfo             { fg = colors.accent_blue } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticVirtualTextInfo  { fg = colors.accent_blue } , -- Used for "Info" diagnostic virtual text.
		DiagnosticUnderlineInfo    { fg = colors.accent_blue } , -- Used to underline "Info" diagnostics.
		DiagnosticFloatingInfo     { fg = colors.accent_blue } , -- Used to color "Info" diagnostic messages in diagnostics float.
		DiagnosticSignInfo         { fg = colors.accent_blue } , -- Used for "Info" signs in sign column.

		-- DiagnosticHint             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		-- DiagnosticVirtualTextHint  { } , -- Used for "Hint" diagnostic virtual text.
		-- DiagnosticUnderlineHint    { } , -- Used to underline "Hint" diagnostics.
		-- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
		-- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.

		-- DiagnosticOk               { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		-- DiagnosticVirtualTextOk    { } , -- Used for "Ok" diagnostic virtual text.
		-- DiagnosticUnderlineOk      { } , -- Used to underline "Ok" diagnostics.
		-- DiagnosticFloatingOk       { } , -- Used to color "Ok" diagnostic messages in diagnostics float.
		-- DiagnosticSignOk           { } , -- Used for "Ok" signs in sign column.

		-- Tree-Sitter syntax groups.
		--
		-- See :h treesitter-highlight-groups, some groups may not be listed,
		-- submit a PR fix to lush-template!
		--
		-- Tree-Sitter groups are defined with an "@" symbol, which must be
		-- specially handled to be valid lua code, we do this via the special
		-- sym function. The following are all valid ways to call the sym function,
		-- for more details see https://www.lua.org/pil/5.html
		--
		-- sym("@text.literal")
		-- sym('@text.literal')
		-- sym"@text.literal"
		-- sym'@text.literal'
		--
		-- For more information see https://github.com/rktjmp/lush.nvim/issues/109

		-- sym"@text.literal"      { }, -- Comment
		-- sym"@text.reference"    { }, -- Identifier
		-- sym"@text.title"        { }, -- Title
		-- sym"@text.uri"          { }, -- Underlined
		-- sym"@text.underline"    { }, -- Underlined
		-- sym"@text.todo"         { }, -- Todo
		-- sym"@comment"           { }, -- Comment
		-- sym"@punctuation"       { }, -- Delimiter
		-- sym"@constant"          { }, -- Constant
		-- sym"@constant.builtin"  { }, -- Special
		-- sym"@constant.macro"    { }, -- Define
		-- sym"@define"            { }, -- Define
		-- sym"@macro"             { }, -- Macro
		-- sym"@string"            { }, -- String
		-- sym"@string.escape"     { }, -- SpecialChar
		-- sym"@string.special"    { }, -- SpecialChar
		-- sym"@character"         { }, -- Character
		-- sym"@character.special" { }, -- SpecialChar
		-- sym"@number"            { }, -- Number
		-- sym"@boolean"           { }, -- Boolean
		-- sym"@float"             { }, -- Float
		-- sym"@function"          { }, -- Function
		-- sym"@function.builtin"  { }, -- Special
		-- sym"@function.macro"    { }, -- Macro
		-- sym"@parameter"         { }, -- Identifier
		-- sym"@method"            { }, -- Function
		-- sym"@field"             { }, -- Identifier
		-- sym"@property"          { }, -- Identifier
		-- sym"@constructor"       { }, -- Special
		-- sym"@conditional"       { }, -- Conditional
		-- sym"@repeat"            { }, -- Repeat
		-- sym"@label"             { }, -- Label
		-- sym"@operator"          { }, -- Operator
		-- sym"@keyword"           { }, -- Keyword
		-- sym"@exception"         { }, -- Exception
		-- sym"@variable"          { }, -- Identifier
		-- sym"@type"              { }, -- Type
		-- sym"@type.definition"   { }, -- Typedef
		-- sym"@storageclass"      { }, -- StorageClass
		-- sym"@structure"         { }, -- Structure
		-- sym"@namespace"         { }, -- Identifier
		-- sym"@include"           { }, -- Include
		-- sym"@preproc"           { }, -- PreProc
		-- sym"@debug"             { }, -- Debug
		-- sym"@tag"               { }, -- Tag

		-- Terminal colors for applications like Yazi
		Terminal            { bg = "NONE", fg = colors.fg_primary },
	}

	-- stylua: ignore end
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
