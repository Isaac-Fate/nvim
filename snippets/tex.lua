-- Some shorthands...
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

local function get_buffer_content()
  -- Get all lines in the buffer
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  -- Concatenate the lines
  local content = table.concat(lines, "\n")

  return content
end

local function new_label_factory(label_prefix)
  -- Get the content of the current buffer
  local content = get_buffer_content()

  -- Total number of the labels associated with the prefix
  local num_labels = 0

  -- Create the regex pattern for the label
  local label_pattern = "%label{" .. label_prefix .. ":%d+}"

  -- Count the number of labels
  for _ in string.gmatch(content, label_pattern) do
    num_labels = num_labels + 1
  end

  -- The number of the new label to create
  local label_num = num_labels + 1

  -- New label with number
  local label = "\\label{" .. label_prefix .. ":" .. label_num .. "}"

  return label
end

local function new_theorem_label()
  return new_label_factory("thm")
end

local function new_definition_label()
  return new_label_factory("def")
end

local function new_proposition_label()
  return new_label_factory("prop")
end

local function new_lemma_label()
  return new_label_factory("lem")
end

local function new_corollary_label()
  return new_label_factory("cor")
end

local function new_example_label()
  return new_label_factory("eg")
end

local function new_exercise_label()
  return new_label_factory("ex")
end

local function new_equation_label()
  return new_label_factory("eq")
end

local function new_figure_label()
  return new_label_factory("fig")
end

return {
  s({
    trig = "lthm",
    name = "Theorem environment",
    desc = "",
  }, f(new_theorem_label, {}, {})),

  s({
    trig = "ldef",
    name = "Definition environment",
    desc = "",
  }, f(new_definition_label, {}, {})),
}
