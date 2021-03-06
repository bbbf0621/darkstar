-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Ailbeche
-- Starts and Finishes Quest: Father and Son, Sharpening the Sword, A Boy's Dream (start)
-- !pos 4 -1 24 231
-----------------------------------
package.loaded["scripts/zones/Northern_San_dOria/TextIDs"] = nil;
-----------------------------------
require("scripts/zones/Northern_San_dOria/TextIDs");
require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/titles");
require("scripts/globals/quests");
require("scripts/globals/shop");
-----------------------------------

function onTrade(player,npc,trade)
    -- "Flyers for Regine" conditional script
    local FlyerForRegine = player:getQuestStatus(SANDORIA,FLYERS_FOR_REGINE);

    if (player:getQuestStatus(SANDORIA, FATHER_AND_SON) == QUEST_COMPLETED and player:getVar("returnedAilbecheRod") ~= 1) then
        if (trade:hasItemQty(17391,1) == true and trade:getItemCount() == 1) then
            player:startEvent(61); -- Finish Quest "Father and Son" (part2) (trading fishing rod)
        end
    end

    if (player:getVar("aBoysDreamCS") >= 3) then
        if (trade:hasItemQty(17001,1) == true and trade:getItemCount() == 1 and player:hasItem(4562) == false) then
            player:startEvent(15); -- During Quest "A Boy's Dream" (trading bug) madame ?
        elseif (trade:hasItemQty(4562,1) == true and trade:getItemCount() == 1) then
            player:startEvent(47); -- During Quest "A Boy's Dream" (trading odontotyrannus)
        end
    end

    if (FlyerForRegine == 1) then
        local count = trade:getItemCount();
        local MagicFlyer = trade:hasItemQty(532,1);
        if (MagicFlyer == true and count == 1) then
            player:messageSpecial(FLYER_REFUSED);
        end
    end
end;

