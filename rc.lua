-- {{{  libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

--https://awesomewm.org/doc/api/documentation/05-awesomerc.md.html
-- Standard awesome library
local gears         = require("gears") --Utilities such as color parsing and objects
local awful         = require("awful") --Everything related to window managment
                      require("awful.autofocus")
-- Widget and layout library
local wibox         = require("wibox")

-- Theme handling library
local beautiful     = require("beautiful")

-- Notification library
local naughty       = require("naughty")
naughty.config.defaults['icon_size'] = 30
--naughty.config.timeout = 15
--naughty.config.default.font = "JetBrainsMono Nerd Font 11"
naughty.config.font = "Ubuntu Mono Bold 12"
naughty.config.position = "bottom_right"

-- local menubar       = require("menubar")

local lain          = require("lain")
-- local freedesktop   = require("freedesktop")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")
local my_table      = awful.util.table or gears.table -- 4.{0,1} compatibility
-- }}}

local volume_widget = require('awesome-wm-widgets.pactl-widget.volume')
-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}



-- {{{ Autostart windowless processes
-- local function run_once(cmd_arr)
--     for _, cmd in ipairs(cmd_arr) do
--         awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
--     end
-- end

--run_once({ "unclutter -root" }) -- entries must be comma-separated
-- }}}


-- {{{ Variable definitions

local themes = {
    "powerarrow-blue", -- 1
    "powerarrow",      -- 2
    "multicolor",      -- 3

}

-- choose your theme here
local chosen_theme = themes[1]

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)

-- modkey or mod4 = super key
local modkey       = "Mod4"
local altkey       = "Mod1"
local modkey1      = "Control"

-- personal variables
--change these variables if you want
local browser           = "chromium"
local editor            = os.getenv("EDITOR") or "nvim"
local editorgui         = "geany"
local filemanager       = "thunar"
local mailclient        = "geary"
local mediaplayer       = "vlc"
local scrlocker         = "slimlock"
local terminal          = "st"
-- local terminal          = "st"
local virtualmachine    = "virtualbox"

-- awesome variables
awful.util.terminal = terminal
--awful.util.tagnames = {  " ", " ", " ", " ", " ", " ", " ", " ", " ", " "  }
--awful.util.tagnames = { "⠐", "⠡", "⠲", "⠵", "⠻", "⠿" }
--awful.util.tagnames = { "⌘", "♐", "⌥", "ℵ" }
--awful.util.tagnames = { " DEV ", " WWW ", " SYS ", " DOC ", " VBOX ", " CHAT ", " MUS ", " VID ", " GFX " }
awful.util.tagnames = { " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 " }
-- Use this : https://fontawesome.com/cheatsheet
--awful.util.tagnames = { "", "", "", "", "" }
awful.layout.suit.tile.left.mirror = true
awful.layout.layouts = {
  awful.layout.suit.tile,
  -- awful.layout.suit.floating,
  -- awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.max,
  -- awful.layout.suit.tile.top,
  -- awful.layout.suit.fair,
  -- awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
  -- lain.layout.cascade,
  -- lain.layout.cascade.tile,
  -- lain.layout.centerwork,
  -- lain.layout.centerwork.horizontal,
  -- lain.layout.termfair,
  -- lain.layout.termfair.center,
}

awful.util.taglist_buttons = my_table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    -- awful.button({ modkey }, 3, function(t)
    --     if client.focus then
    --         client.focus:toggle_tag(t)
    --     end
    -- end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = my_table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
           c:emit_signal("request::activate", "tasklist", {raise = true})
        end
    end),

    awful.button({ }, 3, function () awful.spawn("jgmenu_run", false) end),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end),
    awful.button({ }, 2, function (c) c:kill() end)
)

-- lain.layout.termfair.nmaster           = 3
--lain.layout.termfair.ncol              = 1
--lain.layout.termfair.center.nmaster    = 3
--lain.layout.termfair.center.ncol       = 1
--lain.layout.cascade.tile.offset_x      = 2
--lain.layout.cascade.tile.offset_y      = 32
--lain.layout.cascade.tile.extra_padding = 5
--lain.layout.cascade.tile.nmaster       = 5
--lain.layout.cascade.tile.ncol          = 2

