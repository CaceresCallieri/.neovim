return {
	"AndrewRadev/switch.vim",
	-- config = function()
	-- 	vim.cmd([[
	--        augroup SwitchCustomDefs
	--          autocmd!
	--          autocmd FileType * let b:switch_custom_definitions = [
	--                   " <Thing foo={data} />
	--                   " <Thing foo={`${data}`} />
	--                \   {
	--                \     '\(\k\+=\){\([[:keyword:].]\+\)}':      '\1{`${\2}`}',
	--                \     '\(\k\+=\){`${\([[:keyword:].]\+\)}`}': '\1{\2}',
	--                \   }
	--                \ ]
	--        augroup END
	--      ]])
	-- end,
}
