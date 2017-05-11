-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")

awful.util.shell = '/bin/sh'

-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

require("revelation")

require("mywidgets")

require("obvious.popup_run_prompt")
obvious.popup_run_prompt.set_slide(true)
obvious.popup_run_prompt.set_move_speed(0.015)
obvious.popup_run_prompt.set_opacity(0.5)
obvious.popup_run_prompt.set_border_width(3)
obvious.popup_run_prompt.set_height(25)

function volume_up()
  awful.util.spawn("amixer -D pulse sset Master 5%+")
end

function volume_down()
  awful.util.spawn("amixer -D pulse sset Master 5%-")
end

function volume_mute()
  awful.util.spawn("amixer -D pulse sset Master toggle")
end


-- function run_clean(cmd)
--     return awful.util.spawn_with_shell("env LD_LIBRARY_PATH= " .. cmd)
-- end
-- obvious.popup_run_prompt.set_run_function(run_clean)

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers

awesome_path = awful.util.getdir("config")
theme_path = awesome_path .. "/themes/default/theme.lua"
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
terminal = "gnome-terminal"
editor = "vim"
editor_cmd = terminal .. " -e '" .. editor

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
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}
function nextlayout()
    awful.layout.inc(layouts, 1)
end
function prevlayout()
    awful.layout.inc(layouts, -1)
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
do
    -- layout, or hide or mwfact can be set
    local my_tags = {
        {
            { name = "www |", layout = awful.layout.suit.tile },
            { name = "chat |", mwfact = 0.5, layout = awful.layout.suit.tile.bottom },
            { name = "pers ", mwfact = 0.8, layout = awful.layout.suit.tile },
        }, {
            { name = "1 |", layout = awful.layout.suit.tile },
            { name = "2 ", mwfact = 0.8, layout = awful.layout.suit.tile },
        }
    }
    for s = 1, 2 do
        tags[s] = {}
        for i, v in ipairs(my_tags[s]) do
            tags[s][i] = tag({ name = v.name })
            tags[s][i].screen = s
            awful.tag.setproperty(tags[s][i], "layout", v.layout)
            awful.tag.setproperty(tags[s][i], "mwfact", v.mwfact)
            awful.tag.setproperty(tags[s][i], "hide",   v.hide)
        end
        tags[s][1].selected = true
    end
end
-- }}}

green = "#00f804"
orange = "#ff6400"
blue = "#00a7ec"
-- {{{ Columns & Master Widget
mastcolleft = widget({type = "textbox", name = "mastcolleft"});
mastcolright = widget({type = "textbox", name = "mastcolleft"});
mastcolleft.text = obvious.lib.markup.fg.color(green, "[")
mastcolright.text = obvious.lib.markup.fg.color(green, "] ")
colwidget = widget({type = "textbox", name = "colwidget"})
colwidget.text = obvious.lib.markup.fg.color(orange, awful.tag.getncol())
mastwidget = widget({type = "textbox", name = "mastwidget"})
mastwidget.text = obvious.lib.markup.fg.color(blue, awful.tag.getnmaster())
-- }}} Columns & Master Widget

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome_path .. "/awesome.lua'" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = {
                                    { "awesome",
                                      myawesomemenu,
                                      beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
--

-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                        awful.button({ }, 1, awful.tag.viewonly),
                        awful.button({ modkey }, 1, awful.client.movetotag),
                        awful.button({ }, 3, awful.tag.viewtoggle),
                        awful.button({ modkey }, 3, awful.client.toggletag),
                        awful.button({ }, 4, awful.tag.viewnext),
                        awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function(c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function()
                                              awful.client.focus.byidx(1)
                                              if client.focus then
                                                  client.focus:raise()
                                              end
                                          end),
                     awful.button({ }, 5, function()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then
                                                  client.focus:raise()
                                              end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, nextlayout),
                           awful.button({ }, 3, prevlayout),
                           awful.button({ }, 4, nextlayout),
                           awful.button({ }, 5, prevlayout)
                          ))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s,
                                        awful.widget.taglist.label.all,
                                        mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        -- {
            mylayoutbox[s],
        -- mastcolright,
        -- colwidget,
        -- mastwidget,
        -- mastcolleft,
            -- layout = awful.widget.layout.horizontal.rightleft
        -- },
        s == 1 and mytextclock or nil,
        s == 1 and mysystray or nil,
        -- meminfo,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
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
    awful.key({ modkey,           }, "w", function() mymainmenu:toggle() end),

    awful.key({}, "F1", function() awful.screen.focus(1) end),
    awful.key({}, "F2", function() awful.screen.focus(2) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function() awful.client.swap.byidx(1) end),
    awful.key({ modkey, "Shift"   }, "k", function() awful.client.swap.byidx(-1) end),
    awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then client.focus:raise() end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn_with_shell(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ "Mod1", "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", nextlayout),
    awful.key({ modkey, "Shift"   }, "space", prevlayout),

    -- Prompt
    awful.key({ modkey }, "r", obvious.popup_run_prompt.run_prompt),
    -- awful.key({ modkey }, "space",
    --     function ()
    --         local prefix = "PATH=/usr/local/bin:/usr/bin:/bin:$HOME/.local/bin "
    --         local path_cmd = prefix .. "dmenu_path | dmenu -b -nb '#222222'"
    --         path_cmd = path_cmd .. " -nf '#aaaaaa' -sb '#ff0000' -sf '#ffffff'"
    --         local myexe = awful.util.pread(path_cmd)
    --         awful.util.spawn_with_shell(prefix .. myexe)
    --     end),

    awful.key({ modkey }, "x",
        function ()
            awful.prompt.run({ prompt = "Run Lua code: " },
                mypromptbox[mouse.screen].widget,
                awful.util.eval, nil,
                awful.util.getdir("cache") .. "/history_eval")
        end),

    awful.key({ modkey, }, "Prior", volume_up),
    awful.key({ modkey, }, "Next", volume_down),

    -- awful.key({ }, "#172", function () awful.util.spawn("rhythmbox-client --play-pause") end),
    -- awful.key({ }, "#173", function () awful.util.spawn("rhythmbox-client --previous") end),
    -- awful.key({ }, "#171", function () awful.util.spawn("rhythmbox-client --next") end),

    awful.key({ modkey, "Control" }, "l", function () awful.util.spawn("screen-lock") end),
    -- Alt+Ctrl+l
    awful.key({ "Mod1", "Control" }, "l", function () awful.util.spawn("screen-lock") end),
    awful.key({ modkey }, "e", revelation.revelation)
)