beautiful.init(string.format(gears.filesystem.get_configuration_dir() .. "/themes/%s/theme.lua", chosen_theme))
-- }}}



-- {{{ Menu
--local myawesomemenu = {
--    { "Hotkeys", function() return false, hotkeys_popup.show_help end },
--   { "Manual", terminal .. " -e 'man awesome'" },
--}

-- awful.util.mymainmenu = freedesktop.menu.build({
--     icon_size = beautiful.menu_height or 16,
--     before = {
--         { "Awesome Hotkeys", function() return false, hotkeys_popup.show_help end, beautiful.awesome_icon }
--         --{ "Atom", "atom" },
--         -- other triads can be put here
--     },
--     after = {
--         { "Log Out", function() awesome.quit() end, "/usr/share/icons/Papirus/24x24/apps/system-log-out.svg" },
--         { "Reboot", "systemctl reboot", "/usr/share/icons/Papirus/24x24/apps/system-reboot.svg" },
-- 		  { "Restart Awesome", awesome.restart, "/usr/share/icons/Papirus/24x24/apps/systemback.svg" },
--         { "Shutdown", "systemctl poweroff", "/usr/share/icons/Papirus/24x24/apps/system-shutdown.svg" }
--         -- other triads can be put here
--     }
-- })
-- menubar.utils.terminal = "st" -- Set the Menubar terminal for applications that require it
-- }}}

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
-- }}}



-- {{{ Mouse bindings
root.buttons(
--    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end)
    awful.button({ }, 3, function () awful.spawn("jgmenu_run", false) end)
	 -- awful.button({ modkey }, 4, awful.tag.viewnext),
    -- awful.button({ modkey }, 5, awful.tag.viewprev)
)
-- }}}
-- local function checkWibarForTag(t)
--     t.screen.mywibox.visible = t.barvisible
-- end
--
-- local function toggleWibarForTag()
--     local t = awful.screen.focused().selected_tag
--     t.barvisible = not t.barvisible
--     checkWibarForTag(t)
-- end

function checkWibarForTag(t)
    if not t.screen or not t.screen.mywibox then return end
    t.screen.mywibox.visible = t.statusbarvisible
end

function toggleWibarForTag()
    local t = awful.screen.focused().selected_tag
    t.statusbarvisible = not t.statusbarvisible
    checkWibarForTag(t)
end

