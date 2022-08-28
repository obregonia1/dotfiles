local simpleCmd = false
local map = hs.keycodes.map
local function eikanaEvent(event)
  local c = event:getKeyCode()
  local f = event:getFlags()
  if event:getType() == hs.eventtap.event.types.keyDown then
    if f['cmd'] then
      simpleCmd = true
    end
  elseif event:getType() == hs.eventtap.event.types.flagsChanged then
    if not f['cmd'] then
      if simpleCmd == false then
        if c == map['cmd'] then
        --  hs.keycodes.setMethod('Alphanumeric (Google)')
          hs.keycodes.setMethod('Hiragana (Google)')
        elseif c == map['rightcmd'] then
        --  hs.keycodes.setMethod('Hiragana (Google)')
          hs.keycodes.setMethod('Alphanumeric (Google)')
        end
      end
      simpleCmd = false
    end
  end
end

eikana = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.flagsChanged}, eikanaEvent)
eikana:start()

local function keyCode(key, mods, callback)
  mods = mods or {}
  callback = callback or function() end
  return function()
    hs.eventtap.event.newKeyEvent(mods, string.lower(key), true):post()
    hs.timer.usleep(1000)
    hs.eventtap.event.newKeyEvent(mods, string.lower(key), false):post()

    callback()
  end
end

local function switchHotKeys(enable)
    for k, v in pairs(hs.hotkey.getHotkeys()) do
        if enable then
            v["_hk"]:enable()
        else
            for _, n in pairs(globalRemaps) do
                if n == k then
                  -- do nothing
                else
                  v["_hk"]:disable()
                end
            end
        end
    end
end

local function handleGlobalEvent(name, event, app)
    if event == hs.application.watcher.activated then
        if name == "Google Chrome" then
            switchHotKeys(true)
        else
            switchHotKeys(false)
        end
    end
end

local function remapKey(modifiers, key, keyCode)
   hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

watcher = hs.application.watcher.new(handleGlobalEvent)
watcher:start()

globalRemaps = {1, 2, 3}

-- globalRemaps start
remapKey({"ctrl"}, "[", keyCode("escape"))
remapKey({"alt"}, ";", keyCode("\\"))
remapKey({"alt"}, "'", keyCode("\\", {"shift"}))
-- globalRemaps end

remapKey({"ctrl"}, "n", keyCode("down"))
remapKey({"ctrl"}, "p", keyCode("up"))

