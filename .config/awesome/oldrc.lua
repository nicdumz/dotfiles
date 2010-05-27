-- Standard awesome library
require("awful")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

require("wicked")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- The default is a dark theme
theme_path = "/home/nicdumz/.config/awesome/themes/default/theme.lua"
-- Uncommment this for a lighter theme
-- theme_path = "/usr/local/share/awesome/themes/sky/theme.lua"

-- Actually load theme
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
terminal = "xterm"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
editconfig = editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua"

alsa = "amixer -c 0 set Master playback "


myspace          = widget({ type = "textbox", name = "myspace", align = "right" })
myseparator      = widget({ type = "textbox", name = "myseparator", align = "right" })
myspace.text     = " "
myseparator.text = "|"
mylseparator      = widget({ type = "textbox", name = "myseparator", align = "left" })
mylseparator.text = "|"

---mpdwidget = widget({
---    type = 'textbox',
---    name = 'mpdwidget',
---    align = 'left',
---})
---
---wicked.register(mpdwidget, wicked.widgets.mpd,
---	function (widget, args)
---		   if args[1]:find("volume:") == nil then
---              --widget.width = #args[1]*7
---              widget.width = 400
---		      return ' <span color="white">' ..args[1] .. '</span> '
---		   else
---              widget.width = 20
---              return ' ~ '
---           end
---		end)

---------- CALENDAR ---------------

