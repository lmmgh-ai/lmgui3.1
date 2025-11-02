-----------------------------
-- 转换算法：将嵌套表结构转换为顺序表 + 稀疏集父子关系
function convertToSequentialTable(nestedTable)
    local sequentialTable = {}      -- 顺序表，存储所有节点
    local parentChildRelations = {} -- 稀疏集，存储父子关系 {childIndex = parentIndex}
    local nodeCounter = 0           -- 节点计数器

    -- 递归遍历函数
    local function traverse(node, parentIndex)
        nodeCounter = nodeCounter + 1
        local currentIndex = nodeCounter

        -- 创建当前节点的副本（去除嵌套子节点）
        local nodeCopy = {}
        for k, v in pairs(node) do
            if type(v) ~= "table" or not v.type then -- 不是子节点
                nodeCopy[k] = v
            end
        end

        -- 添加到顺序表
        table.insert(sequentialTable, nodeCopy)

        -- 记录父子关系
        if parentIndex then
            parentChildRelations[currentIndex] = parentIndex
        else
            parentChildRelations[currentIndex] = 0
        end

        -- 递归处理子节点
        for k, v in pairs(node) do
            if type(v) == "table" and v.type then -- 是子节点
                traverse(v, currentIndex)
            end
        end
    end

    -- 开始遍历根节点
    traverse(nestedTable, nil)

    return sequentialTable, parentChildRelations
end

-- 获取父节点
function getParent(childIndex, relations)
    return relations[childIndex]
end

-- 获取所有子节点
function getChildren(parentIndex, relations, sequentialTable)
    local children = {}
    for childIndex, parentIdx in pairs(relations) do
        if parentIdx == parentIndex then
            table.insert(children, { index = childIndex, node = sequentialTable[childIndex] })
        end
    end
    return children
end

-- 测试代码
local lay = {
    type = "line_layout",
    x = 100,
    y = 100,
    {
        type = "button",
        {
            type = "button",
        },
        {
            type = "button",
        },
    },
    {
        type = "button",
        {
            type = "button",
        },
        {
            type = "button",
        },
    },
}

-- 执行转换
local seqTable, relations = convertToSequentialTable(lay)

-- 打印结果
print("=== 顺序表 ===")
for i, node in ipairs(seqTable) do
    print(i .. ": " .. dump(node))
end

print("\n=== 父子关系 (child -> parent) ===")
for child, parent in pairs(relations) do
    print(child .. " -> " .. parent)
end

print("\n=== 详细信息 ===")
for i, node in ipairs(seqTable) do
    local parent = getParent(i, relations)
    local children = getChildren(i, relations, seqTable)

    print("节点 " .. i .. " (" .. node.type .. ")")
    if parent then
        print("  父节点: " .. parent .. " (" .. seqTable[parent].type .. ")")
    else
        print("  父节点: 无 (根节点)")
    end

    if #children > 0 then
        print("  子节点:")
        for _, childInfo in ipairs(children) do
            print("    " .. childInfo.index .. " (" .. childInfo.node.type .. ")")
        end
    else
        print("  子节点: 无")
    end
    print()
end
