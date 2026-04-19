local file = vim.fs.abspath("sections.md")
local lines = vim.fn.readfile(file)

local lines_ordered = {}
local types_ordered = {}
local parents = {} -- keep track of current h2/h3

local function match_header(n)
    return "^" .. string.rep("#", n) .. "%s+(.+)"
end

for i = 1, #lines do
    local line = vim.trim(lines[i])

    local h2 = line:match(match_header(2))
    if h2 then
        table.insert(lines_ordered, h2)
        table.insert(types_ordered, "h2")
        parents.h2 = h2
        parents.h3 = nil
    else
        local h3 = line:match(match_header(3))
        if h3 then
            table.insert(lines_ordered, h3)
            table.insert(types_ordered, "h3")
            parents.h3 = h3
        else
            local item = line:match("^%-%s*(.+)")
            if item then
                table.insert(lines_ordered, item)
                table.insert(types_ordered, "item")
            end
        end
    end
end

-- Example LaTeX generator using this parallel structure
local function to_latex_ordered(lines_ordered, types_ordered)
    local out = {}
    local cur_h2, cur_h3 = nil, nil
    local cur_items = {}

    for i, line in ipairs(lines_ordered) do
        local typ = types_ordered[i]
        if typ == "h2" then
            if cur_h3 then
                table.insert(out, itemize(cur_items))
                cur_h3, cur_items = nil, {}
            elseif #cur_items > 0 then
                table.insert(out, itemize(cur_items))
                cur_items = {}
            end
            cur_h2 = line
            table.insert(out, string.format("\\section*{%s}", line))
        elseif typ == "h3" then
            if cur_h3 then
                table.insert(out, itemize(cur_items))
                cur_items = {}
            end
            cur_h3 = line
            table.insert(out, string.format("\\textbf{%s:}", line))
        elseif typ == "item" then
            table.insert(cur_items, line)
        end
    end

    if #cur_items > 0 then
        table.insert(out, itemize(cur_items))
    end

    return table.concat(out, "\n")
end

local latex = to_latex_ordered(lines_ordered, types_ordered)
print(latex)
