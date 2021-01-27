--[[

     Powerarrow Awesome WM theme
     github.com/lcpz

--]]

local gears = require("gears")
shape = require("gears.shape")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow-blue"
--theme.wallpaper                                 = theme.dir .. "/starwars.jpg"
theme.font                                      = "Cascadia Code Bold 10"
theme.taglist_font                              = "Cascadia Code Bold 12"
theme.tasklist_font										= "Cascadia Code Bold 11"
theme.fg_normal                                 = "#1b1e2b"
theme.fg_focus                                  = "#35539c"
theme.fg_urgent                                 = "#ffb26b"
theme.bg_normal                                 = "#1b1e2b"
theme.bg_focus                                  = "#5898ED"
theme.bg_urgent                                 = "#3F3F3F"
theme.icon_theme											= "Papirus"
theme.taglist_fg_focus                          = "#1b1e2b"
theme.taglist_bg_focus                          = "#548bff"
theme.taglist_bg_empty									= "#1b1e2b"
theme.taglist_fg_empty									= "#a8b4ff"
theme.taglist_fg_occupied								= "#548bff"
theme.taglist_bg_occupied								= "#404661"
theme.tasklist_bg_focus                         = "#1b1e2b"
theme.tasklist_fg_focus                         = "#ffb26b"
theme.border_width                              = 2
theme.border_normal                             = "#1b1e2b"
theme.border_focus                              = "#ffb26b"
theme.border_marked                             = "#CC9393"
theme.menu_height                               = 27
theme.menu_width                                = 230
theme.menu_font                                 = "Cantarell Bold 11"
theme.menu_fg_focus										= "#1b1e2b"
theme.menu_fg_normal										= "#a8b4ff"
theme.menu_bg_focus										= "#548bff"
theme.notification_font									= "Ubuntu Mono Medium 12"
theme.notification_fg									= "#a8b4ff"
--theme.notification_timeout			= 8
theme.systray_icon_spacing                      = 2
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.awesome_icon                              = theme.dir .. "/icons/awesome.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
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
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = 3

local markup = lain.util.markup
local separators = lain.util.separators

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
        font = "Ubuntu Mono Medium 12",
        fg   = "#a8b4ff",
        bg   = theme.bg_normal
    }
})

-- ALSA volume
theme.volume = lain.widget.pulsebar({
    --togglechannel = "IEC958,3",
    notification_preset = { font = theme.font, fg = theme.fg_normal },
})

-- MEM
local memicon = wibox.widget.textbox(" ")
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. mem_now.used .. "MB "))
    end
})

local cpuicon = wibox.widget.imagebox(theme.widget_cpu)

--[[ Weather
https://openweathermap.org/
Type in the name of your city
Copy/paste the city code in the URL to this file in city_id
--]]
--local weathericon = wibox.widget.imagebox(theme.widget_weather)
local weathericon = wibox.widget.textbox("  ")
theme.weather = lain.widget.weather({
    city_id = 4145719, -- placeholder (Belgium)
    notification_preset = { font = "Ubuntu Mono Medium 11", fg = "#a8b4ff" },
    weather_na_markup = markup.fontfg(theme.font, "#1b1e2b", "N/A "),
    settings = function()
        descr = weather_now["weather"][1]["description"]:lower()
        units = math.floor(weather_now["main"]["temp"])
        widget:set_markup(markup.fontfg(theme.font, "#1b1e2b", descr .. " @ " .. units .. "°F "))
    end
})

-- ALSA volume
local volicon = wibox.widget.textbox("   ")
theme.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volicon:set_text(" ")
        elseif tonumber(volume_now.level) == 0 then
            volicon:set_text(" ")
        elseif tonumber(volume_now.level) <= 50 then
            volicon:set_text(" ")
        else
            volicon:set_text(" ")
        end

        widget:set_markup(markup.font(theme.font, " " .. volume_now.level .. "% "))
    end
})

-- Checkupdates 
--local checkupd = awful.widget.watch('fish -c "checkupdates | wc -l"', 1200) 
--local checkupd = awful.widget.watch('bash -c "set -o pipefail; checkupdates | wc -l"', 1200)
--awful.spawn.easy_async_with_shell("checkupdates | wc -l", function(stdout)
local kernelicon = wibox.widget.textbox("  ")
local kernel = awful.widget.watch('bash -c "uname -r"', 36000)
local checkupd = awful.widget.watch('bash -c "sleep 5 && cat $HOME/.config/awesome/scripts/checktemp | wc -l"', 620, function(widget, stdout, stderr, exit) 
    widget:set_markup(markup.fontfg(theme.font, "#1b1e2b", stdout .. " " .. stderr))
end)
local updicon = wibox.widget.textbox("  ")
local updiconblank = wibox.widget.textbox()
updiconblank.text = " "

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
    --s.mylayoutbox:buttons(my_table.join(
    --                       awful.button({ }, 1, function () awful.layout.inc( 1) end),
    --                       awful.button({ }, 3, function () awful.layout.inc(-1) end),
    --                       awful.button({ }, 4, function () awful.layout.inc( 1) end),
    --                       awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
	    screen = s,
	    filter = awful.widget.taglist.filter.all, 
	    buttons = awful.util.taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
	    screen = s,
	    filter = awful.widget.tasklist.filter.focused
	    --buttons = awful.util.tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 22, align = center_vertical, bg = theme.bg_normal, fg = theme.fg_normal, border_width = 1, border_color = "#000000" })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --spr,
				--mylauncher,
            s.mytaglist,
            --spr,
        },
        s.mytasklist, -- Middle widget
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
           

	    arrow("alpha", "#82dbff"),
            wibox.container.background(wibox.container.margin(wibox.widget { kernelicon, kernel, updiconblank, layout = wibox.layout.align.horizontal }, 3, 3), "#82dbff"),
            arrow("#82dbff", "#ffb26b"),
            wibox.container.background(wibox.container.margin(wibox.widget { updicon, checkupd, updiconblank, layout = wibox.layout.align.horizontal }, 3, 3), "#ffb26b"),
            arrow("#ffb26b", "#719eff"),
            wibox.container.background(wibox.container.margin(wibox.widget { volicon, theme.volume.widget, layout = wibox.layout.align.horizontal }, 3, 3), "#719eff"),
            arrow("#719eff", "#c387ea"),
            wibox.container.background(wibox.container.margin(wibox.widget { memicon, mem.widget, layout = wibox.layout.align.horizontal }, 3, 3), "#c387ea"),
            arrow("#c387ea", "#b7e07c"),
            wibox.container.background(wibox.container.margin(wibox.widget { weathericon, theme.weather.widget, layout = wibox.layout.align.horizontal }, 3, 3), "#b7e07c"),
            arrow("#b7e07c", "#f07178"),
            wibox.container.background(wibox.container.margin(clock, 4, 8), "#f07178"),
            arrow("#f07178", "alpha"),
            wibox.layout.margin(wibox.widget.systray(), 1, 1, 1, 1),
            s.mylayoutbox,
        },
    }
end

return theme
