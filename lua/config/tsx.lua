-- TS/TSX/JSX visual highlighting, unified weight (no bold/italic)

local fn, api = vim.fn, vim.api

local function hlexists(name)
  return fn.hlexists(name) == 1
end

local function sethl(group, opts)
  -- Ensure no bold/italic for uniform weight
  opts.bold = false
  opts.italic = false
  api.nvim_set_hl(0, group, opts)
end

local function TsxPopColors()
  -- Keywords / types
  sethl('typescriptReserved',    { fg = '#c678dd' })
  sethl('typescriptFuncKeyword', { fg = '#c678dd' })
  sethl('typescriptType',        { fg = '#56b6c2' })

  -- Operators / punctuation
  sethl('typescriptOperator', { fg = '#61afef' })
  sethl('typescriptBraces',   { fg = '#61afef' })
  sethl('typescriptParens',   { fg = '#61afef' })

  -- Identifiers / literals
  sethl('typescriptIdentifier', { fg = '#98c379' })
  sethl('typescriptString',     { fg = '#e5c07b' })
  sethl('typescriptNumber',     { fg = '#d19a66' })
  sethl('typescriptBoolean',    { fg = '#d19a66' })

  -- TSX groups (if they exist)
  if hlexists('tsxTagName')  then sethl('tsxTagName',  { fg = '#61afef' }) end
  if hlexists('tsxAttrib')   then sethl('tsxAttrib',   { fg = '#c678dd' }) end
  if hlexists('tsxTag')      then sethl('tsxTag',      { fg = '#61afef' }) end
  if hlexists('tsxCloseTag') then sethl('tsxCloseTag', { fg = '#61afef' }) end

  -- JSX groups (vim-jsx-pretty)
  if hlexists('jsxTagName')   then sethl('jsxTagName',   { fg = '#61afef' }) end
  if hlexists('jsxAttrib')    then sethl('jsxAttrib',    { fg = '#c678dd' }) end
  if hlexists('jsxCloseTag')  then sethl('jsxCloseTag',  { fg = '#61afef' }) end
  if hlexists('jsxOpenPunct') then sethl('jsxOpenPunct', { fg = '#61afef' }) end
  if hlexists('jsxClosePunct') then sethl('jsxClosePunct', { fg = '#61afef' }) end
  if hlexists('jsxBrace')     then sethl('jsxBrace',     { fg = '#56b6c2' }) end
end

local function TsxRegexColors()
  -- If proper TSX/JSX highlighter exists, do nothing
  if hlexists('tsxTagName') or hlexists('jsxTagName') then return end

  -- Define custom groups with uniform weight
  sethl('TSXTagNameHot', { fg = '#61afef' })
  sethl('TSXAttrHot',    { fg = '#c678dd' })
  sethl('TSXHandlerHot', { fg = '#c678dd' })
  sethl('TSXStringHot',  { fg = '#e5c07b' })
  sethl('TSXBraceHot',   { fg = '#56b6c2' })
  sethl('TSXPropHot',    { fg = '#98c379' })

  -- Clear previous matches in this buffer
  if vim.b.tsx_match_ids then
    for _, id in ipairs(vim.b.tsx_match_ids) do
      pcall(fn.matchdelete, id)
    end
  end
  vim.b.tsx_match_ids = {}

  local function add(re, group)
    local id = fn.matchadd(group, re)
    table.insert(vim.b.tsx_match_ids, id)
  end

  -- TagName inside <TagName ...> or <div ...>
  add([[\v<\zs[A-Z][A-Za-z0-9_]*\ze(\s|/?>)]], 'TSXTagNameHot')
  add([[\v<\zs[a-z][A-Za-z0-9_]*\ze(\s|/?>)]], 'TSXTagNameHot')

  -- attribute names: value= placeholder= className= data-xx=
  add([[\v<\zs[a-zA-Z_:][a-zA-Z0-9_:\-]*\ze=]], 'TSXAttrHot')

  -- handler props: onChange= onClick= ...
  add([[\v<\zson[A-Z][A-Za-z0-9_]*\ze=]], 'TSXHandlerHot')

  -- braces { } (use alt long string to avoid ]] close)
  add([=[\v[\{\}]]=], 'TSXBraceHot')

  -- dot-props: .target .value .trim etc
  add([[\v\.\zs[a-zA-Z_][a-zA-Z0-9_]*]], 'TSXPropHot')

  -- strings
  add([[\v"[^"]*"]], 'TSXStringHot')
  add([[\v'[^']*']], 'TSXStringHot')
end

-- Apply on colorscheme load and TS/TSX buffers
vim.api.nvim_create_augroup('TsxVisual', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'TsxVisual',
  callback = TsxPopColors,
})
vim.api.nvim_create_autocmd('FileType', {
  group = 'TsxVisual',
  pattern = { 'typescript', 'typescriptreact' },
  callback = function()
    TsxPopColors()
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  group = 'TsxVisual',
  pattern = { 'typescriptreact' },
  callback = function()
    TsxRegexColors()
  end,
})

-- Initial apply (after startup)
pcall(TsxPopColors)
