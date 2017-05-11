-- failsafe mode for 4.0
-- if the current config fail, load the default rc.lua

local awful = require("awful")
local naughty = require("naughty")

confdir = awful.util.getdir("config")
local rc, err = loadfile(confdir .. "/awesome.lua");
if rc then
    rc, err = pcall(rc);
    if rc then
        return;
    end
end

dofile("/etc/xdg/awesome/rc.lua");

awful.screen.connect_for_each_screen(function(s)
    s.mypromptbox.widget.text = awful.util.escape(err:match("[^\n]*"));
end)

naughty.notify{text="Awesome crashed during startup on " .. os.date("%d/%m/%Y %T:\n\n") ..  err .. "\n", timeout = 0}
