-- Execute the binary with the same name as the current file
vim.api.nvim_create_autocmd("FileType", {
	pattern = "asm,c,cpp",
	command = [[
    nnoremap <leader><F5> :TermExec cmd='./%:r'<CR> <C-w>ji
  ]],
})

-- Set makeprg for asm files to compile with as and ld
vim.api.nvim_create_autocmd("FileType", {
	pattern = "asm",
	command = [[setlocal makeprg=as\ --32\ -gstabs\ -o\ %:p:r.o\ %:p\ &&\ ld\ -m\ elf_i386\ -o\ %:p:r\ %:p:r.o]],
})

-- Set makeprg for c files to compile with gcc
vim.api.nvim_create_autocmd("FileType", {
	pattern = "c",
	command = [[setlocal makeprg=gcc\ -o\ %:p:r\ %:p\ -g\ -std=c99\ -W\ -Wall\ -lm]],
})

-- Set makeprg for c++ files to compile with g++
vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	command = [[setlocal makeprg=g++\ -o\ %:p:r\ %:p\ -g\ -W\ -Wall\ -lm]],
})

-- Set makeprg for java files to compile with javac
vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	command = [[setlocal makeprg=javac\ %:p\ ]],
})

-- Set colorcolumn for different filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rmd",
	command = [[ setlocal colorcolumn=73 ]],
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "r",
	command = [[ setlocal colorcolumn=73 ]],
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "tex",
	command = [[ setlocal colorcolumn=88 ]],
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	command = [[ setlocal colorcolumn=88 ]],
})

-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	pattern = "*",
	desc = "highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 200, visual = true })
	end,
})

-- Auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})

-- IDE like highlight when stopping cursor
vim.api.nvim_set_hl(0, "CustomHighlight", { bg = "", underline = true })

local cursor_hold_timer = nil
local ns_id = vim.api.nvim_create_namespace("CustomLspReferenceHighlight")

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "ModeChanged" }, {
	group = vim.api.nvim_create_augroup("LspReferenceHighlight", { clear = true }),
	desc = "Highlight references under cursor after stopping if necessary",
	callback = function()
		-- Stop and close any existing timer on movement/mode change
		if cursor_hold_timer then
			cursor_hold_timer:stop()
			cursor_hold_timer:close()
			cursor_hold_timer = nil
		end

		-- Clear current highlights immediately when moving
		vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)

		-- Do not trigger if in insert mode
		if vim.fn.mode() == "i" then
			return
		end

		local clients = vim.lsp.get_clients({ bufnr = 0 })
		local active_client = nil
		for _, client in ipairs(clients) do
			if client.server_capabilities.documentHighlightProvider then
				active_client = client
				break
			end
		end

		if not active_client then
			return
		end

		-- Start a 1-second (1000ms) timer
		cursor_hold_timer = vim.uv.new_timer()
		cursor_hold_timer:start(
			1000,
			0,
			vim.schedule_wrap(function()
				-- Verify buffer and window are still valid and we aren't in insert mode
				if vim.api.nvim_buf_is_valid(0) and vim.fn.mode() ~= "i" then
					local offset_encoding = active_client.offset_encoding or "utf-16"
					local params = vim.lsp.util.make_position_params(0, offset_encoding)

					vim.lsp.buf_request(0, "textDocument/documentHighlight", params, function(err, result)
						if err or not result or type(result) ~= "table" then
							return
						end

						-- Do not highlight if there is 1 or fewer occurrences
						if #result <= 1 then
							return
						end

						-- Re-verify buffer validity inside the async callback before painting
						if not vim.api.nvim_buf_is_valid(0) then
							return
						end

						-- Clear again just in case, then apply custom extmarks
						vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)

						for _, highlight in ipairs(result) do
							local start_line = highlight.range.start.line
							local start_col = highlight.range.start.character
							local end_line = highlight.range["end"].line
							local end_col = highlight.range["end"].character

							pcall(vim.api.nvim_buf_set_extmark, 0, ns_id, start_line, start_col, {
								end_line = end_line,
								end_col = end_col,
								hl_group = "CustomHighlight",
							})
						end
					end)
				end

				if cursor_hold_timer then
					cursor_hold_timer:stop()
					cursor_hold_timer:close()
					cursor_hold_timer = nil
				end
			end)
		)
	end,
})
