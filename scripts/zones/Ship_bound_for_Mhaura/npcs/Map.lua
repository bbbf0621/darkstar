-----------------------------------
-- Area: Ship_bound_for_Mhaura
--  NPC: Map
-- !pos 0.278 -14.707 -1.411 221
-----------------------------------
package.loaded["scripts/zones/Ship_bound_for_Mhaura/TextIDs"] = nil;
-----------------------------------
require("scripts/zones/Ship_bound_for_Mhaura/TextIDs");
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    player:startEvent(1024);
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
end;