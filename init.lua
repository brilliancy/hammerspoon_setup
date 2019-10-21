local hyper = { "cmd", "alt", "ctrl", "shift" }
hs.hotkey.bind(hyper, "0", function()
  hs.reload()
end)

hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()

hs.loadSpoon("MiroWindowsManager")

hs.window.animationDuration = 0
spoon.MiroWindowsManager:bindHotkeys({
  up = {hyper, "j"},
  right = {hyper, "l"},
  down = {hyper, "k"},
  left = {hyper, "h"},
  fullscreen = {hyper, "i"}
})


function findOrLaunch(a)
	local app = hs.application.find(a)
	if not app then
		hs.application.launchOrFocus(a)
	end
	return hs.application.find(a)
end

hs.fnutils.each({  
	{ key = "a", func = function() 
      myTerm = findOrLaunch("iterm")
      myTerm:selectMenuItem({"Shell","New Window"}) 
      end
  },
  { key = "q", func = function()
      ffox = hs.appfinder.appFromName("Firefox")
      ffox:selectMenuItem({"File","New Window"})
      ffox:activate()
      end
  },
  { key = "z", func = function()
      finder = hs.appfinder.appFromName("Finder")
      finder:selectMenuItem({"File","New Finder Window"})
      finder:activate()
      end
  }
}, function(object) hs.hotkey.bind(hyper, object.key, object.func) end)


hs.hotkey.bind(hyper, "e", function()
  hs.hints.windowHints();
  
win:moveToScreen(win:screen():next())
end)

hs.hotkey.bind(hyper, "o", function()
  local win = hs.window.focusedWindow();
  if not win then return end
  
win:moveToScreen(win:screen():next())
end)


hs.timer.doAt("0:00","1h", function() hs.alert("Ding Dong") end)


local applicationHotkeys = {
  f = 'org.mozilla.firefox',
  --d = 'SublimeText',
--s = 'Spotify',
}

for key, app in pairs(applicationHotkeys) do
  hs.hotkey.bind('option', key, function()
   hs.application.launchOrFocusByBundleID(app)
  end)
end