-- {{{ Key bindings
globalkeys = my_table.join(

    -- {{{ Personal keybindings
    -- 
    -- dmenu
    awful.key({ modkey,  }, "d",
    function ()
        awful.spawn(string.format("dmenu_run -i  -h '21' -nb '#24283b' -nhb '#24283b' -nf '#a8b4ff' -nhf '#ffb26b' -sb '#c387ea' -sf '#24283b' -shb '#24283b' -shf '#a8b4ff' -fn 'JetBrains Mono:style=ExtraBold:size=10'"), false)
	end,
    {description = "show dmenu", group = "hotkeys"}),
    -- screenshots
    awful.key({ }, "Print", function () awful.util.spawn("scrot 'ArcoLinuxD-%Y-%m-%d-%s_screenshot_$wx$h.jpg' -e 'mv $f $$(xdg-user-dir PICTURES)'") end,
        {description = "Scrot", group = "screenshots"}),
    awful.key({ modkey1           }, "Print", function () awful.util.spawn( "xfce4-screenshooter" ) end,
        {description = "Xfce screenshot", group = "screenshots"}),
    awful.key({ modkey }, "F1", function () awful.util.spawn( "chromium --force-dark-mode" ) end,
        {description = "Chromium", group = "screenshots"}),
    awful.key({ modkey }, "F9", function () awful.util.spawn( "alacritty" ) end,
        {description = "Chromium", group = "screenshots"}),
    awful.key({ modkey }, "n", function () awful.util.spawn( "nitrogen" ) end,
        {description = "Nitrogen", group = "screenshots"}),
    awful.key({ modkey }, "F2", function () awful.util.spawn( "firefox" ) end,
        {description = "Firefox", group = "screenshots"}),
    awful.key({ modkey1, "Shift"  }, "Print", function() awful.util.spawn("gnome-screenshot -i") end,
        {description = "Gnome screenshot", group = "screenshots"}),

    -- Personal keybindings}}}


    -- Hotkeys Awesome

    awful.key({ modkey,           }, "F5",      hotkeys_popup.show_help,
        {description = "show help", group="awesome"}),

    -- Tag browsing with modkey
    --awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
        --{description = "view previous", group = "tag"}),
    --awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
        --{description = "view next", group = "tag"}),
    awful.key({ altkey,           }, "Escape", awful.tag.history.restore,
        {description = "go back", group = "tag"}),

     -- Tag browsing alt + tab
    awful.key({ altkey,           }, "Tab",   awful.tag.viewnext,
        {description = "view next", group = "tag"}),
    awful.key({ altkey, "Shift"   }, "Tab",  awful.tag.viewprev,
        {description = "view previous", group = "tag"}),

     -- Tag browsing modkey + tab
    --awful.key({ modkey,           }, "Tab",   awful.tag.viewnext,
      --  {description = "view next", group = "tag"}),
    --awful.key({ modkey, "Shift"   }, "Tab",  awful.tag.viewprev,
     --   {description = "view previous", group = "tag"}),


    -- Non-empty tag browsing
    awful.key({ modkey }, "Tab", function () lain.util.tag_view_nonempty(1) end,
              {description = "view  next nonempty", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Tab", function () lain.util.tag_view_nonempty(-1) end,
              {description = "view  previous nonempty", group = "tag"}),

    -- Default client focus
    awful.key({ modkey,           }, "j",
        function ()
          awful.client.focus.byidx( 1)
          -- for _, c in ipairs(mouse.screen.selected_tag:clients()) do
          --   if not c.maximized then
          --     c:raise()
          --   elseif client.focus and c.maximized then
          --     client.focus:raise()
          --   end
          -- end
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- By direction client focus

    --awful.key({ modkey,           }, "w", function () awful.util.mymainmenu:show() end,
      --        {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey }, ".", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey }, ",", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    -- awful.key({ modkey1,           }, "Tab",
    --     function ()
    --         awful.client.focus.history.previous()
    --         if client.focus then
    --             client.focus:raise()
    --         end
    --     end,
    --     {description = "go back", group = "client"}),

    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
      toggleWibarForTag()
    end,
        {description = "toggle wibox per tag", group = "awesome"}),
    awful.key({ modkey, "Shift" }, "b", function ()
            -- for s in screen do
            --     s.mywibox.visible = not s.mywibox.visible
            --     if s.mybottomwibox then
            --         s.mybottomwibox.visible = not s.mybottomwibox.visible
            --     end
            -- end
            local s = awful.screen.focused()
            s.mywibox.visible = not s.mywibox.visible
            for _, t in pairs(s.tags) do
                t.statusbarvisible = s.mywibox.visible
            end
        end,
        {description = "toggle wibox per screen", group = "awesome"}),

    -- On the fly useless gaps change
    awful.key({ modkey }, "equal", function () lain.util.useless_gaps_resize(1) end,
              {description = "increment useless gaps", group = "tag"}),
    awful.key({ modkey }, "minus", function () lain.util.useless_gaps_resize(-1) end,
              {description = "decrement useless gaps", group = "tag"}),


    -- awful.key({ modkey }, "Page_Up", 
    --     function ()
    --       for _, c in ipairs(mouse.screen.selected_tag:clients()) do
    --         if c then
		  --       c.border_width = c.border_width + 1
    --         end
    --       end
    --     end,
    --           {description = "increment borders", group = "tag"}),
    -- Dynamic tagging
    --awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end,
     --         {description = "add new tag", group = "tag"}),
    -- awful.key({ modkey, "Control" }, "r", function () lain.util.rename_tag() end,
    --           {description = "rename tag", group = "tag"}),
    -- awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
    --           {description = "move tag to the left", group = "tag"}),
    -- awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
    --           {description = "move tag to the right", group = "tag"}),
    -- awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end,
    --           {description = "delete tag", group = "tag"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = terminal, group = "super"}),
    awful.key({ modkey, "Shift"   }, "Return", function () awful.spawn(filemanager) end,
              {description = "PCManFM", group = "super"}),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q",  function () awful.spawn.with_shell("~/.config/awesome/scripts/ascript.sh") end,
              {description = "quit awesome", group = "awesome"}),



    awful.key({ modkey,    }, "semicolon",     function () awful.tag.incmwfact( 0.025)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,    }, "h",     function () awful.tag.incmwfact(-0.025)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
   awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
             {description = "select next", group = "layout"}),
    --awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
             -- {description = "select previous", group = "layout"}),

    awful.key({ modkey }, "s",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      c.minimized = false
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- ALSA volume control 
    --awful.key({ modkey1 }, "Up",
    awful.key({ modkey }, "KP_Add",
        function ()
          -- os.execute("pactl -- set-sink-volume 0 +5%")
          volume_widget:inc(5)
        end),
    -- awful.key({ modkey, "Shift" }, "KP_Add",
    --     function ()
    --         os.execute("pactl -- set-sink-volume 0 +5%")
    --     end),
    --awful.key({ modkey1 }, "Down",
    awful.key({ modkey }, "KP_Subtract",
        function ()
          -- os.execute("pactl -- set-sink-volume 0 -5%")
          volume_widget:dec(5)
        end),
    awful.key({ }, "XF86AudioMute",
        function ()
            os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({ modkey1, "Shift" }, "m",
        function ()
            os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({ modkey1, "Shift" }, "0",
        function ()
            os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
            beautiful.volume.update()
        end),
        awful.key({modkey, "Shift"}, 'm',
        function ()
          for _, c in ipairs(mouse.screen.selected_tag:clients()) do
            if c then
              c.minimized = false
            end
          end
        end,
        {description = "min/max all windows", group = "client"}
        ),
        awful.key({modkey, "Shift"}, 'n',
        function ()
          for _, c in ipairs(mouse.screen.selected_tag:clients()) do
            if not c.minimized then
              c.minimized = true
            end
          end
        end,
        {description = "min/max all windows", group = "client"}
        ),
    -- Copy primary to clipboard (terminals to gtk)
    awful.key({ modkey }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
              {description = "copy terminal to gtk", group = "hotkeys"}),
    -- Copy clipboard to primary (gtk to terminals)
    awful.key({ modkey }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
              {description = "copy gtk to terminal", group = "hotkeys"})


)

clientkeys = my_table.join(
    awful.key({ altkey, "Shift"   }, "m",      lain.util.magnify_client,
              {description = "magnify client", group = "client"}),
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,    }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "hotkeys"}),
   --  awful.key({ modkey, }, "space",  
		 -- function (c)
			--  c.maximized = false
			--  awful.client.floating.toggle(c)
		 -- end,
              -- {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
             {description = "toggle keep on top", group = "client"}),
   awful.key({ modkey,           }, "y",
       function (c)
           c.minimized = true
       end ,
       {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {description = "move focused client to tag #", group = "tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
    end
    globalkeys = my_table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  descr_view),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  descr_toggle),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  descr_move),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  descr_toggle_focus)
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey, "Shift" }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        c.floating = not c.floating
        if c.floating then
          lain.util.mc(c, width_f, height_f)
        end
    end),
    awful.button({ modkey, "Shift"  }, 2, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
            c.maximized = not c.maximized
            c:raise()
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        if not c.floating then
          c.floating = not c.floating
        end
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}