function onTrigger(player,npc)
    fatherAndSon = player:getQuestStatus(SANDORIA, FATHER_AND_SON);
    sharpeningTheSword = player:getQuestStatus(SANDORIA, SHARPENING_THE_SWORD);
    aBoysDream = player:getQuestStatus(SANDORIA, A_BOY_S_DREAM);

    -- Checking levels and jobs for af quest
    mLvl = player:getMainLvl();
    mJob = player:getMainJob();
    -- Check if they have key item "Ordelle whetStone"
    OrdelleWhetstone = player:hasKeyItem(dsp.ki.ORDELLE_WHETSTONE);
    sharpeningTheSwordCS = player:getVar("sharpeningTheSwordCS");
    aBoysDreamCS = player:getVar("aBoysDreamCS");

    -- "Father and Son" Event Dialogs
    if (fatherAndSon == QUEST_AVAILABLE) then
        player:startEvent(508); -- Start Quest "Father and Son"
    elseif (fatherAndSon == QUEST_ACCEPTED and player:getVar("QuestfatherAndSonVar") == 1) then
        player:startEvent(509); -- Finish Quest "Father and Son" (part1)
    elseif (sharpeningTheSword == QUEST_AVAILABLE and player:getVar("returnedAilbecheRod") == 1) then
        if (mJob == 7 and mLvl < 40 or mJob ~= 7) then
            player:startEvent(12); -- Dialog after "Father and Son" (part2)
    -- "Sharpening the Sword" Quest Dialogs
        elseif (mJob == 7 and mLvl >= 40 and sharpeningTheSwordCS == 0) then
            player:startEvent(45); -- Start Quest "Sharpening the Sword" with thank you for the rod
        elseif (mJob == 7 and mLvl >= 40 and sharpeningTheSwordCS == 1) then
            player:startEvent(43); -- Start Quest "Sharpening the Sword"
        end
    elseif (sharpeningTheSword == QUEST_ACCEPTED and OrdelleWhetstone == false) then
        player:startEvent(42); -- During Quest "Sharpening the Sword"
    elseif (sharpeningTheSword == QUEST_ACCEPTED and OrdelleWhetstone == true) then
        player:startEvent(44); -- Finish Quest "Sharpening the Sword"
    -- "A Boy's Dream" Quest Dialogs
    elseif (aBoysDream == QUEST_AVAILABLE and mJob == 7 and mLvl >= 50) then
        if (aBoysDreamCS == 0) then
            player:startEvent(41); -- Start Quest "A Boy's Dream" (long cs)
        else
            player:startEvent(40); -- Start Quest "A Boy's Dream" (shot cs)
        end
    elseif (aBoysDreamCS == 2) then
        player:startEvent(46); -- During Quest "A Boy's Dream"
    elseif (aBoysDreamCS == 3) then
        player:startEvent(39); -- During Quest "A Boy's Dream" (after exoroche cs)
    elseif (aBoysDreamCS == 4) then
        player:startEvent(60); -- During Quest "A Boy's Dream" (after trading bug) madame ?
    elseif (aBoysDreamCS == 5) then
        player:startEvent(47); -- During Quest "A Boy's Dream" (after trading odontotyrannus)
    elseif (aBoysDreamCS >= 6) then
        player:startEvent(25); -- During Quest "A Boy's Dream" (after Zaldon CS)
    elseif (player:hasKeyItem(dsp.ki.KNIGHTS_CONFESSION) and player:getVar("UnderOathCS") == 6) then
        player:startEvent(59); -- During Quest "Under Oath" (he's going fishing in Jugner)
    elseif (player:getVar("UnderOathCS") == 8) then
        player:startEvent(13); -- During Quest "Under Oath" (After jugner CS)
    else
        player:startEvent(868); -- Standard dialog
    end
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)

    -- "Father and Son"
    if (csid == 508) then
        player:addQuest(SANDORIA,FATHER_AND_SON);
    elseif (csid == 509) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,17391);
        else
            player:addItem(17391);
            player:messageSpecial(ITEM_OBTAINED, 17391); -- Willow Fishing Rod
            player:addTitle(dsp.title.LOST_CHILD_OFFICER);
            player:setVar("QuestfatherAndSonVar",0);
            player:addFame(SANDORIA,30);
            player:completeQuest(SANDORIA,FATHER_AND_SON);
        end
    elseif (csid == 61) then
        player:setVar("returnedAilbecheRod",1);
        player:addTitle(dsp.title.FAMILY_COUNSELOR);
        player:tradeComplete();
    -- "Sharpening the Sword"
    elseif ((csid == 45 or csid == 43) and option == 1) then
        player:addQuest(SANDORIA,SHARPENING_THE_SWORD);
        player:setVar("sharpeningTheSwordCS",2);
        player:setVar("returnedAilbecheRod",0);
    elseif (csid == 45 and option == 0) then
        player:setVar("sharpeningTheSwordCS",1);
    elseif (csid == 44) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,17643);
        else
            player:delKeyItem(dsp.ki.ORDELLE_WHETSTONE);
            player:addItem(17643);
            player:messageSpecial(ITEM_OBTAINED, 17643); -- Honor Sword
            player:setVar("sharpeningTheSwordCS",0);
            player:addFame(SANDORIA,30);
            player:completeQuest(SANDORIA,SHARPENING_THE_SWORD);
        end
    -- "A Boy's Dream"
    elseif ((csid == 41 or csid == 40) and option == 1) then
        player:addQuest(SANDORIA,A_BOY_S_DREAM);
        player:setVar("aBoysDreamCS",2);
    elseif (csid == 41 and option == 0) then
        player:setVar("aBoysDreamCS",1);
    elseif (csid == 15 and player:getVar("aBoysDreamCS") == 3) then
        player:setVar("aBoysDreamCS",4);
    elseif (csid == 47 and player:getVar("aBoysDreamCS") == 4) then
        player:setVar("aBoysDreamCS",5);
    elseif (csid == 25 and player:getVar("aBoysDreamCS") == 6) then
        player:setVar("aBoysDreamCS",7);
    elseif (csid == 59) then
        player:setVar("UnderOathCS", 7);
    end
end;