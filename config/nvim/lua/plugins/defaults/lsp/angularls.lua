return {
  cmd = function()
    local root_dir = vim.fs.root(0, { "angular.json", "project.json" })
    if not root_dir then
      return nil
    end
    return {
      "ngserver",
      "--stdio",
      "--tsProbeLocations",
      root_dir .. "/node_modules",
      "--ngProbeLocations",
      root_dir .. "/node_modules/@angular/language-service",
    }
  end,
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
  root_markers = { "angular.json", "project.json" },
}
