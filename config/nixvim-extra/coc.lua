local cmd, fn, api = vim.cmd, vim.fn, vim.api

api.nvim_set_keymap('i', '<C-Space>', 'coc#refresh()', { silent = true, expr = true })
api.nvim_set_keymap('i', '<S-TAB>', "pumvisible() ? '<C-p>' : '<C-h>'", { noremap = true, expr = true })

vim.keymap.set('i', '<Cr>', function()
    if fn['coc#pum#visible']() == 1 then
        return fn['coc#pum#confirm']()
    else
        return '<Cr>'
    end
end, { silent = true, noremap = true, expr = true })

vim.g.coc_snippet_next = '<tab>'

api.nvim_create_augroup('coc_patch_autocmd', { clear = true })

api.nvim_create_autocmd({ 'ModeChanged' }, {
    group = 'coc_patch_autocmd',
    pattern = '*',
    callback = function()
        if fn.mode() == 's' then
            local key = api.nvim_replace_termcodes('<C-r>_', true, false, true)
            api.nvim_feedkeys(key, 's', false)
        end
    end,
    once = false,
})

api.nvim_create_autocmd({ 'WinEnter' }, {
    group = 'coc_patch_autocmd',
    pattern = '*',
    callback = function()
        vim.defer_fn(function()
            if vim.bo.filetype == 'coc-explorer' and api.nvim_win_get_config(0).relative ~= '' then
                api.nvim_win_set_config(0, {
                    zindex = 10,
                })
            end
        end, 100)
    end,
})

api.nvim_create_user_command('CocFormat', function()
    fn.CocActionAsync('format')
end, {
    desc = 'coc lsp format with async',
})

api.nvim_create_user_command('CocMarketplace', function()
    vim.cmd([[CocList marketplace]])
end, {
    desc = 'open coc marketplace',
})

vim.g.coc_quickfix_open_command = 'vsplit'

cmd([[
    hi link CocGitAddedSign GitNew
    hi link CocGitRemovedSign GitDeleted
    hi link CocGitTopRemovedSign GitDeleted
    hi link CocGitChangeRemovedSign GitDeleted
    hi link CocGitChangedSign GitDirty
]])

local explorer_size = 40
local function resize_handler(num)
    return function()
        if explorer_size <= 5 then
            return
        end

        explorer_size = explorer_size + 5
        vim.cmd([[vertical resize ]] .. string.format(num > 0 and '+%d' or '%d', num))
    end
end
api.nvim_create_autocmd('filetype', {
    group = 'coc_patch_autocmd',
    pattern = 'coc-explorer',
    callback = function()
        vim.keymap.set('n', '-', resize_handler(-5), { buffer = true })
        vim.keymap.set('n', '=', resize_handler(5), { buffer = true })
    end,
})
api.nvim_create_user_command('CocExplorer', function()
    cmd(string.format([[CocCommand explorer --position right --width %d]], explorer_size))
end, {
    desc = 'Open Coc Explorer',
})

vim.keymap.set('n', 'K', function()
  if fn.CocAction('hasProvider', 'hover') then
    fn.CocActionAsync('definitionHover')
  else
    fn.feedkeys('K', 'in')
  end
end, { silent = true, })
