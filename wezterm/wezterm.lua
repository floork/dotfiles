local wezterm = require("wezterm")

local function whiteBG()
	return {
		orientation = "Vertical",
		colors = { "#FFFFFF" },
		interpolation = "Linear",
		blend = "Rgb",
	}
end

local config = {
	window_background_opacity = 0.9,
	font = wezterm.font("Fira Code"),
	-- window_background_gradient = whiteBG(), -- uncomment to enable
}

-- config.color_scheme = "Codeschool (base16)"
config.color_scheme = "Chameleon (Gogh)"
config.harfbuzz_features = { "calt=0" } -- disable ligatures

return config
