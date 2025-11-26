#### 说明
lazyvim配置,
vscode中也可以使用此配置

#### 使用
vscode中如何配置：
1. 在settings.json中添加如下配置：
```
  "vscode-neovim.enable": true,
  "vscode-neovim.useCtrlKeys": true,
  "vscode-neovim.useWsl": false,
  "vscode-neovim.neovimExecutablePaths.darwin": "/usr/local/bin/nvim",
  "vscode-neovim.neovimInitVimPaths.darwin": "~/.config/nvim/init.lua",
  
