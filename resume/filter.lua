function Header(el)
  if el.level == 2 then
    return pandoc.RawBlock('latex', '\\section{' .. pandoc.utils.stringify(el.content) .. '}')
  end
end

function BulletList(el)
  local out = { '\\begin{itemize}[leftmargin=*,label=--]' }
  for _, item in ipairs(el.content) do
    local text = pandoc.utils.stringify(item)
    table.insert(out, '\\item ' .. text)
  end
  table.insert(out, '\\end{itemize}')
  return pandoc.RawBlock('latex', table.concat(out, '\n'))
end
