local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('drug_run:checkDrugs')
AddEventHandler('drug_run:checkDrugs', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local drugs = xPlayer.Functions.GetItemByName(Config.DrugsItem)

    if drugs and drugs.amount >= Config.DrugsAmount then
        xPlayer.Functions.RemoveItem(Config.DrugsItem, Config.DrugsAmount)

        local payment = math.random(Config.Payment.min, Config.Payment.max)
        xPlayer.Functions.AddMoney(Config.BlackMoney, payment)

        TriggerClientEvent('lib.notify', src, {
            title = 'Drug Run',
            description = Config.Notifications.success,
            type = 'success'
        })
    else
        TriggerClientEvent('lib.notify', src, {
            title = 'Drug Run',
            description = Config.Notifications.notEnoughDrugs,
            type = 'error'
        })
    end
end)
