--[[ ====================================================== ]]--
--[[          QBCore Wipe Player Script by MaDHouSe         ]]--
--[[ ====================================================== ]]--

local QBCore = exports['qb-core']:GetCoreObject()

local function sendToDiscord(title, message)
    if Config.UseWebHook then
	if Config.Webhook == "" then
	    print("you have no webhook, create one on discord [https://discord.com/developers/applications] and place this in the config.lua (Config.Webhook)")
	else
	    if message == nil or message == '' then return end
		LogArray = {
		    {
			["color"] = "16711680",
			["title"] = "WIPE PLAYER ACCOUNT",
			["description"] = "Time: **"..os.date('%Y-%m-%d %H:%M:%S').."**",
			["fields"] = {
			{
			    ["name"] = "Message",
			    ["value"] = message
			}
		    },
			["footer"] = {
			["text"] = "qb-wipeplayer by MaDHouSe",
			["icon_url"] = "https://icons.iconarchive.com/icons/iconarchive/red-orb-alphabet/128/Letter-M-icon.png",
		    }
		}
	    }
	    PerformHttpRequest(Config.Webhook , function(err, text, headers) end, 'POST', json.encode({username = "WIPE PLAYER", embeds = LogArray}), { ['Content-Type'] = 'application/json' })
	end
    end
end

RegisterNetEvent("qb-wipeplayer:server:onjoin", function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local rs = MySQL.Sync.fetchScalar('SELECT COUNT(*) FROM player_wipes WHERE citizenid = ?', {Player.PlayerData.citizenid})
    if rs == 1 then
        Wait(25 * 1000)
	local fullname = Player.PlayerData.charinfo.firstname .." "..Player.PlayerData.charinfo.lastname
        TriggerClientEvent('qb-wipeplayer:client:createNewChar', Player.PlayerData.source)
        TriggerClientEvent('QBCore:Notify', -1, Lang:t('message.reason', {naam = fullname}), "success", 15000)
        MySQL.Async.execute('DELETE FROM player_wipes WHERE citizenid = ?', {Player.PlayerData.citizenid})
        sendToDiscord("PLAYER ACCOUNT WIPE", Lang:t('message.reason', {naam = fullname}))
    end
end)


QBCore.Commands.Add(Config.Commands.addtolist, Lang:t('commands.add'), {}, false, function(source, args)
    local src = source
    if args[1] and tonumber(args[1]) > 0 then
	local id = tonumber(args[1])
	if id > 0 then
            local Player = QBCore.Functions.GetPlayer(id)
            MySQL.Async.fetchAll("SELECT * FROM player_wipes WHERE citizenid = ?", {Player.PlayerData.citizenid}, function(rs)
		if type(rs) == 'table' and #rs > 0 then
		    TriggerClientEvent('QBCore:Notify', src, Lang:t('info.already_wipe_listed'), "error")
		else
		    MySQL.Async.execute("INSERT INTO player_wipes (citizenid) VALUES (?)", {Player.PlayerData.citizenid})
		    TriggerClientEvent('QBCore:Notify', src, Lang:t('info.added_to_wipe_list'), "success")
		end
	    end)
        end
    end
end, "admin")


QBCore.Commands.Add(Config.Commands.wipeplayer, Lang:t('commands.wipe'), {}, false, function(source, args)
    local src = source
    if args[1] and tonumber(args[1]) > 0 then
	local id = tonumber(args[1])
	if id > 0 then
            local Player = QBCore.Functions.GetPlayer(id)
            TriggerClientEvent('qb-wipeplayer:client:createNewChar', Player.PlayerData.source)
            local fullname = Player.PlayerData.charinfo.firstname .." "..Player.PlayerData.charinfo.lastname
            TriggerClientEvent('QBCore:Notify', -1, Lang:t('message.reason', {naam = fullname}), "success", 15000)
            sendToDiscord("PLAYER ACCOUNT WIPE", Lang:t('message.reason', {naam = fullname}))
        end
    end
end, "admin")


QBCore.Commands.Add(Config.Commands.addcid, Lang:t('commands.addcid'), {}, false, function(source, args)
    local src = source
    if args[1] and tostring(args[1]) then
	local citizenid = tostring(args[1])
	if citizenid ~= nil then
            local Player = QBCore.Functions.GetOfflinePlayerByCitizenId(citizenid)
            local fullname = Player.PlayerData.charinfo.firstname .." "..Player.PlayerData.charinfo.lastname
            MySQL.Async.fetchAll("SELECT * FROM player_wipes WHERE citizenid = ?", {citizenid}, function(rs)
		if type(rs) == 'table' and #rs > 0 then
	            TriggerClientEvent('QBCore:Notify', src, Lang:t('info.already_wipe_listed', {name= fullname}), "error")
		else
		    MySQL.Async.execute("INSERT INTO player_wipes (citizenid) VALUES (?)", {citizenid})
		    TriggerClientEvent('QBCore:Notify', src, Lang:t('info.added_to_wipe_list', {name= fullname}), "success")
		end
	    end)
        end
    end
end, "admin")
