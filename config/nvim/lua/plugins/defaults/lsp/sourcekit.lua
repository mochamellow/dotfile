return {
	cmd = { vim.trim(vim.fn.system("xcrun -f sourcekit-lsp")) },
	filetypes = { "swift", "objective-c", "objective-cpp" },
	root_markers = { "Package.swift", ".git", "*.xcodeproj", "*.xcworkspace" },
}
