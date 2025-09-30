local file = vim.fs.abspath('sections.md')
local lines = vim.fn.readfile(file)

local ret = {}
local order = {} -- keep H2 order
local cur_h2 = nil
local cur_h3 = nil

local function match_header(n)
  return '^' .. string.rep('#', n) .. '%s+(.+)'
end

for i = 1, #lines do
  local line = vim.trim(lines[i])

  local h2 = line:match(match_header(2))
  if h2 then
    cur_h2 = {}
    ret[h2] = cur_h2
    table.insert(order, h2) -- store order
    cur_h3 = nil
  else
    local h3 = line:match(match_header(3))
    if h3 and cur_h2 then
      cur_h3 = {}
      cur_h2[h3] = cur_h3
    else
      local item = line:match('^%-%s*(.+)')
      if item and cur_h2 then
        if cur_h3 then
          table.insert(cur_h3, item)
        else
          table.insert(cur_h2, item)
        end
      end
    end
  end
end

-- print in order
for _, key in ipairs(order) do
  print(key, vim.inspect(ret[key]))
end

--- convert a lua list of strings into a latex itemize block
---@param items string[]
---@return string latex itemize block
local function itemize(items)
  local out = { '\\begin{itemize}' }
  for _, item in ipairs(items) do
    table.insert(out, string.format('  \\item %s', item))
  end
  table.insert(out, '\\end{itemize}\n')
  return table.concat(out, '\n')
end

--- convert parsed markdown table to LaTeX preserving order
---@param data table parsed markdown table
---@param order string[] H2 keys in original order
---@return string LaTeX string
local function to_latex_ordered(data, order)
  local out = {}

  for _, h2 in ipairs(order) do
    local content = data[h2]
    table.insert(out, string.format('\\section*{%s}', h2))

    -- separate H3 keys from numeric list items
    local subheaders = {}
    local flat_items = {}

    for k, v in pairs(content) do
      if type(k) == 'string' then
        table.insert(subheaders, k)
      else
        table.insert(flat_items, v)
      end
    end

    -- first, print flat items if any
    if #flat_items > 0 then
      table.insert(out, itemize(flat_items))
    end

    -- then H3 subheaders in order they were inserted
    for _, h3 in ipairs(subheaders) do
      local items = content[h3]
      table.insert(out, string.format('\\textbf{%s:}', h3))
      table.insert(out, itemize(items))
    end
  end

  return table.concat(out, '\n')
end

-- usage:
local latex = to_latex_ordered(ret, order)
print(latex)