function displayMonth(month,year,weekStart)
    local t,wkSt=os.time{year=year, month=month+1, day=0},weekStart or 1
    local d=os.date("*t",t)
    local now = os.date("*t")
    local mthDays,stDay=d.day,(d.wday-d.day-wkSt+1)%7

    --print(mthDays .."\n" .. stDay)
    local lines = "    <span color='white'>"

    for x=0,6 do
        lines = lines .. os.date("%a ",os.time{year=2006,month=1,day=x+wkSt})
    end

    lines = lines .. "\n" .. os.date(" %V",os.time{year=year,month=month,day=1}) .. "</span>"

    local height = 1
    local writeLine = 1
    while writeLine < (stDay + 1) do
        lines = lines .. "    "
        writeLine = writeLine + 1
    end

    for x=1,mthDays do
        if writeLine == 8 then
            writeLine = 1
            lines = lines .. "\n" .. "<span color='white'>" .. os.date(" %V",os.time{year=year,month=month,day=x}) .. "</span>"
            height = height + 1
        end
        if (#(tostring(x)) == 1) then
            x = " " .. x
        end
        if tonumber(x) == now.day and tonumber(month)==now.month and tonumber(year)==now.year then
            x = "<span color='red'>" .. x .. "</span>"
        end
        lines = lines .. "  " .. x
        writeLine = writeLine + 1
    end
    if height == 5 then
        lines = lines .. "\n"
    end

    local header = os.date("%B %Y\n",os.time{year=year,month=month,day=1})
    --header = string.rep(" ", math.floor(((#(lines)) - #header) / 2 )) .. header

    return header .. "\n" .. lines
end

local calendar = {}
function switchNaughtyMonth(switchMonths)
    if (#calendar < 3) then return end
    local swMonths = switchMonths or 1
    calendar[1] = calendar[1] + swMonths
    calendar[3].box.widgets[2].text = string.format('<span font_desc="%s">%s</span>', "monospace", displayMonth(calendar[1], calendar[2], 2))
end
------------- END CALENDAR -------------------

------------- CPU WIDGET ---------------------

local cpu_total = {}
local cpu_active = {}
local cpu_usage = {}

function get_cpu(format)
    -- Calculate CPU usage for all available CPUs / cores and return the
    -- usage

    -- Perform a new measurement
    ---- Get /proc/stat
    local cpu_lines = {}
    local cpu_usage_file = io.open('/proc/stat')
    for line in cpu_usage_file:lines() do
        if string.sub(line, 1, 3) == 'cpu' then
            table.insert(cpu_lines, wicked.helper.splitbywhitespace(line))
        end
    end
    cpu_usage_file:close()

    ---- Ensure tables are initialized correctly
    while #cpu_total < #cpu_lines do
        table.insert(cpu_total, 0)
    end
    while #cpu_active < #cpu_lines do
        table.insert(cpu_active, 0)
    end
    while #cpu_usage < #cpu_lines do
        table.insert(cpu_usage, 0)
    end

    ---- Setup tables
    total_new     = {}
    active_new    = {}
    diff_total    = {}
    diff_active   = {}

    for i,v in ipairs(cpu_lines) do
        ---- Calculate totals
        total_new[i]    = 0
        for j = 2, #v do
            total_new[i] = total_new[i] + v[j]
        end
        ---- user, nice, sys
        -- active_new[i]   = v[2] + v[3] + v[4]
        -- ignore nice
        active_new[i]   = v[2] + v[4]

        ---- Calculate percentage
        diff_total[i]   = total_new[i]  - cpu_total[i]
        diff_active[i]  = active_new[i] - cpu_active[i]
        cpu_usage[i]    = math.floor(diff_active[i] / diff_total[i] * 100)

        ---- Store totals
        cpu_total[i]    = total_new[i]
        cpu_active[i]   = active_new[i]
    end

    return cpu_usage
end
cpugraphwidget = widget({
    type = 'graph',
    name = 'cpugraphwidget',
    align = 'right'
})

cpugraphwidget.height = 0.85
cpugraphwidget.width = 45
cpugraphwidget.bg = '#333333'
cpugraphwidget.border_color = '#0a0a0a'
cpugraphwidget.grow = 'left'

cpugraphwidget:plot_properties_set('cpu', {
    fg = '#AEC6D8',
    fg_center = '#285577',
    fg_end = '#285577',
    vertical_gradient = false
})

--wicked.register(cpugraphwidget, get_cpu, '$1', nil, 'cpu')

------ END CPU ----------------
---
--- pb_volume =  widget({ type = 'progressbar', name = "pb_volume", align = "right" })
--- pb_volume.width = 12
--- pb_volume.height = 1
--- pb_volume.border_padding = 1
--- pb_volume.border_width = 1
--- pb_volume.ticks_count = 8
--- pb_volume.gap = 0
--- pb_volume.vertical = true
---
--- pb_volume:bar_properties_set("vol",
--- {
---   ["bg"] = "#000000",
---   ["fg"] = "green",
---   ["fg_center"] = "yellow",
---   ["fg_end"] = "red",
---   ["fg_off"] = "black",
---   ["border_color"] = "#999933",
---   ["min_value"] = 0,
---   ["max_value"] = 100,
---   ["reverse"] = false
--- })
---
---cardid  = 0
---channel = "Master"
---function volume (widget)
---        local status = io.popen("amixer -c " .. cardid .. " -- sget " .. channel):read("*all")
---
---        local volume = string.match(status, "(%d?%d?%d)%%")
---
---        status = string.match(status, "%[(o[^%]]*)%]")
---
---        if string.find(status, "on", 1, true) then
---            widget:bar_properties_set("vol", {["bg"] = "#000000"})
---        else
---            widget:bar_properties_set("vol", {["bg"] = "#cc3333"})
---        end
---        widget:bar_data_add("vol", volume)
---end
-----volume(pb_volume)
---awful.hooks.timer.register(10, function () volume(pb_volume) end)



-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}

-- Table of clients that should be set floating. The index may be either
-- the application class or instance. The instance is useful when running
-- a console app in a terminal like (Music on Console)
--    xterm -name mocp -e mocp
floatapps =
{
    -- by class
    ["MPlayer"] = true,
    ["pinentry"] = true,
    ["gimp"] = true,
    -- by instance
    ["mocp"] = true,

    ["sonata"] = true
}

-- Applications to be moved to a pre-defined tag by class or instance.
-- Use the screen and tags indices.
apptags =
{
    ["Firefox"] = { screen = 1, tag = 3 },
    ["firefox"] = { screen = 1, tag = 3 },
    ["firefox-3.0"] = { screen = 1, tag = 3 },
    ["pidgin"] = { screen = 1, tag = 4 },
    ["psi"] = { screen = 1, tag = 4 },
    ["xchat"] = { screen = 1, tag = 5 },
    -- ["mocp"] = { screen = 2, tag = 4 },
}

-- Define if we want to use titlebar on all applications.
use_titlebar = false
-- }}}

-- {{{ Tags
-- Define tags table.
tags = {}

tags.settings = {
    { name = "term" },
    { name = "vim"  },
    { name = "web"  },
    { name = "im" },
    { name = "irc" },
    { name = "6" },
    { name = "7" },
    { name = "8" },
    { name = "9" }
}


for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = {}
    -- Create 9 tags per screen.
    for i,v in ipairs(tags.settings) do
        if tonumber(v.name) == i then
            tags[s][i] = tag(v.name)
        else
            tags[s][i] = tag(i .. ":" .. v.name)
        end
        -- Add tags to screen one by one
        tags[s][i].screen = s
        awful.layout.set(layouts[1], tags[s][i])
    end
    -- I'm sure you want to see at least one tag.
    tags[s][1].selected = true
end
-- }}}

-- {{{ Wibox
-- Create a textbox widget
mytextbox = widget({ type = "textbox", align = "right" })
-- Set the default text in textbox
mytextbox.text = os.date(" %b %d, %H:%M ")

mytextbox.mouse_enter = function ()
    local month, year = os.date('%m'), os.date('%Y')
    calendar = { month, year,
                naughty.notify({
                    text = string.format('<span font_desc="%s">%s</span>', "monospace", displayMonth(month, year, 2)),
                    timeout = 0, hover_timeout = 0.5,
                    width = 240, screen = mouse.screen
                })
               }
end
mytextbox.mouse_leave = function () naughty.destroy(calendar[3]) end

mytextbox:buttons(awful.util.table.join(
    awful.button({ }, 1, function()
        switchNaughtyMonth(-1)
    end),
    awful.button({ }, 3, function()
        switchNaughtyMonth(1)
    end),
    awful.button({ }, 4, function()
        switchNaughtyMonth(-1)
    end),
    awful.button({ }, 5, function()
        switchNaughtyMonth(1)
    end),
    awful.button({ 'Shift' }, 1, function()
        switchNaughtyMonth(-12)
    end),
    awful.button({ 'Shift' }, 3, function()
        switchNaughtyMonth(12)
    end),
    awful.button({ 'Shift' }, 4, function()
        switchNaughtyMonth(-12)
    end),
    awful.button({ 'Shift' }, 5, function()
        switchNaughtyMonth(12)
    end)
))


-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   --{ "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "edit config", editconfig },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu.new({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                        { "open terminal", terminal }
                                      }
                            })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })

-- Create a systray
mysystray = widget({ type = "systray", align = "right" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, function (tag) tag.selected = not tag.selected end),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ align = "left" })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s, { align = "right" })
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)
    mytaglist[s].align = "left"

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)
    mytasklist[s].align = "left"

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = { --mylauncher,
                           mytaglist[s],
                           --mylseparator,
                           --mytasklist[s],
                           mypromptbox[s],
                           mylseparator,
                           --mpdwidget,
                           --pb_volume,
                           myspace,
                           cpugraphwidget,
                           myspace,
                           myseparator,
                           mytextbox,
                           mylayoutbox[s],
                           s == 1 and mysystray or nil }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
