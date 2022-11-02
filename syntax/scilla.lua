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

local function region_g(name, group, r_start, r_end)
  vim.api.nvim_command(
    "syn region "
      .. name
      .. " transparent matchgroup="
      .. group
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
  "return",
  "exists",
  "delete",
  "type",
  "of",
  "try",
  "catch",
  "as",
  "throw",
  "return",
})

keyword("scillaType", {
  -- Types defined as keywords
  "Emp",
  "Map",
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
})

-- Syntax errors
match("scillaError", "\\<\\%(end\\)\\>")

region("scillaComment", "(\\*", "\\*)")

region_g("scillaTransition", "scillaFunction", "\\<transition\\>", "\\<end\\>")
region_g("scillaProcedure", "scillaFunction", "\\<procedure\\>", "\\<end\\>")

hi("scillaString", "String")
hi("scillaKeyword", "Keyword")
hi("scillaType", "Type")
hi("scillaSpecial", "Special")
hi("scillaError", "Error")
hi("scillaComment", "Comment")
hi("scillaFunction", "Function")
