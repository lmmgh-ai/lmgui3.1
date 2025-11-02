--[[
Dialog/Popup 控件 for lmgui3.1
作者：你的名字
用法示例见底部
]]

local view = require("view.view")

local dialog = view:new()
dialog.__index = dialog

function dialog:new(params)
    local obj = {
        type = "dialog",
        x = params.x or 100,
        y = params.y or 100,
        width = params.width or 300,
        height = params.height or 180,
        title = params.title or "提示",
        content = params.content or "",
        buttons = params.buttons or {}, -- {{"确定", function}, {"取消", function}}
        visible = params.visible ~= false,
        modal = params.modal ~= false,  -- 是否模态遮罩
        on_close = params.on_close,
        button_objs = {},
    }
    setmetatable(obj, self)
    obj:_init()
    return obj
end

function dialog:init()
    self:init_buttons()
end

function dialog:init_buttons()
    self.button_objs = {}
    local btn_w = 80
    local btn_h = 32
    local btn_y = self.y + self.height - btn_h - 20
    local total = #self.buttons
    for i, btn in ipairs(self.buttons) do
        local btn_x = self.x + (self.width - btn_w * total) / 2 + (i - 1) * btn_w
        -- 独立按钮对象
        local b = {
            text = btn[1],
            x = btn_x,
            y = btn_y,
            width = btn_w,
            height = btn_h,
            on_click = btn[2],
            hovered = false,
            pressed = false,
        }
        table.insert(self.button_objs, b)
    end
end

function dialog:draw()
    if not self.visible then return end
    -- 绘制模态遮罩
    if self.modal then
        love.graphics.setColor(0, 0, 0, 0.4)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    end
    -- 绘制弹窗
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 12, 12)
    love.graphics.setColor(0.2, 0.5, 1, 1)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height, 12, 12)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf(self.title, self.x, self.y + 8, self.width, "center")
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf(self.content, self.x + 16, self.y + 40, self.width - 32, "left")
    -- 绘制按钮
    for _, btn in ipairs(self.button_objs) do
        self:draw_button(btn)
    end
end

function dialog:draw_button(btn)
    -- 按钮背景
    if btn.pressed then
        love.graphics.setColor(0.6, 1, 1, 1)
    elseif btn.hovered then
        love.graphics.setColor(0.8, 0.8, 1, 1)
    else
        love.graphics.setColor(0.6, 0.6, 1, 1)
    end
    love.graphics.rectangle("fill", btn.x, btn.y, btn.width, btn.height, 8, 8)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("line", btn.x, btn.y, btn.width, btn.height, 8, 8)
    -- 按钮文字
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf(btn.text, btn.x, btn.y + (btn.height - 20) / 2, btn.width, "center")
end

function dialog:update(dt)
    -- 可加入动画等
end

function dialog:mousepressed(id, x, y, dx, dy, istouch, pre)
    if not self.visible then return end
    if self.modal and button == 1 then
        if x < self.x or x > self.x + self.width or y < self.y or y > self.y + self.height then
            self:close()
            return
        end
    end
    for _, btn in ipairs(self.button_objs) do
        if self.point_in_rect(x, y, btn.x, btn.y, btn.width, btn.height) then
            btn.pressed = true
        end
    end
end

function dialog:mousereleased(id, x, y, dx, dy, istouch, pre)
    if not self.visible then return end
    for _, btn in ipairs(self.button_objs) do
        if btn.pressed and self.point_in_rect(x, y, btn.x, btn.y, btn.width, btn.height) then
            btn.pressed = false
            if btn.on_click then btn.on_click(self) end
            self:close()
        else
            btn.pressed = false
        end
    end
end



function dialog:mousemoved(id, x, y, dx, dy, istouch, pre)
    if not self.visible then return end
    for _, btn in ipairs(self.button_objs) do
        btn.hovered = self.point_in_rect(x, y, btn.x, btn.y, btn.width, btn.height)
    end
end

function dialog:close()
    self.visible = false
    if self.on_close then self.on_close(self) end
end

return dialog

-- 用法示例（放在主界面 love.load/love.draw/love.mousepressed/love.mousereleased/love.mousemoved 里）:
-- local Dialog = require("container.dialog")
-- dlg = Dialog:new{
--     title = "警告",
--     content = "确定要退出吗？",
--     buttons = {
--         {"确定", function(self) print("用户点击了确定") end},
--         {"取消", function(self) print("用户点击了取消") end}
--     }
-- }
-- 在 love.draw() 里加: dlg:draw()
-- 在 love.update(dt) 里加: dlg:update(dt)
-- 在 love.mousepressed(x, y, btn) 里加: dlg:mousepressed(x, y, btn)
-- 在 love.mousereleased(x, y, btn) 里加: dlg:mousereleased(x, y, btn)
-- 在 love.mousemoved(x, y, dx, dy) 里加: dlg:mousemoved(x, y, dx, dy)
