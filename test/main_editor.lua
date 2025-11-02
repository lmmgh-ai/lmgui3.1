local button = require("view.button")
local slider = require("view.slider")
local list = require("view.list")
local list_free = require "list_free"
local text = require("view.text")
local edit_text = require("view.edit_text")
local image = require("view.image")
--
local title_menu = require("container.title_menu")
local select_menu = require("view.select_menu")
local tab_control = require("container.tab_control")
local border_container = require("container.border_container")
local line = require("layout.line_layout")
local fold_container = require("container.fold_container")
local slider_container = require("container.slider_container")
--

local me = title_menu:new()
local se = select_menu:new({ x = 50, y = 50 })
local se2 = select_menu:new()
local se3 = select_menu:new()
local se4 = select_menu:new()
local se5 = select_menu:new()
local b1 = button:new()
local b2 = button:new({ y = 300 })
local b3 = button:new()
local fol = fold_container:new()
local im = image:new({
    width = 100,
    height = 50,

})
local sc = slider_container:new({
    width = 200,
    height = 200
})
--
local lin = line:new({
    gravity = "center",
    x = 0,
    y = 0,
    height = 400,
    width = 300
})
local tab1 = tab_control:new({
    items = {
        { name = "属性" },
        { name = "编辑" },
        { name = "关于" },
    },
    width = 400,
    height = 400,
})
local tab2 = tab_control:new({
    items = {
        { name = "属性" },
        { name = "编辑" },
        { name = "关于" },
    },
    width = 400,
    height = 400,
})
local bc = border_container:new({ width = 400, height = 400 })
---
--
--gui:add_view(sc)
gui:add_view(se)
gui:add_view(me)
--gui:add_view(b1)
--bc:add_view(lin, "left")
--gui:add_view(tab1)
--gui:add_view(se)
gui:add_view(tab1)
--bc:add_page_view("right", b3)
--bc:add_page_view("left", b1)
--bc:add_page_view("main", lin)
--bc:add_page_view("right", b2)
--bc:add_page_view("bottom", se)
--tab1:add_page_view("属性", b1)
--tab1:add_page_view("编辑", b2)
--tab1:add_page_view("关于", b3
--bc:add_page_view("main", se3)
--bc:add_page_view("bottom", se4)
--bc:add_page_view("top", se5)
--se:add_view(se2)
--print(dump2(bc.children))
se:set_visible(true)
for i = 1, 5 do
    local im = image:new({
        width = 100,
        height = 50,
    })
    --gui:add_view(im)
    --lin:add_view(im)
end


for i, value in pairs(b1) do
    if type(value) == "string" then
        local lin2 = line:new({
            gravity = "center",
            width = 300,
            height = 60,
            orientation = "horizontal"
        })
        -- local text = text:new({ text = i })
        local edit1 = edit_text:new({ text = i })
        local edit = edit_text:new({ text = value })
        --print(lin2, text, edit)
        -- print(i, value)
        -- lin:add_view(lin2)
        -- lin2:add_view(edit1)
        -- lin2:add_view(edit)
    end
end

--[[
gui:add_view(b1)
b1:add_view(b2)
]]
