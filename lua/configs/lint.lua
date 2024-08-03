local lint = require("lint")

lint.linters_by_ft = {
    lua = { "luacheck" },
    go = { "golangci-lint" },
}

lint.linters.luacheck.args = {
    "--globals",
    "love",
    "vim",
    "--formatter",
    "plain",
    "--codes",
    "--ranges",
    "-",
}

-- modify as you see fit for golangci_lint arguments if needed
-- lint.linters.golangci_lint.args = {...}
-- Define golangci-lint configuration
lint.linters.golangci_lint = {
    cmd = "golangci-lint",
    args = { "run", "--out-format", "line-number" },
    stdin = false,
    stream = "stdout",
    ignore_exitcode = true,
}

-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
--     callback = function()
--         lint.try_lint()
--     end,
-- }

-- Debug print
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = "*.go",
    callback = function()
        print("Linting Go file...")
        local result = vim.fn.system("golangci-lint run --out-format line-number " .. vim.fn.expand("%"))
        print("golangci-lint output:", result)
    end,
})
