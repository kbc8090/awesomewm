--[[

     Powerarrow Awesome WM theme
     github.com/lcpz

--]]

local gears = require("gears")
shape = require("gears.shape")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
-- local dpi   = require("beautiful.xresources").apply_dpi

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow-blue"
-- theme.wallpaper                                 = os.getenv("HOME") .. "/Downloads/walls/r5952ibaxbd91.png"
theme.font                                      = "JetBrains Mono ExtraBold 9"
theme.taglist_font                              = "BlexMono Nerd Font Bold 11"
-- theme.taglist_font                              = "JetBrains Mono ExtraBold 12"
theme.tasklist_font										= "JetBrains Mono ExtraBold 10"
theme.fg_normal                                 = "#24283b"
theme.fg_focus                                  = "#24283b"
theme.fg_urgent                                 = "#24283b"
theme.bg_normal                                 = "#24283b"
-- theme.bg_focus                                  = "#f06178"
theme.bg_urgent                                 = "#ffb26b"
theme.icon_theme											= "Papirus-Dark"
theme.taglist_fg_focus                          = "#24283b"
theme.taglist_bg_focus                          = "#548bff"
theme.taglist_bg_empty									= "#24283b"
theme.taglist_fg_empty									= "#a8b4ff"
theme.taglist_fg_occupied								= "#ffb26b"
theme.taglist_bg_occupied								= "#24283b"
theme.tasklist_bg_focus                         = "#c387ea"
theme.tasklist_fg_focus                         = "#24283b"
theme.tasklist_bg_minimize								= "#24283b"
theme.tasklist_fg_minimize								= "#5e6382"
theme.tasklist_font_minimized                   = "JetBrains Mono ExtraBold Italic 10"
-- theme.tasklist_font_minimized                   = "CaskaydiaCove Nerd Font Bold Italic 10"
theme.tasklist_fg_normal								= "#a8b4ff"
theme.tasklist_bg_normal								= "#24283b"
theme.titlebar_fg_normal								= "#a8b4ff"
theme.titlebar_bg_normal								= "#24283b"
theme.titlebar_bg_focus									= "#82dbf8"
theme.titlebar_fg_focus									= "#24283b"
theme.border_width                              = 2
theme.border_normal                             = "#404661"
theme.border_focus                              = "#82dbff"
theme.border_marked                             = "#CC9393"
theme.border_color_floating							= "#82dbff"
-- theme.menu_height                               = 27
-- theme.menu_border_color									= "#000000"
-- theme.menu_border_width									= 1
-- theme.menu_width                                = 230
-- theme.menu_font                                 = "Ubuntu SemiBold 12"
-- theme.menu_fg_focus										= "#24283b"
-- theme.menu_fg_normal										= "#a8b4ff"
-- theme.menu_bg_focus										= "#548bff"
theme.notification_font									= "JetBrains Mono Bold 10"
theme.notification_fg									= "#a8b4ff"
theme.notification_bg									= "#24283b"
theme.notification_border_width                 = 8
theme.notification_border_color                 = "#5e6382"
--theme.notification_timeout			= 8
theme.bg_systray                                = "#24283b" 

theme.systray_icon_spacing                      = 3
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.awesome_icon                              = theme.dir .. "/icons/awesome.png"
theme.taglist_squares_sel                       = gears.surface.load_from_shape(6, 6, gears.shape.rectangle, theme.taglist_fg_focus)
-- theme.taglist_squares_sel_empty                 = gears.surface.load_from_shape(6, 6, gears.shape.octogon, theme.taglist_bg_focus)
theme.taglist_squares_unsel                     = gears.surface.load_from_shape(6, 6, gears.shape.rectangle, theme.taglist_fg_occupied)
-- theme.taglist_squares_unsel_empty               = gears.surface.load_from_shape(6, 6, gears.shape.octogon, theme.taglist_bg_empty)
theme.taglist_spacing									= 1
theme.taglist_shape										= gears.shape.rectangle
theme.taglist_shape_border_width						= 2
theme.taglist_shape_border_width_focus						= 2
theme.taglist_shape_border_color						= "#24283b"
theme.taglist_shape_border_color_focus				= "#548bff"
theme.taglist_shape_border_color_urgent				= "#ffb26b"
theme.taglist_shape_border_width_empty				= 2 
theme.taglist_shape_border_width_volatile				= 2 
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note.png"
theme.widget_music_pause                        = theme.dir .. "/icons/pause.png"
theme.widget_music_stop                         = theme.dir .. "/icons/stop.png"
theme.widget_vol                                = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
theme.widget_task                               = theme.dir .. "/icons/task.png"
theme.widget_scissors                           = theme.dir .. "/icons/scissors.png"
theme.widget_weather                            = theme.dir .. "/icons/dish.png"
theme.titlebar_close_button_focus               = theme.dir .. "/icons/close_normal.png"
theme.titlebar_minimize_button_focus               = theme.dir .. "/icons/minimize_normal.png"
theme.titlebar_minimize_button_normal               = theme.dir .. "/icons/minimize_normal.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/ontop_normal_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/ontop_normal_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = false
theme.tasklist_icon_size                        = 5
--theme.titlebar.enable_tooltip							= false
theme.useless_gap                               = 3
awesome.set_preferred_icon_size(16)
local markup = lain.util.markup
local separators = lain.util.separators

