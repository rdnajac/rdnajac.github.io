local file = vim.fs.abspath('sections.md')
local lines = vim.fn.readfile(file)

local ret = {}
local cur = nil

local function match_header(n)
  return '^' .. string.rep('#', n) .. '%s+(.+)'
end

-- type alias for a kv table that is a map from a strong to a list of strings
---@alias h3 table<string:heading, string[]:items>

for i = 1, #lines do
  local line = vim.trim(lines[i])

  cur = line:match(match_header(2))
  if cur then
    print(cur)
    ret[#ret + 1] = { [cur] = 'h2' }
    print(vim.inspect(ret))
  else
    -- local h3 = line:match(match_header(3))
    -- if h3 and cur_h2 then
    --   cur_h3 = {}
    --   cur_h2[h3] = cur_h3
    -- else
    --   local item = line:match('^%-%s*(.+)')
    --   if item and cur_h2 then
    --     if cur_h3 then
    --       table.insert(cur_h3, item)
    --     else
    --       table.insert(cur_h2, item)
    --     end
    --   end
  end
end
