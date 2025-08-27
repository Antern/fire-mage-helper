local TYPE = "fire-mage-helper"

local function createOptions(id, region)
  return {
    __title = "fire-mage-helper",
    text = {
      type = "input",
      name = "Text",
      order = 1,
      width = "full",
      get = function() return region.text or "OK" end,
      set = function(_, v) region.text = v end,
    },
    duration = {
      type = "range",
      name = "Duration (seconds)",
      order = 2,
      min = 0.05, max = 2, step = 0.05,
      get = function() return region.duration or 0.30 end,
      set = function(_, v) region.duration = v end,
    },
    fontSize = {
      type = "range",
      name = "Font Size",
      order = 3,
      min = 8, max = 128, step = 1,
      get = function() return region.fontSize or 32 end,
      set = function(_, v) region.fontSize = v end,
    },
    outline = {
      type = "select",
      name = "Outline",
      order = 4,
      values = { NONE = "None", OUTLINE = "Outline", THICKOUTLINE = "Thick Outline" },
      get = function() return region.outline or "OUTLINE" end,
      set = function(_, v) region.outline = v end,
    },
    color = {
      type = "color",
      name = "Text Color",
      order = 5,
      hasAlpha = true,
      get = function()
        local c = region.color or {1,1,1,1}
        return c[1], c[2], c[3], c[4]
      end,
      set = function(_, r,g,b,a) region.color = {r,g,b,a} end,
    },
    width = {
      type = "range",
      name = "Width",
      order = 6,
      min = 16, max = 512, step = 1,
      get = function() return region.width or 128 end,
      set = function(_, v) region.width = v end,
    },
    height = {
      type = "range",
      name = "Height",
      order = 7,
      min = 16, max = 512, step = 1,
      get = function() return region.height or 64 end,
      set = function(_, v) region.height = v end,
    },
  }
end

if WeakAuras and WeakAuras.RegisterRegionOptions then
  WeakAuras.RegisterRegionOptions(TYPE, createOptions, "Interface\\Icons\\Ability_Leap", "fire-mage-helper")
end
