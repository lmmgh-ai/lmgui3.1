local view = require("view.view")
local button = require("view.button")
local switch_button = require("view.switch_button")
local slider = require("view.slider")
local list = require("view.list")
--local list_free = require "list_free"
local text = require("view.text")
local edit_text = require("view.edit_text")
local image = require("view.image")
local select_button = require("view.select_button")
local select_menu = require("view.select_menu")
--
local line_layout = require("layout.line_layout")
local gravity_layout = require("layout.gravity_layout")
local grid_layout = require("layout.grid_layout")
local frame_layout = require("layout.frame_layout")
--
local title_menu = require("container.title_menu")
local tab_control = require("container.tab_control")
local border_container = require("container.border_container")
local fold_container = require("container.fold_container")
local slider_container = require("container.slider_container")
local window = require("container.window")
local tree_manager = require("container.tree_manager")
--ew
local scene_2D_guiEditor = require("function_widget.scene_2D_guiEditor")
local scene_2D = require("function_widget.scene_2D")
local sandbox = require("function_widget.sandbox")
--
local api = {
    view = view,
    button = button,
    switch_button = switch_button,
    text = text,
    edit_text = edit_text,
    select_button = select_button,
    select_menu = select_menu,
    list = list,
    slider = slider,
    image = image,
    --list_free = list_free
    --
    line_layout = line_layout,
    gravity_layout = gravity_layout,
    grid_layout = grid_layout,
    frame_layout = frame_layout,
    --
    border_container = border_container,
    tab_control = tab_control,
    window = window,
    title_menu = title_menu,
    fold_container = fold_container,
    slider_container = slider_container,
    tree_manager = tree_manager,
    --
    scene_2D = scene_2D,
    scene_2D_guiEditor = scene_2D_guiEditor,
    sandbox = sandbox,
}

return api;
