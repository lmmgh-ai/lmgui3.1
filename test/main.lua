local button = require("view.button")
local slider = require("view.slider")
local list = require("view.list")
local text = require("view.text")
local edit_text = require("view.edit_text")
local image = require("view.image")
local select_button = require("view.select_button")
--
local line_layout = require("layout.line_layout")
local gravity_layout = require("layout.gravity_layout")
local grid_layout = require("layout.grid_layout")
--
local title_menu = require("container.title_menu")
local select_menu = require("view.select_menu")
local tab_control = require("container.tab_control")
local border_container = require("container.border_container")
local fold_container = require("container.fold_container")
local slider_container = require("container.slider_container")
local window = require("container.window")
local tree_manager = require("container.tree_manager")
--ew
local scene_2D_guiEditor = require("function_widget.scene_2D_guiEditor")
local scene_2D = require("function_widget.scene_2D")

--

--
local tb = tab_control:new({ width = 400, height = 350 })


local slc = slider_container:new({ width = 400, height = 400 })
local bc = border_container:new({ width = "fill", height = "fill" })
local w1 = window:new({ x = 100, y = 100, width = 200, height = 200, title = "窗口1" })
local tm = title_menu:new({
    items = {
        {
            name = "文件",
            items = {
                {
                    name = "新建2",
                    items = {
                        { name = "新建3" },
                        { name = "另存3" },
                        { name = "退出3" },
                    }
                },
                {
                    name = "另存2",
                    items = {
                        { name = "新建3" },
                        { name = "另存3" },
                        { name = "退出3" },
                    }
                },
                { name = "退出2" },
            },

        },
        {
            name = "视图1",
            items = {
                { name = "新建2" },
                { name = "另存2" },
                { name = "退出2" },
            }
        },
        { name = "查看" },
        { name = "运行" },
        {
            name = "退出",
            on_click = function(self, gui)
                love.event.quit()
            end
        },
    },
})

local b1 = button:new()
local ed = edit_text:new()
local im = image:new()


local sb = select_button:new()
local sl = slider:new()
local sm = select_menu:new()
local tt = text:new()
--
local lin = line_layout:new({
    width = 400,
    height = 400,
    gravity = "top|left"
})
local gl = gravity_layout:new({
    width = 200,
    height = 200,
})

--

--
s2g = scene_2D_guiEditor:new({ width = "fill", height = "fill" })
s2d = scene_2D:new({ width = "fill", height = "fill" })
--

gui:add_view(lin)
--gui:add_view(s2g)
--gui:add_view(tm)
--gui:add_view(bc)
--lin:add_view(sm)
--lin:add_view(tm)
lin:add_view(bc)
--bc
bc:add_page_view("main", s2g)
--bc:add_page_view("main", lt)
--左窗口

--bc:add_page_view("left", lin_c)
bc:add_page_view("top", gui:load_layout(
    {
        type = "line_layout",
        width = "fill",

        {
            type = "fold_container",
            text = "views",
            {
                type = "list",
                items = {
                    { text = "button" },
                    { text = "edit_text" },
                    { text = "image" },
                    { text = "list" },
                    { text = "select_button" },
                    { text = "slider" },
                    { text = "select_menu" },
                    { text = "text" },
                },
                item_on_click = function(self, count, text) --元素点击事件
                    local view = require("view." .. text)
                    print(s2g.scene_gui:add_view(view:new()))
                end
            }
        },

        {
            type = "fold_container",
            text = "layout",
            {
                type = "list",
                items = {
                    { text = "line_layout" },
                    { text = "frame_layout" },
                    { text = "grid_layout" },
                    { text = "gravity_layout" },
                },
                item_on_click = function(self, count, text) --元素点击事件
                    local view = require("layout." .. text)
                    print(s2g.scene_gui:add_view(view:new()))
                end
            }
        },
        {
            type = "fold_container",
            text = "container",
            {
                type = "list",
                items = {
                    { text = "border_container" },
                    { text = "fold_container" },
                    { text = "slider_container" },
                    { text = "tab_control" },
                    { text = "title_menu" },
                    { text = "tree_manager" },
                    { text = "window" },
                },
                item_on_click = function(self, count, text) --元素点击事件
                    local view = require("container." .. text)
                    print(s2g.scene_gui:add_view(view:new()))
                end
            }
        }
    }
))
--lin:add_view(lin_c)
--gui:add_view(lin_c)
--视图添加器

--[[
function lt:item_on_click(count, text) --元素点击事件
    local view = require("view." .. text)
    print(s2g.scene_gui:add_view(view:new()))
end
]]




--print(fol:get_local_Position(0, 0))
--左窗口
--右窗口
local lin_r = line_layout:new({
    width = "fill"
})
bc:add_page_view("right", lin_r)
local fol_r1 = fold_container:new()
local text1 = text:new()

lin_r:add_view(text1)
gui:on_event("选中视图改变", function(select_view)
    --text1
    text1.text = select_view.x
end)
gui:on_event("选中视图属性更新", function(select_view)
    -- body
    text1.text = select_view.x
end)

--右窗口