local tooltip_preset = {
  font = "JetBrains Mono ExtraBold 10",
  fg   = "#a8b4ff",
  bg   = "#24283b",
  border_width = 1,
  border_color = "#5e6382",
  mode = "outside",
  margins = 6,
  preferred_positions = { "bottom" },
}

myawesomemenu = {
   { 'hotkeys', function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { 'manual', 'xterm' .. ' -e man awesome' },
   { 'restart', awesome.restart },
   { 'quit', function() awesome.quit() end }
}

mymainmenu = awful.menu({ items = { { 'awesome', myawesomemenu, theme.awesome_icon },
                                    { 'open terminal', 'xterm'}
                                  }
                        })

mylauncher = awful.widget.launcher({ image = theme.awesome_icon,
                                     menu = mymainmenu })


-- Textclock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = awful.widget.watch(
    "date +'%a, %b %d %I:%M %p'", 60,
    function(widget, stdout)
        widget:set_markup("  " .. markup.font(theme.font, stdout))
    end
)


-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { clock },
    notification_preset = {
        fg   = "#a8b4ff",
        bg   = theme.bg_normal
    }
})

-- ALSA volume
-- theme.volume = lain.widget.pulsebar({
--     --togglechannel = "IEC958,3",
--     notification_preset = { font = theme.font, fg = theme.fg_normal },
-- })

-- MEM
local memicon = wibox.widget.textbox("  ")
local widgetspace = wibox.widget.textbox(" ")
-- This is the correct way

local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, "" .. mem_now.used .. "MB "))
    end
})

local cpuicon = wibox.widget.imagebox(theme.widget_cpu)

--[[ Weather
https://openweathermap.org/
Type in the name of your city
Copy/paste the city code in the URL to this file in city_id
--]]
-- local weathericon = wibox.widget.imagebox(theme.widget_weather)
local weathericon = wibox.widget.textbox("  ")
 theme.weather = lain.widget.weather({
     city_id = 4156404, -- placeholder (Belgium)
     notification_preset = { font = "JetBrains Mono Bold 10", fg = "#a8b4ff" },
     weather_na_markup = markup.fontfg(theme.font, "#24283b", "N/A "),
     settings = function()
         descr = weather_now["weather"][1]["description"]:lower()
         units = math.floor(weather_now["main"]["temp"])
         widget:set_markup(markup.fontfg(theme.font, "#24283b", descr .. " @ " .. units .. "°F "))
     end
 })

-- ALSA volume
local volicon = wibox.widget.textbox("  ")
-- theme.volume = lain.widget.alsa({
--     settings = function()
--         if volume_now.status == "off" then
--             volicon:set_text(" ")
--         elseif tonumber(volume_now.level) == 0 then
--             volicon:set_text(" ")
--         elseif tonumber(volume_now.level) <= 50 then
--             volicon:set_text(" 墳 ")
--         else
--             volicon:set_text("  ")
--         end
--
--         widget:set_markup(markup.font(theme.font, " " .. volume_now.level .. "% "))
--     end
-- })

