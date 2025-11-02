local camera                 = require("libs.love2D_libs.Camera.Camera")
---
local scene_2D               = require("function_widget.scene_2D")
local scene_2D_guiEditor     = scene_2D:new()
--
scene_2D_guiEditor.scene_gui = nil --场景gui对象
--开始重写
-------------------------------------------
function scene_2D_guiEditor:init()
    --已视图为边界初始摄像机
    --local x, y = self:get_world_Position(self.x, self.y)

    --print(123)
    self.scene_gui = require("function_widget.scene_gui") --初始场景gui管理器
    --   print(self.scene_gui.events_system, self.events_system)
    --
    local button = require("view.button")
    local line_layout = require("layout.line_layout")
    local scene_gui = self.scene_gui
    for i = 1, 10 do
        local x = love.math.random(0, 400)
        local y = love.math.random(0, 400)
        local b1 = button:new({ x = x, y = y, width = 100, height = 30 })
        scene_gui:add_view(b1)
    end

    scene_gui:add_view(scene_gui:load_layout({ type = "window" }))
end

function scene_2D:on_create()
    self.camera = camera:new(0, 0, self.width, self.height)
    --统一api设置摄像机视口
    local camera = self.camera
    local x, y = self:get_world_Position(0, 0)
    -- print(x, y)
    -- print(self)
    camera.viewport = {
        x = x,
        y = y, --self.y,
        width = self.width,
        height = self.height,
        centerX = x + self.width / 2,
        centerY = y + self.height / 2
    }
    --统一事件系统
    self.scene_gui.events_system = self.events_system
end

function scene_2D_guiEditor:update(dt)
    local camera = self.camera
    local scene_gui = self.scene_gui;
    scene_gui:update(dt);
    -- camera:update(dt)
end

function scene_2D:draw()
    if not self.visible then return end
    --
    local camera = self.camera
    -- 绘制按钮背景
    if self.isPressed then
        love.graphics.setColor(self.pressedColor)
    elseif self.hover then
        love.graphics.setColor(self.hoverColor)
    else
        love.graphics.setColor(self.backgroundColor)
    end

    --摄像机接管绘图 绘图坐标系转化为局部
    camera:attach()
    -- Draw your game here
    self:draw_grid()           --绘制网格
    self:virtual_screen_draw() --绘制虚拟屏幕
    self.scene_gui:draw()      --绘制gui
    --
    --love.graphics.rectangle("line", camera.screen_x, camera.screen_y, camera.w, camera.h, 5)
    --love.graphics.rectangle("fill", 0, 0, 50, 50)

    camera:detach()   --相机绘图结束
    --绘制相机坐标系标识
    self:coord_draw() --绘制坐标系

    --绘制相机屏幕
    -- love.graphics.rectangle("line", camera.viewport.x, camera.viewport.y, camera.viewport.w, camera.viewport.h)
end

function scene_2D_guiEditor:mousepressed(id, x, y, dx, dy, istouch, pre) --pre短时间按下次数 模拟双击
    local scene_gui = self.scene_gui
    local camera = self.camera
    local view;
    local x1, y1 = self:world_to_scene_position(x, y) --世界坐标转换场景坐标

    --print(x1, y1)
    --print(self:scene_to_world_position(x1, y1))

    --获取到场景内被点击的视图
    local input_state = scene_gui:mousepressed(id, x1, y1, dx1, dy1, istouch, pre)
    local select_view = input_state.select_view
    if select_view then
        print("点击了场景内视图", select_view.type, select_view._layer)
        self:publish_event("选中视图改变", select_view)
    end

    --print(123,scene_gui)
end

function scene_2D_guiEditor:mousereleased(id, x, y, dx, dy, istouch, pre) --pre短时间按下次数 模拟双击
    local camera = self.camera
    local scene_gui = self.scene_gui
    local x1, y1 = self:world_to_scene_position(x, y) --世界坐标转换场景坐标
    --
    scene_gui:mousereleased(id, x1, y1, dx1, dy1, istouch, pre)
end

function scene_2D_guiEditor:mousemoved(id, x, y, dx, dy, istouch, pre)
    local camera = self.camera
    local scene_gui = self.scene_gui
    local x1, y1 = self:world_to_scene_position(x, y) --世界坐标转换场景坐标
    -- local x, y = self:get_local_Position(x, y)
    -- print(x, y)
    --print(camera:toCameraCoords(0, 0))
    --print("tos" .. camera:worldToScreen(0, 0))
    --print("tow" .. camera:screenToWorld(0, 0))
    --print(camera:toWorldCoords(0, 0))
    local dx1 = dx / camera.scale
    local dy1 = dy / camera.scale --偏移量不受缩放影响
    if self.isPressed and id == 3 then
        camera:move(dx, dy)
    end
    scene_gui:mousemoved(id, x1, y1, dx1, dy1, istouch, pre)
end

function scene_2D_guiEditor:wheelmoved(id, x, y) --滚轮滑动
    local camera = self.camera
    camera:wheel_Scale(-y)
    print("scale:" .. camera.scale)
    --print(dump(camera.bounds))
end

function scene_2D_guiEditor:on_click(id, x, y, dx, dy, istouch, pre)
    -- body
    --self:destroy()
    --print("stow", self:scene_to_world_position(0, 0))
    --print("wtos", self:world_to_scene_position(0, 0))
    -- print(self:scene_world_position(0, 0))
end

function scene_2D_guiEditor:keypressed(key)
    -- body
    local camera = self.camera
    if key == "q" then
        camera:rotate_radian(-10)
    elseif key == "e" then
        camera:rotate_radian(10)
    end
    print(dump(camera.bounds))
    print(self:world_to_scene_position(0, 0))
    print(self:world_to_scene_position(0, 200))
    --[[
    --print(dump(self.scene_gui:views_out_to_layout()))
    local data = self.scene_gui:views_out_to_layout()
    local file2 = File.newFile("2.lua")
    --print(file:open("a"), file:read(), file2)
    print(file2:open("w"), file2:write("return " .. data))
    file2:close()
    ]]
end

----------------------------------------------------
--重写结束


return scene_2D_guiEditor;
