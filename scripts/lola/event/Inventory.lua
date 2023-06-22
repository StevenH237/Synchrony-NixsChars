local Event = require "necro.event.Event"

local RevealedItems = require "Lola.mod.RevealedItems"

Event.inventoryAddItem.add("untrack", { order = "unmap", sequence = 1 },
  function(ev)
    if ev.item.Lola_revealedBy then
      RevealedItems.unmark(ev.item)
    end
  end
)

Event.itemConsume.add("glassShard", { order = "convert", sequence = 1 },
  function(ev)
    local drop = ev.droppedItem
    if drop and drop.itemNegateLowPercent then
      drop.itemNegateLowPercent.active = false
    end
  end
)

Event.storageDetach.add("itemTracker", { order = "item", sequence = 1 },
  function(ev)
    local container = ev.container
    local entity = ev.entity

    -- print("Storage detach event")

    if ev.suppressed or (not entity.itemNegateLowPercent) or container.Lola_interactedBy.playerID == 0 then return end

    RevealedItems.markPID(container.Lola_interactedBy.playerID, entity)

    -- print(entity.name .. " revealed by player " .. container.Lola_interactedBy.playerID)
  end
)
