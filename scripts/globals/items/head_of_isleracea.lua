-----------------------------------------
-- ID: 5965
-- Item: Head of Isleracea
-- Food Effect: 5 Min, All Races
-----------------------------------------
-- Agility 2
-- Vitality -4
-----------------------------------------
require("scripts/globals/status");
-----------------------------------------

function onItemCheck(target)
    local result = 0;
    if (target:hasStatusEffect(dsp.effect.FOOD) == true or target:hasStatusEffect(dsp.effect.FIELD_SUPPORT_FOOD) == true) then
        result = 246;
    end
    return result;
end;

function onItemUse(target)
    target:addStatusEffect(dsp.effect.FOOD,0,0,300,5965);
end;

function onEffectGain(target, effect)
    target:addMod(dsp.mod.AGI, 2);
    target:addMod(dsp.mod.VIT, -4);
end;

function onEffectLose(target, effect)
    target:delMod(dsp.mod.AGI, 2);
    target:delMod(dsp.mod.VIT, -4);
end;