-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.centered+awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = true
     }
    },

    -- Titlebars
    { rule_any = { type = { "dialog" } },
      properties = { titlebars_enabled = true } },

    -- Set applications to always map on the tag 1 on screen 1.
    -- find class or role via xprop command
    --{ rule = { class = browser1 },
      --properties = { screen = 1, tag = awful.util.tagnames[1] } },

    --{ rule = { class = editorgui },
        --properties = { screen = 1, tag = awful.util.tagnames[2] } },

    --{ rule = { class = "Geany" },
        --properties = { screen = 1, tag = awful.util.tagnames[2] } },

    -- Set applications to always map on the tag 3 on screen 1.
    --{ rule = { class = "Inkscape" },
        --properties = { screen = 1, tag = awful.util.tagnames[3] } },

    -- Set applications to always map on the tag 4 on screen 1.
    --{ rule = { class = "Gimp" },
        --properties = { screen = 1, tag = awful.util.tagnames[4] } },

    -- Set applications to be maximized at startup.
    -- find class or role via xprop command

    { rule = { class = "Gimp*", role = "gimp-image-window" },
          properties = { maximized = true } },

    { rule = { class = "inkscape" },
          properties = { maximized = true } },

    { rule = { class = "VirtualBox Manager" },
          properties = { maximized = true } },

    { rule = { class = "VirtualBox Machine" },
          properties = { maximized = true } },

    { rule = { class = "Xfce4-settings-manager" },
          properties = { floating = false } },



    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
        },
        class = {
          "Arandr",
          "Audacious",          
          "Blueberry",
          "Deadbeef",
          "Galculator",
          "Gnome-font-viewer",
          "Gpick",
          "Imagewriter",
          "Font-manager",
          -- "feh",
          "Kruler",
          "Kvantum Manager",
          "Io.github.celluloid_player.Celluloid",
          "Lxappearance",          
          "MessageWin",  -- kalarm.
          "Nitrogen",          
          "Oblogout",
          "Peek",
			 "qt5ct",
          "Skype",
          "System-config-printer.py",
          "Sxiv",
          "Unetbootin.elf",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "Viewnior",          
          "vlc",           
          "mpv",           
          "Xfce4-appfinder",
	  "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
          "Preferences",
          "setup",
        }
      }, properties = { floating = true }},

}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)



