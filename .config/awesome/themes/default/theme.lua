---------------------------
-- Default awesome theme --
---------------------------
--

-- ! Base16 Flat
-- ! Scheme: Chris Kempson (http://chriskempson.com)

base00 = "#2C3E50"
base01 = "#34495E"
base02 = "#7F8C8D"
base03 = "#95A5A6"
base04 = "#BDC3C7"
base05 = "#e0e0e0"
base06 = "#f5f5f5"
base07 = "#ECF0F1"
base08 = "#E74C3C"
base09 = "#E67E22"
base0A = "#F1C40F"
base0B = "#2ECC71"
base0C = "#1ABC9C"
base0D = "#3498DB"
base0E = "#9B59B6"
base0F = "#be643c"

-- not sure where it comes from but it's nice.
wut = "#5F87AF"

theme = {}

local awful = require("awful")

home          = os.getenv("HOME")
config        = awful.util.getdir("config")
shared        = "/usr/share/awesome"
if not awful.util.file_readable(shared .. "/icons/awesome16.png") then
    shared    = "/usr/share/local/awesome"
end
sharedicons   = shared .. "/icons"
sharedthemes  = shared .. "/themes"
-- themes        = config .. "/themes"
themes = sharedthemes
themename     = "/default"
if not awful.util.file_readable(themes .. themename .. "/theme.lua") then
       themes = sharedthemes
end
themedir      = themes .. themename


theme.font          = "Hack 9"

-- dark
theme.bg_normal     = base00
-- blue
theme.bg_focus      = wut
-- orange
theme.bg_urgent     = base09
theme.bg_minimize   = "#444444"

-- white-ish
theme.fg_normal     = base07
theme.fg_focus      = base07
theme.fg_urgent     = base06
theme.fg_minimize   = base06

theme.border_width  = "2"
theme.border_normal = base00
theme.border_focus  = base0D
theme.border_marked = "#91231c"

-- There are another variables sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- Example:
--taglist_bg_focus = #ff0000

-- Display the taglist squares
theme.taglist_squares_sel = themedir .. "/taglist/squarefw.png"
theme.taglist_squares_unsel = themedir .. "/taglist/squarew.png"

theme.tasklist_floating_icon = themedir .. "/tasklist/floatingw.png"

-- Variables set for theming menu
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themedir .. "/submenu.png"
theme.menu_height   = "15"
theme.menu_width    = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--bg_widget    = #cc0000

-- Define the image to load
theme.titlebar_close_button_normal = themedir .. "/titlebar/close_normal.png"
theme.titlebar_close_button_focus = themedir .. "/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = themedir .. "/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = themedir .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themedir .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themedir .. "/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themedir .. "/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themedir .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themedir .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themedir .. "/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themedir .. "/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themedir .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themedir .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themedir .. "/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themedir .. "/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = themedir .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themedir .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = themedir .. "/titlebar/maximized_focus_active.png"

theme.awesome_icon = sharedicons .. "/awesome16.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "awsetbg /usr/share/awesome/themes/default/background.png" }

theme.layout_fairh = themedir .. "/layouts/fairhw.png"
theme.layout_fairv = themedir .. "/layouts/fairvw.png"
theme.layout_floating  = themedir .. "/layouts/floatingw.png"
theme.layout_magnifier = themedir .. "/layouts/magnifierw.png"
theme.layout_max = themedir .. "/layouts/maxw.png"
theme.layout_fullscreen = themedir .. "/layouts/fullscreenw.png"
theme.layout_tilebottom = themedir .. "/layouts/tilebottomw.png"
theme.layout_tileleft   = themedir .. "/layouts/tileleftw.png"
theme.layout_tile = themedir .. "/layouts/tilew.png"
theme.layout_tiletop = themedir .. "/layouts/tiletopw.png"
theme.layout_spiral  = themedir .. "/layouts/spiralw.png"
theme.layout_dwindle = themedir .. "/layouts/dwindlew.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
