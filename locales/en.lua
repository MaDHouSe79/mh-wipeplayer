--[[ ====================================================== ]]--
--[[          QBCore Wipe Player Script by MaDHouSe         ]]--
--[[ ====================================================== ]]--

local Translations = {
    info = {
        ['already_wipe_listed'] = "Player %{name} is already on the wipe list",
        ['added_to_wipe_list'] = "Player %{name} is added to the wipe list",
    },
    message = {
        ["reason"] = "The account of %{naam} has been wiped (Reason: Cheating/Bug Abuse)",
    },
    commands = {
        ['add'] = "Add a player id to Wipe list",
        ['addcid'] = "Add a Citizenid to Wipe list",
        ['wipe'] = "Wipe Player by Server ID",
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})