-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = my_table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {size = 21}) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c),
					 font = "JetBrains Mono ExtraBold 10"
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.minimizebutton(c),
            --awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
--client.connect_signal("mouse::enter", function(c)
--    c:emit_signal("request::activate", "mouse_enter", {raise = true})
--end)

client.connect_signal("property::floating", function(c)
    if c.floating then
        awful.titlebar.show(c)
		  c.border_color = beautiful.border_color_floating
		  c.border_width = 1
    elseif c.maximized and not c.floating then
        awful.titlebar.hide(c)
		  c.border_color = beautiful.border_focus
		  c.border_width = 8
        -- awful.client.floating.toggle(c)
    else
        awful.titlebar.hide(c)
		  c.border_color = beautiful.border_focus
		  c.border_width = beautiful.border_width
    end
end)


-- No border for maximized clients
function border_adjust(c)
-- local current_layout = awful.tag.getproperty(t, "layout")
local current_layout = awful.layout.get(mouse.screen)
    if c.maximized or current_layout == awful.layout.suit.max and not c.floating then -- no borders if only 1 client visible
		  awful.titlebar.hide(c)
        c.border_width = 0
		  c.border_color = beautiful.border_focus
    elseif #awful.screen.focused().clients > 0 then
        c.border_width = beautiful.border_width
        c.border_color = beautiful.border_focus
		  if c.floating then
			  awful.titlebar.show(c)
			  c.border_color = beautiful.border_color_floating
			  c.border_width = 1
		  end
    end
end

client.connect_signal("focus", border_adjust)
-- client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("property::maximized", border_adjust)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
tag.connect_signal("property::layout", function(t)
  t.gap = beautiful.useless_gap
  local clients = awful.client.visible(s)
  local l = awful.layout.get(mouse.screen)
   for _, c in pairs(clients) do
     if l == awful.layout.suit.max and not c.floating then
       t.gap = 0
       c.border_width = 0
    elseif c.floating and not c.maximized then
      c.border_width = 1
    elseif c.maximized then
      c.border_width = 0
     else
       t.gap = beautiful.useless_gap
       c.border_width = beautiful.border_width
     end
   end
end)

