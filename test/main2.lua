local button = require("view.button")
local slider = require("view.slider")
local list = require("view.list")
local list_free = require "list_free"
local text = require("view.text")
local edit_text = require("view.edit_text")
local image = require("view.image")
local select_button = require("view.select_button")
local select_menu = require("view.select_menu")
--
local title_menu = require("container.title_menu")

local tab_control = require("container.tab_control")
local border_container = require("container.border_container")
local line_layout = require("layout.line_layout")
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
local fol = fold_container:new()
local fol2 = fold_container:new()
local fol3 = fold_container:new()
local slc = slider_container:new({ width = 400, height = 400 })
local bc = border_container:new({ width = "fill", height = 350 })
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
local lt = list:new({
    -- y = 100,
    height = 100,
    items = {
        { text = "button" },
        { text = "edit_text" },
        { text = "image" },
        { text = "list" },
        { text = "select_button" },
        { text = "slider" },
        { text = "select_menu" },
        { text = "text" },
    }
})
function lt:item_on_click(count, text) --元素点击事件

end

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
--
--
s2g = scene_2D_guiEditor:new({ width = 400, height = 350 })
s2d = scene_2D:new({ width = 400, height = 350 })
--------------------------

lin3 = line_layout:new({
    -- x = 100,
    -- y = 100,
    width = "50%ww",
    height = 400,
    --orientation = " horizontal",
    gravity = "center"
})
gui:add_view(lin3)
--slc:add_view(lin3)
--
data = {
    gravity          = "center",
    type             = "view", --类型
    x                = 0,
    y                = 0,
    width            = 0,
    height           = 0,
    visible          = true,                 --是否可见
    hover            = false,                --是否获取焦点(鼠标悬浮在控件上 强制获取焦点)
    isPressed        = false,                --是否点击
    isDragging       = false,                --是否拖动(点击后的滑动)
    --颜色
    hoverColor       = { 0.8, 0.8, 1, 1 },   --获取焦点颜色
    pressedColor     = { 0.6, 0.6, 1, 0.8 }, --点击时颜色
    backgroundColor  = { 0.6, 0.6, 1, 1 },   --背景颜色
    borderColor      = { 0, 0, 0, 1 },       --边框颜色
    --必须重写部分
    font             = nil,                  --字体
    parent           = nil,                  --父视图
    name             = "",                   --以自己内存地址作为唯一标识
    id               = "",                   --自定义索引
    children         = {},                   -- 子视图列表
    _layer           = 1,                    --图层
    _draw_order      = 1,                    --父视图图层索引
    gui              = nil,                  --管理器索引
    events_system    = nil,                  --事件系统索引
    ---交互扩展
    --扩展虚拟宽高
    is_extension     = false, --是否扩展状态 点击视图判断使用扩展宽高判断
    extension        = {},    --扩展点击区域 可以是表 是对象
    extension_x      = 0,     --扩展的坐标
    extension_y      = 0,
    extension_width  = 0,
    extension_height = 0,
}



gui:on_event("data", function(data, key, value)
    -- print(key, value)
    local key = key.text
    data[key] = value
    print(dump(data))
end)

--位置
--
local sm_views = select_menu:new({
    text = "view",
    width = "fill",
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
})
--lin3:add_view(sm_views)
--位置组件
local fol_voc = fold_container:new({
    text = "位置控件",
    width = "fill",
})
lin3:add_view(fol_voc)
local lin_voc = line_layout:new({
    width = 200,
    height = 100,
    -- orientation = "horizontal",
    gravity = "center"
})
fol_voc:add_view(lin_voc)
--基本属性
local fol_de = fold_container:new({
    text = "基本属性",
    width = "fill",
})
--线性布局属性
local fol_lin = fold_container:new({
    text = "线性布局属性",
    width = "fill",
})
local sm_lin1 = select_menu:new({
    text = "view",
    width = 100,
    items = {
        { text = "center" },
        { text = "top" },
        { text = "bottom" },
        { text = "right" },
        { text = "left" },

    },
})
local sm_lin2 = select_menu:new({
    text = "view",
    width = 100,
    items = {
        { text = "center" },
        { text = "top" },
        { text = "bottom" },
        { text = "right" },
        { text = "left" },

    },
})
--gravity         = "top|left", --子视图重力
--lin3:add_view(fol_de)
for i, c in pairs(data) do
    --位置组件
    if i == "x" or i == "y" or i == "width" or i == "height" then
        local tx = text:new({
            text = i,
            id = i
        })
        local etx = edit_text:new({
            text = tostring(c),
            height = 20,
            layout_margin_left = 20,
        })
        local lin2 = line_layout:new({
            width = "fill",
            height = 30,
            orientation = "horizontal",
            gravity = "center"
        })

        lin_voc:add_view(lin2)
        lin2:add_view(tx)
        lin2:add_view(etx)
        -- print(c.type)
        function etx:on_change_text(text)
            self:publish_event("data", data, tx, text)
        end
    elseif i == "visible" then
    elseif i == "gravity" then
        lin3:add_view(fol_lin)
        local lin2 = line_layout:new({
            width = "fill",
            height = 30,
            orientation = "horizontal",
            gravity = "center"
        })
        fol_lin:add_view(lin2)
        lin2:add_view(sm_lin1)
        lin2:add_view(sm_lin2)
    end
end

--self:publish_event("data", data, "y", love.mouse.getX())
