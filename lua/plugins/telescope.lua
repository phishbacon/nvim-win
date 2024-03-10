return {
	'nvim-telescope/telescope.nvim', tag = '0.1.5',
	config = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n', '<C-f>', builtin.git_files, {})
		vim.keymap.set('n', '<leader>fs', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
	end,
	dependencies = { 'nvim-lua/plenary.nvim' }
}
