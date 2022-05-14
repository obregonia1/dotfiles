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

fbpn = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(e)
    if e:getFlags().ctrl and e:getFlags().shift then
      if e:getKeyCode() == 35 then
        hs.eventtap.event.newKeyEvent({"shift"}, "up", true):post(); return true;
      elseif e:getKeyCode() == 11 then
        hs.eventtap.event.newKeyEvent({"shift"}, "left", true):post(); return true;
      elseif e:getKeyCode() == 45 then
        hs.eventtap.event.newKeyEvent({"shift"}, "down", true):post(); return true;
      elseif e:getKeyCode() == 3 then
        hs.eventtap.event.newKeyEvent({"shift"}, "right", true):post(); return true;
      elseif e:getKeyCode() == 6 then
        hs.eventtap.event.newKeyEvent({'shift','cmd'}, 'z', true):post(); return true;
      end
    end

    if e:getFlags().ctrl then
    if e:getKeyCode() == 35 then
      hs.eventtap.event.newKeyEvent({}, 'up', true):post(); return true;
    elseif e:getKeyCode() == 11 then
      hs.eventtap.event.newKeyEvent({}, 'left', true):post(); return true;
    elseif e:getKeyCode() == 45 then
      hs.eventtap.event.newKeyEvent({}, 'down', true):post(); return true;
    elseif e:getKeyCode() == 3 then
      hs.eventtap.event.newKeyEvent({}, 'right', true):post(); return true;
    end
  end

  return false
end)
fbpn:start()

local function keyCode(key, modifiers)
   modifiers = modifiers or {}
   return function()
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
      hs.timer.usleep(1000)
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
   end
end

local function keyCodeUpper(key, modifiers)
   modifiers = modifiers or {}
   return function()
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
      hs.timer.usleep(1000)
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
   end
end

local function remapKey(modifiers, key, keyCode)
   hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

local function remapKeyUpper(modifiers, key, keyCodeUpper)
   hs.hotkey.bind(modifiers, key, keyCode, nil, keyCodeUpper)
end

remapKey({"ctrl"}, ";", keyCode("\\"))
remapKey({"ctrl"}, "'", keyCode("\\", {"shift"}))

