require "app_switcher"

local VimMode = hs.loadSpoon('VimMode')
local vim = VimMode:new()
vim
  :bindHotKeys({ enter = {{'cmd'}, 'escape'} })
  :shouldDimScreenInNormalMode(false)
  :disableForApp('Code')
  :disableForApp('MacVim')
  :disableForApp('zoom.us')

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
