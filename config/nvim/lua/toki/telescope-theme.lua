local M = {}

function M.apply()
  local hl = vim.api.nvim_set_hl

  -- Define link targets as locals for easy modification
  local border = "Special"
  local float = "black"
  local title = "Special"
  local prefix_icon = "Special"
  local selection = "CmpSel"
  local selection_caret = "Visual"
  local matching = "CmpItemAbbrMatch"

  -- Borders
  hl(0, "TelescopeBorder", { link = border })
  hl(0, "TelescopePromptBorder", { link = border })
  hl(0, "TelescopeResultsBorder", { link = border })
  hl(0, "TelescopePreviewBorder", { link = border })

  -- Normal text
  hl(0, "TelescopeNormal", { link = float })
  hl(0, "TelescopePromptNormal", { link = float })
  hl(0, "TelescopeResultsNormal", { link = float })
  hl(0, "TelescopePreviewNormal", { link = float })

  -- Titles
  hl(0, "TelescopeTitle", { link = title, bold = true })
  hl(0, "TelescopePromptTitle", { link = title })
  hl(0, "TelescopeResultsTitle", { link = title })
  hl(0, "TelescopePreviewTitle", { link = title })

  -- Search items
  hl(0, "TelescopePromptPrefix", { link = prefix_icon })
  hl(0, "TelescopePromptCounter", { link = prefix_icon })

  -- Selection and matching
  hl(0, "TelescopeSelection", { link = selection })
  hl(0, "TelescopeSelectionCaret", { link = selection_caret })
  hl(0, "TelescopeMatching", { link = matching })
end

return M
