-----------------------------------
-- Area: Yuhtunga Jungle
--  MOB: River Sahagin
-----------------------------------
require("scripts/globals/fieldsofvalor");
-----------------------------------

function onMobDeath(mob, player, isKiller)
    checkRegime(player,mob,127,1);
end;
