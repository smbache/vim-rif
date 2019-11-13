function! s:relImportFile(filepath)
  let target = getcwd() . '/' . a:filepath
  let current = expand('%:p')
  let target_tokens = split(target, '/')
  let current_tokens = split(current, '/')
  let ntokens = len(current_tokens)

  let bound = min([len(target_tokens), ntokens])
  let same_until = 0
  while same_until < bound
    if target_tokens[same_until] == current_tokens[same_until]
      let same_until += 1
    else
      break
    endif
  endwhile

  let target_remainder = join(target_tokens[same_until:-1], '/')
  let nback = ntokens - same_until - 1
  if nback == 0
    let result = './' . target_remainder
  else
    let relative = repeat('../', nback)
    let result = relative . target_remainder
  endif

  let rif_strip_regexp = get(b:, 'rif_strip_regexp', '')
  if rif_strip_regexp != ''
    let cmd = 'normal a' . substitute(result, rif_strip_regexp, '', '')
  else
    let cmd = 'normal a' . result
  endif

  exec cmd
  call feedkeys('a')
endfunction

function! s:RifWithFzf()
  let filter = get(b:, 'rif_filter', '.')

  call fzf#run({
        \ 'source' : 'git ls-files -com  --exclude-standard | sort | uniq | grep "' . filter . '"',
        \ 'sink' : function('s:relImportFile'),
        \ 'options': '--layout=reverse'
        \ })
endfunction

if mapcheck('<Plug>(RIF)') == ''
  echom 'setting plug'
  inoremap <silent><unique> <Plug>(RIF) <ESC>:call <SID>RifWithFzf()<CR>
endif

if !hasmapto('<Plug>(RIF)', 'i')
  imap <C-SPACE> <Plug>(RIF)
endif