--    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
--    awful.key({ modkey,           }, "w", function () mymainmenu:show(true)        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1) end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1) end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus( 1)       end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus(-1)       end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- MPC
    --awful.key({ modkey }, "Delete", function () os.execute("mpc prev") end),
    --awful.key({ modkey }, "End", function () os.execute("mpc toggle") end),
    --awful.key({ modkey }, "Next", function () os.execute("mpc next") end),

    -- ALSA
    awful.key({ modkey }, "Home", function() os.execute(alsa .. "toggle") volume(pb_volume) end),
    awful.key({ modkey }, "Insert", function() os.execute(alsa .. "10%-") volume(pb_volume) end),
    awful.key({ modkey }, "Prior", function() os.execute(alsa .. "10%+") volume(pb_volume) end),

    -- EDIT CONFIG
    awful.key({ modkey }, "e", function() awful.util.spawn(editconfig) end),

    awful.key({ modkey }, "Print", function() awful.util.spawn("ksnapshot") end)
--    awful.key({ modkey , "Control" }, "m", function() os.execute("evince /home/nicdumz/Documents/metro.pdf") end)
)

-- Client awful tagging: this is useful to tag some clients and then do stuff like move to tag on them
clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey }, "t", awful.client.togglemarked),
    awful.key({ modkey,}, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, i,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, i,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          tags[screen][i].selected = not tags[screen][i].selected
                      end
                  end),
        awful.key({ modkey, "Shift" }, i,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, i,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "F" .. i,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          for k, c in pairs(awful.client.getmarked()) do
                              awful.client.movetotag(tags[screen][i], c)
                          end
                      end
                   end))