for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
  local clients = awful.client.visible(s)
  local layout = awful.layout.getname(awful.layout.get(s))

  for _, c in pairs(clients) do
    -- No borders with only one humanly visible client
    if layout == "max" and not c.floating then
      c.border_width = 0
    end
  end
end)
end
-- Titlebars on Floating Windows

table_is_swallowed = { "[Tt]erm", "[Ss]t", "[Aa]lacritty" } -- Can add PCManFM or Thunar here if wanted
table_cannot_swallow = { "Dragon" }

function is_in_Table(table, element)
    for _, value in pairs(table) do
        if element:match(value) then
            return true
        end
    end
    return false
end

function is_to_be_swallowed(c)
    return (c.class and is_in_Table(table_is_swallowed, c.class)) and true or false
end

function can_swallow(class)
    return not is_in_Table(table_cannot_swallow, class)
end

function copy_size(c, parent_client)
    if (not c or not parent_client) then
        return
    end
    if (not c.valid or not parent_client.valid) then
        return
    end
    if (c.maximized) then
      return
    end
    c.x=parent_client.x;
    c.y=parent_client.y;
    c.width=parent_client.width;
    c.height=parent_client.height;
end
function check_resize_client(c)
    if(c.child_resize) then
        copy_size(c.child_resize, c)
    end
end

function get_parent_pid(child_ppid, callback)
    local ppid_cmd = string.format("ps -o ppid= -p %s", child_ppid)
    awful.spawn.easy_async(ppid_cmd, function(stdout, stderr, reason, exit_code)
        -- primitive error checking
        if stderr and stderr ~= "" then
            callback(stderr)
            return
        end
        local ppid = stdout:gsub(" ", ""):gsub("\n", "")
        callback(nil, ppid)
    end)
end

client.connect_signal("property::size", check_resize_client)
client.connect_signal("property::position", check_resize_client)
client.connect_signal("manage", function(c)
    if is_to_be_swallowed(c) then
        return
    end
    local parent_client=awful.client.focus.history.get(c.screen, 1)
    get_parent_pid(c.pid, function(err, ppid)
        if err then
            error(err)
            return
        end
        parent_pid = ppid
        get_parent_pid(parent_pid, function(err, gppid)
            if err then
                error(err)
                return
            end
            grand_parent_pid = gppid
            if parent_client and (parent_pid:find('^' .. parent_client.pid) or grand_parent_pid:find('^' .. parent_client.pid)) and is_to_be_swallowed(parent_client) and can_swallow(c.class) then
                -- c.floating=true
                -- for _, cl in ipairs(mouse.screen.selected_tag:clients()) do
                --   local c = cl
                --   if c then
                --     c.minimized = true
                --   end
                -- end
                parent_client.child_resize=c
                parent_client.minimized = true
                c:connect_signal("unmanage", function() parent_client.minimized = false end)
                copy_size(c, parent_client)
            end
        end)
    end)
end)






tag.connect_signal("property::selected",checkWibarForTag)

-- }}}
--
--
gears.timer {
        timeout   = 560,
        call_now  = true,
        autostart = true,
        callback  = function()
		  -- naughty.notify({title = "Retrieving Updates", text = "\n Please Wait...", icon = "/home/kbc/.config/awesome/pacman.png"})
		  awful.spawn.easy_async_with_shell("checkupdates > $HOME/.config/awesome/scripts/checktemp", function(stdout) end)
end
}

-- gears.timer.start_new(700, function()
--     collectgarbage("step", 20000)
--     return true
-- end)


-- gears.timer.start_new(60, function()
--   -- just let it do a full collection
-- collectgarbage("incremental", 150, 600, 0)
--   -- collectgarbage()
--   -- or else set a step size
--   -- collectgarbage("step", 30000)
--   return true
-- end)

gears.timer {
       timeout = 700,
       autostart = true,
       callback = function() collectgarbage("incremental", 150, 600, 0)
		  -- naughty.notify({title = "Collecting Garbage", text = "\n Please Wait...", icon = "/home/kbc/.config/awesome/pacman.png"})
      end
}


-- Autostart applications
awful.spawn.easy_async_with_shell("~/.config/awesome/scripts/autostart.sh")
