## Relative Importing of Files (RIF) for vim

### Installation 
```
Plug 'smbache/vim-rif'
```
NOTE: The plugin requires that `fzf`, `fzf.vim` and `git` is installed.


### Usage
The default mapping is

```
imap <C-SPACE> <Plug>(RIF)
```

which is only set if you don't provide your own.

### Customization:
You can define a filter with `b:rif_filter` (a `grep` compatible pattern)
which will be applied to filter the list of files searched.
Define this in an `ftplugin/` file to apply to specific file types.

Also, `b:rif_strip_regexp` can be defined to customise a pattern to remove
from the result, e.g. to remove file type extensions etc.
