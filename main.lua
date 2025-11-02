require "fun"
File = require("nativefs")
gui1 = require "gui"
gui = gui1:new()
local test = require "test"
--
--加载字体
--local path = "YeZiGongChangTangYingHei-2.ttf"
--local font = love.graphics.newFont(path)
--love.graphics.setFont(font)
gui:set_font("YeZiGongChangTangYingHei-2.ttf")
--
local debugGraph = require "debugGraph"
CustomPrint = require "print"
CustomPrint:init()


--加载测试文件
---------------------------------
--require("test.main")
--require("test.main2")
--require("test.widget_test")
--require("test.main_editor")
require('test.outTable_test')
---------------------------------
function 输出()
    local out = {}
    local no_value = {
        "_layer",
        "_draw_order",
        "gui",
        "parent",
        "children",
        "name",
        "hover",
        "isPressed",
        "isDragging",
        "font",
    } --不复制的属性 函数默认不复制
    function scan(value)
        for i, str in pairs(no_value) do
            if str == value then
                return false
            end
        end
        return true
    end

    --扫描图层1全部视图
    for i, view in pairs(gui.tree_views[1]) do
        local loc = {}
        --扫描所有的属性复制到新表
        for i, value in pairs(view) do
            if scan(i) then --确认属性可复制
                loc[i] = value
            end
        end
        table.insert(out, loc)
    end
    --print(dump2(out))
    --[[
    local file = File.newFile("out.lua")
    local file2 = love.filesystem.newFile("out.lua")
    --print(file:open("a"), file:read(), file2)
    print(file:open("w"), file:write("return " .. dump2(out)))
    file:close()
    ]]
end

function 输入()
    local file  = naio.newFile("out.lua")
    local input = require("out")
    print(input)
end

--输出()
--输入()
function love.load(...)
    debugGraph:load(...)
end

function love.update(dt)
    gui:update(dt)
    debugGraph:update(dt)
    CustomPrint:update(dt)
end

function love.draw()
    love.graphics.clear(1, 1, 1) -- 白色背景
    gui:draw()
    --[[
    love.graphics.setColor({ 0, 0, 0 })
    love.graphics.setScissor(0, 0, 100, 100)
    love.graphics.setColor({ 1, 0, 0 })
    love.graphics.rectangle("fill", 0, 0, 100, 100)
    --
    love.graphics.setScissor(0, 0, 50, 25)
    love.graphics.setColor({ 0, 1, 0 })
    love.graphics.rectangle("fill", 0, 0, 100, 100)
    --
    love.graphics.setScissor(0, 0, 25, 50)
    love.graphics.setColor({ 0, 0, 1 })
    love.graphics.rectangle("fill", 0, 0, 100, 100)
    --
    love.graphics.intersectScissor(0, 0, 50, 50)
    love.graphics.setColor({ 1, 1, 1 })
    love.graphics.rectangle("fill", 0, 0, 100, 100)
    love.graphics.setScissor()
    ]]
    debugGraph:draw()
    CustomPrint:draw()
end

function love.keypressed(key)
    gui:keypressed(key)
end

function love.textinput(text)
    gui:textinput(text)
end

if love.system.getOS() == "Android" then
    function love.touchpressed(id, x, y, dx, dy, pressure) --触摸按下
        --  print((tostring(id)=="userdata: NULL"))
        --print((tostring(id)=="userdata: 0x00000001"))
        -- print(love.getVersion())
        gui:touchpressed(id, x, y, dx, dy, true, pressure)
    end

    function love.touchmoved(id, x, y, dx, dy, pressure) --触摸滑动
        gui:touchmoved(id, x, y, dx, dy, true, pressure)
    end

    function love.touchreleased(id, x, y, dx, dy, pressure) --触摸抬起
        gui:touchreleased(id, x, y, dx, dy, true, pressure)
    end
elseif love.system.getOS() == "Windows" then
    function love.mousemoved(x, y, dx, dy, istouch) --鼠标滑动
        gui:mousemoved(nil, x, y, dx, dy, istouch, nil)
    end

    function love.mousepressed(x, y, id, istouch, pressure) --pre短时间按下次数 模拟双击
        gui:mousepressed(id, x, y, nil, nil, istouch, pressure)
    end

    function love.mousereleased(x, y, id, istouch, pressure) --pre短时间按下次数 模拟双击
        gui:mousereleased(id, x, y, nil, nil, istouch, pressure)
    end

    function love.wheelmoved(x, y)
        gui:wheelmoved(nil, x, y)
    end
end


--退出程序 exit
function love.quit()
    gui:quit()
end

--拖入文件目录到窗口
function love.directorydropped(path)
    gui:directorydropped(path)
end

--拖入文件到窗口
function love.filedropped(file)
    gui:filedropped(file)
end

--窗口显示状态 (判断屏幕方向)
function love.visible(v)
    gui:visible(v)
    --  print(v)
    --print(v and "Window is visible!" or "Window is not visible!");
end

--窗口大小变化
function love.resize(width, height)
    gui:resize(width, height)
end

--用户最小化窗口/取消最小化窗口回调
function love.visible(is_small)
    gui:visible(is_small)
    -- body
end
