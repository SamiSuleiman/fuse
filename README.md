### installation

with lazy

```lua
    {
      'samisul/fuse',
      opts = {},
    },
```

### what is this?

this plugin exposes a `fuse` function that returns a string containing the tmux windows in the current session with the current window highlighted like this:

`0 1 2 [3] 5 6 9`

#### why?

having the tmux bar when inside neovim is annoying and is not needed but sometimes you need to know what window you're on and where to jump.

#### example usages

##### with bufferline

```lua
    {
      'akinsho/bufferline.nvim',
      enabled = true,
      version = '*',
      opts = {},
      config = function()
        require('bufferline').setup {
          options = {
            custom_areas = {
              right = function()
                local info = require('fuse').fuse()
                local result = {}
                if info ~= 0 then
                  table.insert(result, { text = '  ' .. info, bg = '#191724' })
                end
                return result
              end,
            },
          },
        }
      end,
    },
```

result: it might be a good idea to set custom autocmds to call this for you and maybe set a global variable, because you sometimes have to press ESC for bufferline to update the custom areas :)  
![1](./.github/1.png)