end

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Hooks
-- Hook function to execute when focusing a client.
---awful.hooks.focus.register(function (c)
---    if not awful.client.ismarked(c) then
---        c.border_color = beautiful.border_focus
---    end
---end)
---
----- Hook function to execute when unfocusing a client.
---awful.hooks.unfocus.register(function (c)
---    if not awful.client.ismarked(c) then
---        c.border_color = beautiful.border_normal
---    end
---end)

-- Hook function to execute when marking a client
---awful.hooks.marked.register(function (c)
---    c.border_color = beautiful.border_marked
---end)

-- Hook function to execute when unmarking a client.
---awful.hooks.unmarked.register(function (c)
---    c.border_color = beautiful.border_focus
---end)

-- Hook function to execute when the mouse enters a client.
---awful.hooks.mouse_enter.register(function (c)
---    -- Sloppy focus, but disabled for magnifier layout
---    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
---        and awful.client.focus.filter(c) then
---        client.focus = c
---    end
---end)
---
----- Hook function to execute when a new client appears.
---awful.hooks.manage.register(function (c, startup)
---    -- If we are not managing this application at startup,
---    -- move it to the screen where the mouse is.
---    -- We only do it for filtered windows (i.e. no dock, etc).
---    if not startup and awful.client.focus.filter(c) then
---        c.screen = mouse.screen
---    end
---
---    if use_titlebar then
---        -- Add a titlebar
---        awful.titlebar.add(c, { modkey = modkey })
---    end
---    -- Add mouse bindings
---    c:buttons(awful.util.table.join(
---        awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
---        awful.button({ modkey }, 1, awful.mouse.client.move),
---        awful.button({ modkey }, 3, awful.mouse.client.resize)
---    ))
---    -- New client may not receive focus
---    -- if they're not focusable, so set border anyway.
---    c.border_width = beautiful.border_width
---    c.border_color = beautiful.border_normal
---
---    -- Check if the application should be floating.
---    local cls = c.class
---    local inst = c.instance
---    if floatapps[cls] ~= nil then
---        awful.client.floating.set(c, floatapps[cls])
---    elseif floatapps[inst] ~= nil then
---        awful.client.floating.set(c, floatapps[inst])
---    end
---
---    -- Check application->screen/tag mappings.
---    local target
---    if apptags[cls] then
---        target = apptags[cls]
---    elseif apptags[inst] then
---        target = apptags[inst]
---    end
---    if target then
---        c.screen = target.screen
---        awful.client.movetotag(tags[target.screen][target.tag], c)
---    end
---
---    -- Do this after tag mapping, so you don't see it on the wrong tag for a split second.
---    client.focus = c
---
---    -- Set key bindings
---    c:keys(clientkeys)
---
---    -- Set the windows at the slave,
---    -- i.e. put it at the end of others instead of setting it master.
---    -- awful.client.setslave(c)
---
---    -- Honor size hints: if you want to drop the gaps between windows, set this to false.
---    c.size_hints_honor = true
---end)
---
----- Hook function to execute when switching tag selection.
---awful.hooks.tags.register(function (screen, tag, view)
---    -- Give focus to the latest client in history if no window has focus
---    -- or if the current window is a desktop or a dock one.
---    if not client.focus or not client.focus:isvisible() then
---        local c = awful.client.focus.history.get(screen, 0)
---        if c then client.focus = c end
---    end
---end)

-- Hook called every minute
---awful.hooks.timer.register(60, function ()
---    mytextbox.text = os.date(" %b %d, %H:%M ")
---end)
-- }}}

--os.execute("mpd")
--awful.util.spawn("sonata")

print("done.")
