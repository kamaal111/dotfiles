hs.hotkey.bind({"cmd"}, "`", function()
  local app = hs.application.get("Rex")

  if not app then
    hs.application.launchOrFocus("Rex")
  elseif app:isFrontmost() then
    app:hide()
  else
    app:activate()
  end
end)
