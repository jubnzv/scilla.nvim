-- Scilla v0.13 syntax file.
--
-- See: https://github.com/Zilliqa/scilla/blob/master/src/base/ScillaLexer.mll
--
if vim.b.current_syntax ~= nil then
  vim.b.current_syntax = nil
end

local function keyword(name, keywords)
  keywords_str = table.concat(keywords, " ")
  vim.api.nvim_command("syn keyword " .. name .. " " .. keywords_str)
end

local function match(name, pattern)
  vim.api.nvim_command("syn match " .. name .. ' "' .. pattern .. '"')
end

local function hi(group, link)
  vim.api.nvim_command("hi def link " .. group .. " " .. link)
end

local function region(name, r_start, r_end)
  vim.api.nvim_command(
    "syn region " .. name .. ' start="' .. r_start .. '" end="' .. r_end .. '"'
  )
end

local function region_g(name, matchgroup, opts, r_start, r_end)
  vim.api.nvim_command(
    "syn region "
      .. name
      .. table.concat(opts, " ")
      .. " matchgroup="
      .. matchgroup
      .. ' start="'
      .. r_start
      .. '" end="'
      .. r_end
      .. '"'
  )
end

-- String literals
vim.api.nvim_command(
  'syn region scillaString start=+"+  skip=+\\\\|\\$"+  end=+"+"'
)

keyword("scillaKeyword", {
  "forall",
  "builtin",
  "library",
  "import",
  "let",
  "in",
  "match",
  "with",
  "end",
  "fun",
  "tfun",
  "contract",
  "send",
  "event",
  "field",
  "accept",
  "exists",
  "delete",
  "type",
  "of",
  "try",
  "catch",
  "as",
  "throw",
})

keyword("scillaType", {
  -- Types defined as keywords
  "Emp",
  "Map",
  -- Names of built-in ADTs (`src/base/Datatypes.ml`)
  "Bool",
  "Option",
  "List",
  "Pair",
  -- Primitive types defined in `src/base/Type.ml`
  "Int32",
  "Int64",
  "Int128",
  "Int256",
  "Uint32",
  "Uint64",
  "Uint128",
  "Uint256",
  "String",
  "BNum",
  "Message",
  "Event",
  "Exception",
  "ReplicateContr",
  "ByStr",
  -- TODO: "ByStrX"
})

keyword("scillaSpecial", {
  "scilla_version",
  -- Special identifiers starting with `_`
  "_return",
  -- Blockchain query operations
  "BLOCKNUMBER",
  "CHAINID",
  "TIMESTAMP",
  "REPLICATE_CONTRACT",
})

-- Syntax errors
match("scillaError", "\\<\\%(end\\)\\>")

region("scillaComment", "(\\*", "\\*)")

-- Functions and procedures
local function hi_fun(name, kwd)
  -- syn region luaFunctionBlock transparent matchgroup=luaFunction start="\<function\>" end="\<end\>" contains=ALLBUT,luaTodo,luaSpecial,luaElseifThen,luaElse,luaThenEnd,luaIn
  region_g(
    name,
    "scillaFunction",
    { "transparent", "contains=ALLBUT,scillaWithEnd" },
    "\\<" .. kwd .. "\\>",
    "\\<end\\>"
  )
end
hi_fun("scillaTransition", "transition")
hi_fun("scillaProcedure", "procedure")

-- match ... end
-- syn region luaIfThen transparent matchgroup=luaCond start="\<if\>" end="\<then\>"me=e-4           contains=ALLBUT,luaTodo,luaSpecial,luaElseifThen,luaElse,luaIn nextgroup=luaThenEnd skipwhite skipempty
region_g("scillaMatchWith", "scillaCond", {
  "contained",
  "transparent",
  "contains=ALLBUT,scillaFunction",
  "nextgroup=scillaWithEnd",
  "skipwhite",
  "skipempty",
}, "\\<match\\>", "\\<with\\>")
-- syn region luaThenEnd contained transparent matchgroup=luaCond start="\<then\>" end="\<end\>" contains=ALLBUT,luaTodo,luaSpecial,luaThenEnd,luaIn
region_g(
  "scillaWithEnd",
  "scillaCond",
  { "contained", "transparent", "contains=ALLBUT,scillaWithEnd" },
  "\\<with>\\>",
  "\\<end>\\>"
)

hi("scillaString", "String")
hi("scillaKeyword", "Keyword")
hi("scillaType", "Type")
hi("scillaSpecial", "Special")
hi("scillaCond", "Special")
hi("scillaError", "Error")
hi("scillaComment", "Comment")
hi("scillaFunction", "Function")
