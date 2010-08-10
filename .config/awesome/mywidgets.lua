require("obvious")

-- Clock that spawns calendar
mytextclock = awful.widget.textclock({ align = "right" })
do
    function spawn_calendar()
        awful.util.spawn(awesome_path .. "/calendar.sh")
    end
    mytextclock:buttons( awful.button({ }, 1, spawn_calendar) )
end

-- volume widget
myvolume = obvious.volume_alsa()

-- memory widget
meminfo = widget({ type = "textbox", align = "right" })
do
    function activeram()
        local active, total
        for line in io.lines('/proc/meminfo') do
            for key, value in string.gmatch(line, "(%w+):\ +(%d+).+") do
                if key == "MemFree" then free = tonumber(value)
                elseif key == "MemTotal" then total = tonumber(value) end
            end
        end

        return string.format("<span foreground='#00cd00'> %.0f%% </span>",
                             ((total-free)/total)*100)
    end
    awful.hooks.timer.register(2, function() meminfo.text = activeram() end)
end
