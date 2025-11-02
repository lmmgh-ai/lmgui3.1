--require('2')

local data = require("2")
gui:add_view(gui:load_layout(data))
--print(gui)
function love.draw()
    --love.graphics.rectangle("fill", 0, 0, 20, 20, 5)
    gui:draw()
end

function love.update(dt)
    gui:update(dt)
end

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

--print(321)
