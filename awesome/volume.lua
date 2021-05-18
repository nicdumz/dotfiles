-- From https://github.com/streetturtle/AwesomeWM/blob/master/volume-widget/volume.lua
--
-- Modified path_to_icons.
-- Added a tooltip.
--
local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")

local path_to_icons = "/usr/share/icons/gnome/scalable/status/"

volume_widget = wibox.widget {
    {
        id = "icon",
   	image = path_to_icons .. "audio-volume-muted-symbolic.svg",
	resize = false,
        widget = wibox.widget.imagebox,
    },
    layout = wibox.container.margin(brightness_icon, 0, 0, 3),
    set_image = function(self, path)
        self.icon.image = path
    end
}

--[[ allows control volume level by:
- clicking on the widget to mute/unmute
- scrolling when curson is over the widget
]]
volume_widget:connect_signal("button::press", function(_,_,_,button)
    if (button == 4) then
        awful.spawn("amixer sset Master 5%+", false)
    elseif (button == 5) then
        awful.spawn("amixer sset Master 5%-", false)
    elseif (button == 1) then
        awful.spawn("amixer sset Master toggle", false)
    end
end)

volume_widget.tooltip = awful.tooltip({objects = {volume_widget}})
volume_widget.tooltip:set_mode("mouse")

watch(
    'amixer sget Master', 1,
    function(widget, stdout, stderr, reason, exit_code)
        local mute = string.match(stdout, "%[(o%D%D?)%]")
        local volume = string.match(stdout, "(%d?%d?%d)%%")
        widget.tooltip:set_text(volume .. "%")
		volume = tonumber(string.format("% 3d", volume))
		local volume_icon_name
		if mute == "off" then volume_icon_name="audio-volume-muted-symbolic"
		elseif (volume >= 0 and volume < 25) then volume_icon_name="audio-volume-muted-symbolic"
		elseif (volume >= 25 and volume < 50) then volume_icon_name="audio-volume-low-symbolic"
		elseif (volume >= 50 and volume < 75) then volume_icon_name="audio-volume-medium-symbolic"
		elseif (volume >= 75 and volume <= 100) then volume_icon_name="audio-volume-high-symbolic"
		end
        widget.image = path_to_icons .. volume_icon_name .. ".svg"
    end,
    volume_widget
)
