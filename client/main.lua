--[[ ====================================================== ]]--
--[[          QBCore Wipe Player Script by MaDHouSe         ]]--
--[[ ====================================================== ]]--

local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent('qb-wipeplayer:server:onjoin', PlayerData.source)
end)

RegisterNetEvent("qb-wipeplayer:client:createNewChar", function()
    PlayerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent('qb-multicharacter:server:deleteCharacter', PlayerData.citizenid)
    TriggerEvent('qb-multicharacter:client:chooseChar')
end)