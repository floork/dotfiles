return {
	"FeiyouG/commander.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("commander").setup({
			integration = {
				telescope = {
					enable = true,
				},
				lazy = {
					enable = true,
					set_plugin_name_as_cat = true,
				},
			},
		})

		-- keymap
		local keymap = vim.keymap
		keymap.set("n", "<leader><Tab>", "<cmd>Telescope commander<CR>", { noremap = true, silent = true })
	end,
}