keynumber = 1
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewonly(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end
-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
do
    clientkeys = awful.util.table.join(
        awful.key({ modkey,           }, "o",     awful.client.movetoscreen),
        awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle),
        awful.key({ modkey,           }, "f",
            function (c)
                c.fullscreen = not c.fullscreen
            end),
        awful.key({ modkey }, "F4",
            function (c)
                c:kill()
            end),
        awful.key({ modkey, "Control" }, "Return",
            function (c)
                c:swap(awful.client.getmaster())
            end),
        awful.key({ modkey, "Shift"   }, "r",
            function (c)
                c:redraw()
            end),
        awful.key({ modkey,           }, "n",
            function (c)
                c.minimized = not c.minimized
            end),
        awful.key({ modkey,           }, "m",
            function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c.maximized_vertical   = not c.maximized_vertical
            end)
    )

    clientbuttons = awful.util.table.join(
        awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
        awful.button({ modkey }, 1, awful.mouse.client.move),
        awful.button({ modkey }, 3, awful.mouse.client.resize))

    awful.rules.rules = {
        -- All clients will match this rule.
        { rule = { },
          properties = { border_width = beautiful.border_width,
                         border_color = beautiful.border_normal,
                         size_hints_honor = false,
                         focus = true,
                         keys = clientkeys,
                         buttons = clientbuttons } },
        { rule = { class = "gimp" },
          properties = { floating = true } },
        { rule = { class = "Firefox" },
          properties = { tag = tags[1][2] } },
        { rule = { class = "chrome" },
          properties = { tag = tags[1][1] } },
        { rule = { name = "Google Hangouts" },
          properties = { tag = tags[1][2] } },
        { rule = { name = "Chat" },
          properties = { tag = tags[1][2] } },
        { rule = { instance = "google-chrome (.config/personal-chrome)" },
          properties = { tag = tags[1][3] } },
        { rule = { class = "Pidgin" },
          properties = { tag = tags[2][3] } },
        { rule = { class = "xchat-gnome" },
          properties = { tag = tags[2][4] } },
        { rule = { class = "Thunderbird" },
          properties = { tag = tags[1][3] } },
        { rule = { name = "Music Player" },
          properties = { tag = tags[1][5] } },
    }
end
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })
    --

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

-- focus / unfocused borders around clients
do
    function setfocus(c)
        c.border_color = beautiful.border_focus
    end
    function setnormal(c)
        c.border_color = beautiful.border_normal
    end
    client.add_signal("focus", setfocus)
    client.add_signal("unfocus", setnormal)
end
-- }}}

-- do not put a client in "urgent" mode if it's visible
    local old_add = awful.client.urgent.add
    function wrapper(c, property)
        if c:isvisible() then
            -- dont set as urgent if visible
            awful.client.urgent.delete(c)
            return
        else
            old_add(c, property)
        end
    end
    awful.client.urgent.add = wrapper

for i = 1,#tags[1] do
    tags[1][i]:add_signal("property::ncol", function()
        colwidget.text = obvious.lib.markup.fg.color(orange, awful.tag.getncol())
    end)
    tags[1][i]:add_signal("property::nmaster", function()
        mastwidget.text = obvious.lib.markup.fg.color(blue, awful.tag.getnmaster())
    end)
    tags[1][i]:add_signal("property::selected", function()
        colwidget.text = obvious.lib.markup.fg.color(orange, awful.tag.getncol())
        mastwidget.text = obvious.lib.markup.fg.color(blue, awful.tag.getnmaster())
    end)
end


-- awful.util.spawn_with_shell("sleep 2 && ~/.local/bin/wallpaper")
-- urgh this crashes
-- awful.util.spawn("xautolock -time 5 -locker '/usr/local/google/home/ndumazet/.local/bin/screen-lock'")
