````markdown name=README.md
# lmgui3.1

lmgui3.1 是一个基于 [Love2D](https://love2d.org/) 的 Lua GUI 库，旨在为 Love2D 游戏和应用程序提供易于使用、灵活的界面组件。

## 特性

- 轻量级、易于集成
- 支持多种常用控件（按钮、文本框、滑块、复选框、列表等）
- 可自定义主题与样式
- 响应式布局
- 事件驱动机制
- 高度可扩展

## 安装与使用

1. **下载或克隆** 本仓库，将 `lmgui` 文件夹放入你的 Love2D 项目目录。
2. 在你的主脚本中引入 lmgui：

```lua
local lmgui = require("lmgui.init")
```

3. 在 Love2D 的回调函数中集成 lmgui：

```lua
function love.load()
    lmgui:init()
end

function love.update(dt)
    lmgui:update(dt)
end

function love.draw()
    lmgui:draw()
end

function love.mousepressed(x, y, button)
    lmgui:mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
    lmgui:mousereleased(x, y, button)
end

function love.textinput(text)
    lmgui:textinput(text)
end

function love.keypressed(key)
    lmgui:keypressed(key)
end

function love.keyreleased(key)
    lmgui:keyreleased(key)
end
```

---

## API 参考

### 初始化

```lua
lmgui:init()
```
初始化 GUI 系统，通常在 `love.load` 中调用。

---

### 控件创建

#### Button（按钮）

```lua
local btn = lmgui:Button(x, y, width, height, "文本", callback)
```
- `x, y`：按钮左上角坐标
- `width, height`：宽高
- `文本`：按钮显示文字
- `callback`：点击回调函数

#### Label（标签）

```lua
local label = lmgui:Label(x, y, "文本")
```
- `x, y`：左上角坐标
- `文本`：标签内容

#### TextBox（文本框）

```lua
local tb = lmgui:TextBox(x, y, width, height, defaultText, callback)
```
- `defaultText`：默认文本
- `callback`：文本变化回调

#### CheckBox（复选框）

```lua
local cb = lmgui:CheckBox(x, y, "描述", checked, callback)
```
- `checked`：初始状态
- `callback`：选中状态变化回调

#### Slider（滑块）

```lua
local slider = lmgui:Slider(x, y, width, min, max, value, callback)
```
- `min, max`：最小/最大值
- `value`：初始值
- `callback`：值变化回调

#### ListBox（列表框）

```lua
local list = lmgui:ListBox(x, y, width, height, items, selectCallback)
```
- `items`：字符串数组
- `selectCallback`：选中项变化回调

---

### 控件属性与方法

每个控件实例都支持以下通用方法：

```lua
-- 设置控件位置
ctrl:setPosition(x, y)

-- 设置控件尺寸
ctrl:setSize(width, height)

-- 设置可见性
ctrl:setVisible(visible)

-- 获取/设置控件值
ctrl:getValue()
ctrl:setValue(val)

-- 获取控件类型
ctrl:getType()
```

---

### 布局相关

支持容器控件，可用于自动布局：

#### Panel（面板/容器）

```lua
local panel = lmgui:Panel(x, y, width, height)
panel:addChild(ctrl)
panel:removeChild(ctrl)
```

---

### 事件系统

你可以通过回调函数或手动监听控件事件：

```lua
btn:on("click", function() ... end)
tb:on("textchange", function(newText) ... end)
slider:on("change", function(val) ... end)
```

---

### 主题与样式

可自定义全局或局部样式：

```lua
lmgui:setTheme({
    button = {bgColor = {0.2, 0.6, 1.0}, textColor = {1,1,1}}
})
btn:setStyle({bgColor = {1,0,0}})
```

---

## 示例

```lua
function love.load()
    lmgui:init()
    btn = lmgui:Button(100, 100, 120, 40, "点击我", function()
        print("按钮被点击！")
    end)
    tb = lmgui:TextBox(100, 150, 200, 30, "输入内容", function(text)
        print("文本变化：", text)
    end)
end

function love.draw()
    lmgui:draw()
end

function love.update(dt)
    lmgui:update(dt)
end

function love.mousepressed(x, y, button)
    lmgui:mousepressed(x, y, button)
end

function love.textinput(text)
    lmgui:textinput(text)
end
```

---

## 许可证

MIT

---

## 贡献

欢迎提交 issue 或 PR 改进本库。
````
