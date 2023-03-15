local wibox = require("wibox")
local beautiful = require('beautiful')

local widget = {}

local ICON_DIR = os.getenv("HOME") .. '/.config/awesome/awesome-wm-widgets/volume-widget/icons/'

function widget.get_widget(widgets_args)
    local args = widgets_args or {}

    local font = args.font or beautiful.font
    local icon_dir = args.icon_dir or ICON_DIR

    return wibox.widget {
        {
            {
                id = "icon",
                resize = false,
                widget = wibox.widget.textbox,
            },
            valign = 'center',
            layout = wibox.container.place
        },
        {
            id = 'txt',
            font = font,
            widget = wibox.widget.textbox
        },
        layout = wibox.layout.fixed.horizontal,
        set_volume_level = function(self, new_value)
            self:get_children_by_id('txt')[1]:set_text(new_value)
            local volume_icon_name
            if self.is_muted then
                volume_icon_name = " "
            else
                local new_value_num = tonumber(new_value)
                if (new_value_num >= 0 and new_value_num < 33) then
                    volume_icon_name="墳"
                elseif (new_value_num < 66) then
                    volume_icon_name=" "
                else
                    volume_icon_name=" "
                end
            end
            self:get_children_by_id('icon')[1]:set_text(' ')
        end,
        mute = function(self)
            self.is_muted = true
            self:get_children_by_id('icon')[1]:set_text(' ')
        end,
        unmute = function(self)
            self.is_muted = false
        end
    }

end


return widget
