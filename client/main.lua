local isMissionActive = false
local hasDrugs = false

local function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
end

local function playAnim(ped, dict, anim)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(1)
    end
    TaskPlayAnim(ped, dict, anim, 8.0, -8.0, -1, 1, 0, false, false, false)
end

local function notify(type, message)
    lib.notify({
        title = 'Drug Run',
        description = message,
        type = type
    })
end

local function startMission()
    if isMissionActive then
        notify('error', 'Mission already active!')
        return
    end

    isMissionActive = true

    notify('inform', Config.Notifications.missionStarted)

    -- NPC 1 Interaction
    local npc1Coords = Config.NPC1.coords
    SetNewWaypoint(npc1Coords.x, npc1Coords.y)

    if Config.UseQBTarget then
        exports['qb-target']:AddTargetModel(Config.NPC1.model, {
            options = {
                {
                    type = "client",
                    event = "drug_run:startDialog",
                    icon = "fas fa-comment",
                    label = "Talk to NPC",
                },
            },
            distance = 2.5
        })
    else
        exports['ox_target']:AddBoxZone("npc1", npc1Coords, 1, 1, {
            name = "npc1",
            heading = Config.NPC1.heading,
            debugPoly = false,
            minZ = npc1Coords.z - 1,
            maxZ = npc1Coords.z + 1,
        }, {
            options = {
                {
                    type = "client",
                    event = "drug_run:startDialog",
                    icon = "fas fa-comment",
                    label = "Talk to NPC",
                },
            },
            distance = 2.5
        })
    end
end

RegisterNetEvent('drug_run:startDialog', function()
    local playerPed = PlayerPedId()
    playAnim(playerPed, Config.NPC1.animation.dict, Config.NPC1.animation.anim)

    Wait(3000)

    -- Set waypoint to second NPC
    SetNewWaypoint(Config.NPC2.coords.x, Config.NPC2.coords.y)

    -- Add third eye to NPC 2
    if Config.UseQBTarget then
        exports['qb-target']:AddTargetModel(Config.NPC2.model, {
            options = {
                {
                    type = "client",
                    event = "drug_run:collectDrugs",
                    icon = "fas fa-hand-holding",
                    label = "Collect Drugs",
                },
            },
            distance = 2.5
        })
    else
        exports['ox_target']:AddBoxZone("npc2", Config.NPC2.coords, 1, 1, {
            name = "npc2",
            heading = Config.NPC2.heading,
            debugPoly = false,
            minZ = Config.NPC2.coords.z - 1,
            maxZ = Config.NPC2.coords.z + 1,
        }, {
            options = {
                {
                    type = "client",
                    event = "drug_run:collectDrugs",
                    icon = "fas fa-hand-holding",
                    label = "Collect Drugs",
                },
            },
            distance = 2.5
        })
    end
end)

RegisterNetEvent('drug_run:collectDrugs', function()
    if hasDrugs then
        notify('error', 'You already have the drugs!')
        return
    end

    local playerPed = PlayerPedId()
    playAnim(playerPed, Config.NPC2.animation.dict, Config.NPC2.animation.anim)

    Wait(3000)

    hasDrugs = true
    notify('success', Config.Notifications.drugsCollected)

    SetNewWaypoint(Config.NPC1.coords.x, Config.NPC1.coords.y)
end)

RegisterNetEvent('drug_run:completeMission', function()
    if not hasDrugs then
        notify('error', 'You don\'t have any drugs!')
        return
    end

    local playerPed = PlayerPedId()
    playAnim(playerPed, Config.NPC1.animation.dict, Config.NPC1.animation.anim)

    Wait(3000)

    -- Check if player has drugs
    TriggerServerEvent('drug_run:checkDrugs')

    isMissionActive = false
    hasDrugs = false
end)

RegisterCommand('startdrugrun', function()
    startMission()
end, false)