-- Checkupdates 
--local checkupd = awful.widget.watch('fish -c "checkupdates | wc -l"', 1200) 
--local checkupd = awful.widget.watch('bash -c "set -o pipefail; checkupdates | wc -l"', 1200)
--awful.spawn.easy_async_with_shell("checkupdates | wc -l", function(stdout)
local newvolume = awful.widget.watch('/home/kbc/.config/awesome/scripts/volume.sh', 3)
local memory = awful.widget.watch('/home/kbc/.config/awesome/scripts/memory', 3)
local kernelicon = wibox.widget.textbox("  ")
local kernel = awful.widget.watch('bash -c "uname -r"', 36000)
-- local wttr = awful.widget.watch('/home/kbc/.config/awesome/scripts/wttr.sh', 600)
local checkupd = awful.widget.watch('bash -c "sleep 5 && $HOME/.config/awesome/scripts/checkupdates.sh"', 620, function(widget, stdout, stderr, exit) 
    widget:set_markup(markup.fontfg(theme.font, "#24283b", stdout .. " " .. stderr))
	 -- valign = "center"
end)
local updicon = wibox.widget.textbox("  ")
local updiconblank = wibox.widget.textbox()
updiconblank.text = " "


-- local checkupd_t = awful.tooltip { }
-- checkupd_t:add_to_object(checkupd)

-- local checkupd_t = awful.tooltip {
--     objects        = { checkupd },
--     timer_function = function()
--       awful.spawn.easy_async_with_shell("cat /home/kbc/.config/awesome/scripts/checktemp", function(out)
--         checkupd_t.text = out
--       end)
--     end,
-- }


local checkupd_t = awful.tooltip(tooltip_preset)

checkupd_t:add_to_object(checkupd)

checkupd:connect_signal('mouse::enter', function()
      awful.spawn.easy_async_with_shell("cat /home/kbc/.config/awesome/scripts/checktemp", function(stdout)
        checkupd_t.text = stdout
      end)
end)


local kernel_t = awful.tooltip(tooltip_preset)

kernel_t:add_to_object(kernel)

kernel:connect_signal('mouse::enter', function()
      awful.spawn.easy_async_with_shell("/home/kbc/.config/awesome/scripts/uptime.sh", function(out)
        kernel_t.text = out
      end)
end)

-- checkupd:connect_signal('mouse::enter', function()
--     awful.spawn.easy_async_with_shell("notify-send \"$(cat /home/kbc/.config/awesome/scripts/checktemp)\"",  function() end)
-- end)

-- kernel:buttons(gears.table.join(
--     kernel:buttons(),
--     -- awful.button({}, 3, nil, function()
--     --     -- awful.spawn('bash -c "htop"')
--     --     awful.spawn("st -e neofetch")
--     -- end),
--     awful.button({}, 1, nil, function()
--         -- awful.spawn('bash -c "htop"')
--         awful.spawn.easy_async_with_shell("notify-send \"$(uptime --pretty)\"",  function() end)
--     end)
-- ))
--

checkupd:buttons(gears.table.join(
    checkupd:buttons(),
    -- awful.button({}, 1, nil, function()
    --     -- awful.spawn('bash -c "htop"')
    --     awful.spawn.easy_async_with_shell("notify-send \"$(cat /home/kbc/.config/awesome/scripts/checktemp)\"",  function() end)
    -- end),
    awful.button({}, 1, nil, function()
        -- awful.spawn('bash -c "htop"')
        awful.spawn.easy_async_with_shell("st -e sudo pacman -Syyu",  function() end)
    end)
))

-- Separators
local arrow = separators.arrow_left
local arrowright = separators.arrow_right

function theme.powerline_rl(cr, width, height)
    local arrow_depth, offset = height/2, 0

    -- Avoid going out of the (potential) clip area
    if arrow_depth < 0 then
        width  =  width + 2*arrow_depth
        offset = -arrow_depth
    end

    cr:move_to(offset + arrow_depth         , 0        )
    cr:line_to(offset + width               , 0        )
    cr:line_to(offset + width - arrow_depth , height/2 )
    cr:line_to(offset + width               , height   )
    cr:line_to(offset + arrow_depth         , height   )
    cr:line_to(offset                       , height/2 )

    cr:close_path()
end

local function pl(widget, bgcolor, padding)
    return wibox.container.background(wibox.container.margin(widget, 16, 16), bgcolor, theme.powerline_rl)
end

function theme.at_screen_connect(s)
    -- All tags open with layout 1
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    -- s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                          awful.button({ }, 1, function () awful.layout.inc( 1) end),
                          awful.button({ }, 3, function () awful.layout.inc(-1) end),
                          awful.button({ }, 4, function () awful.layout.inc( 1) end),
                          awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
	    screen = s,
	    filter = awful.widget.taglist.filter.all, 
	    buttons = awful.util.taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = wibox.layout.margin(awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons), 1, 0, 0, 0, "#24283b")

    


    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 22, align = center_vertical  })

    -- Add widgets to the wibox
    s.mywibox:setup {
		 {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.align.horizontal,
            --spr,
				--mylauncher,
            s.mytaglist,
				--spr,
        },
        -- s.mytasklist, -- Middle widget
        s.mytasklist,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            --[[ using shapes
            pl(wibox.widget { mpdicon, theme.mpd.widget, layout = wibox.layout.align.horizontal }, "#343434"),
            pl(task, "#343434"),
            --pl(wibox.widget { mailicon, mail and mail.widget, layout = wibox.layout.align.horizontal }, "#343434"),
            pl(wibox.widget { memicon, mem.widget, layout = wibox.layout.align.horizontal }, "#777E76"),
            pl(wibox.widget { cpuicon, cpu.widget, layout = wibox.layout.align.horizontal }, "#4B696D"),
            pl(wibox.widget { tempicon, temp.widget, layout = wibox.layout.align.horizontal }, "#4B3B51"),
            pl(wibox.widget { fsicon, theme.fs.widget, layout = wibox.layout.align.horizontal }, "#CB755B"),
            pl(wibox.widget { baticon, bat.widget, layout = wibox.layout.align.horizontal }, "#8DAA9A"),
            pl(wibox.widget { neticon, net.widget, layout = wibox.layout.align.horizontal }, "#C0C0A2"),
            pl(binclock.widget, "#777E76"),
            --]]
            -- using separators
            --arrow(theme.bg_normal, "#343434"),
           -- wibox.container.background(wibox.container.margin(wibox.widget { mailicon, mail and mail.widget, layout = wibox.layout.align.horizontal }, 4, 7), "#343434"),
           
            -- wibox.container.background(wibox.container.margin(wibox.widget { updicon, checkupd, updiconblank, layout = wibox.layout.align.horizontal }, 3, 3), "#ffb26b"),

            -- wibox.container.background(wibox.container.margin(wibox.widget { widgetspace, layout = wibox.layout.align.horizontal }, 1, 1), "#24283b"),
            wibox.layout.margin(wibox.container.background(wibox.container.margin(wibox.widget { kernelicon, kernel, updiconblank, layout = wibox.layout.align.horizontal }, 3, 3), "#f07178"), 1, 0, 0, 0, "#000000"),
            -- arrow("#82dbff", "#ffb26b"),
            wibox.layout.margin(wibox.container.background(wibox.container.margin(wibox.widget { updicon, checkupd, updiconblank, layout = wibox.layout.align.horizontal }, 3, 3), "#ffb26b"), 1, 0, 0, 0, "#000000"),
            -- arrow("#ffb26b", "#719eff"),
            wibox.layout.margin(wibox.container.background(wibox.container.margin(wibox.widget { volicon, newvolume, layout = wibox.layout.align.horizontal }, 3, 3), "#719eff"), 1, 0, 0, 0, "#000000"),
            -- arrow("#719eff", "#c387ea"),
            wibox.layout.margin(wibox.container.background(wibox.container.margin(wibox.widget { memicon, memory, layout = wibox.layout.align.horizontal }, 3, 3), "#c387ea"), 1, 0, 0, 0, "#000000"),
            -- arrow("#c387ea", "#b7e07c"),
            wibox.layout.margin(wibox.container.background(wibox.container.margin(wibox.widget { weathericon, theme.weather.widget, layout = wibox.layout.align.horizontal }, 3, 0), "#b7e07c"), 1, 0, 0, 0, "#000000"),
            -- arrow("#b7e07c", "#f07178"),
            wibox.layout.margin(wibox.container.background(wibox.container.margin(clock, 3, 9), "#82dbff"), 1, 1, 0, 0, "#000000"),
            -- arrow("#f07178", "#24283b"),
            wibox.container.background(wibox.layout.margin(wibox.widget.systray(), 2, 1, 2, 2), "#24283b"),
            wibox.container.margin(s.mylayoutbox, 2, 4, 2, 2),
        },

    },
	 bottom = 1,
    top = 0,
    left = 0,
    right = 0,
	 color = "#000000",
	 widget = wibox.container.margin,
}
end

return theme
