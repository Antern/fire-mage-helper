local TYPE = "FireMageHelper"
local VERSION = 1

local function create(parent)
  local frame = CreateFrame("Frame", nil, parent)
  frame:SetSize(128, 64)

  local text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge")
  text:SetPoint("CENTER")
  text:SetText("OK")
  frame.text = text

  frame.okonjump = {
    wasFalling = false,
    showUntil = 0,
    duration = 0.30,
    color = {1,1,1,1},
    fontSize = 32,
    outline = "OUTLINE",
  }

  frame:SetScript("OnUpdate", function(self, elapsed)
    local now = GetTime()
    local falling = IsFalling()
    local state = self.okonjump

    if falling and not state.wasFalling then
      -- rising edge: just started to fall (jumped or walked off a ledge)
      state.showUntil = now + state.duration
      self:Show()
      self.text:SetAlpha(1)
    end

    if now >= state.showUntil then
      self:Hide()
    end

    state.wasFalling = falling
  end)

  frame:Hide()
  return frame
end

local function applyFont(fs, size, outline, color)
  local font = _G["GameFontNormalHuge"]:GetFont()
  fs:SetFont(font, size or 32, outline or "OUTLINE")
  if color then
    fs:SetTextColor(color[1] or 1, color[2] or 1, color[3] or 1, color[4] or 1)
  end
end

local function modify(frame, regionData)
  -- regionData fields defined by our options defaults
  local state = frame.okonjump
  state.duration = tonumber(regionData.duration) or 0.30
  state.color = regionData.color or {1,1,1,1}
  state.fontSize = tonumber(regionData.fontSize) or 32
  state.outline = regionData.outline or "OUTLINE"

  frame.text:SetText(regionData.text or "OK")
  applyFont(frame.text, state.fontSize, state.outline, state.color)

  local w = tonumber(regionData.width) or 128
  local h = tonumber(regionData.height) or 64
  frame:SetSize(w, h)
end

local default = {
  text = "OK",
  duration = 0.30,
  fontSize = 32,
  outline = "OUTLINE",
  color = {1,1,1,1},
  width = 128,
  height = 64,
}

local properties = {
  supports = { "alpha", "scale" },
  version = VERSION,
}

if WeakAuras and WeakAuras.RegisterRegionType then
  WeakAuras.RegisterRegionType(TYPE, create, modify, default, properties)
end
