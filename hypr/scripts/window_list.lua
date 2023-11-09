function execute_command(command)
	local file = io.popen(command)
	local output = file:read("*a")
	file:close()
	return output
end

local command = "hyprctl clients | grep 'class: ' | awk '{gsub(\"class: \", \"\");print}'"
local window_classes = execute_command(command)

if window_classes == "" then
	print("No windows found.")
	os.exit(1)
end

local window_options = {}
for window in window_classes:gmatch("[^\n]+") do
	local cleaned_window = window:gsub("[^%g ]", "")
	if cleaned_window ~= "" then
		table.insert(window_options, cleaned_window)
	end
end

if #window_options == 0 then
	print("No windows with text found.")
	os.exit(1)
end

local selected_window = execute_command('echo "' .. table.concat(window_options, "\n") .. '" | wofi --show dmenu')

if selected_window == "" then
	os.exit(1)
end

execute_command("hyprctl dispatch focuswindow " .. selected_window)
