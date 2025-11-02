local button = require("view.button")
local slider = require("view.slider")
local list = require("view.list")
local text = require("view.text")
local edit_text = require("view.edit_text")
local window = require("container.window")
local select_button = require("view.select_button")
local file_view = require("file_view")
--
--
local line_layout = require("layout.line_layout")

b1 = button:new()
sl1 = slider:new()
li1 = list:new()

--gui:add_view(b1)
--print(b1:out_to_table())
--print(sl1:out_to_table())
--print(li1:out_to_table())
local lay = {
    type        = "line_layout",
    x           = 0,
    y           = 0,
    orientation = "vertical",
    gravity     = "center",
    {
        type = "switch_button",
    },
    {
        type = "button",
    },
    {
        type        = "line_layout",
        orientation = "vertical",
        gravity     = "left|top",
        {
            type = "button",
        },
    }
}





lay2 = {
    type = "sandbox",

}


--print((gui:load_layout(lay)))
ov = gui:add_view(gui:load_layout(lay2))
gui:add_view(gui:load_layout(lay2))

--gui:add_view(gui:load_layout({ type = "window", x = 100, y = 100 })):add_view(gui:load_layout(lay2))
