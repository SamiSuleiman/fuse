local M = {}

function M.fuse()
	local is_in_tmux_session = os.getenv("TMUX")
	if is_in_tmux_session == nil then
		return nil
	end
	local curr_window = io.popen('tmux display-message -p "#I"'):read("*a")

	local file = io.popen('tmux list-windows -F "#I"')
	local windows_str = ""

	if not file then
		return nil
	end

	for window in file:read("*a"):gmatch("%S+") do
		local window_num = tonumber(window)
		local curr_window_num = tonumber(curr_window)

		if window_num == curr_window_num then
			windows_str = windows_str .. "[" .. window_num .. "] "
		else
			windows_str = windows_str .. window_num .. " "
		end
	end

	file:close()
	return windows_str
end

function M.setup()
	vim.api.nvim_create_user_command("Fuse", 'lua require("fuse").fuse()', { nargs = 0 })
end

return M
