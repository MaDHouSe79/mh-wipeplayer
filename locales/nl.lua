--[[ ====================================================== ]]--
--[[          QBCore Wipe Player Script by MaDHouSe         ]]--
--[[ ====================================================== ]]--

local Translations = {
    info = {
        ['already_wipe_listed'] = "Speler %{name} staat al op de wislijst",
        ['added_to_wipe_list'] = "Speler %{name} is toegevoegd aan de wislijst",
    },
    message = {
        ["reason"] = "Het account van %{naam} is gewiped. (Reason: Cheating/Bug Abuse)",
    },
    commands = {
        ['add'] = "Speler-ID toevoegen aan Wis lijst",
        ['addcid'] = "Citizenid toevoegen aan Wis lijst",
        ['wipe'] = "Speler wissen op server-ID",
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})