local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local vRP = Proxy.getInterface("vRP")

cfg = {
    Weazel = {
        name = "weazel",
        secunde_ramase = 5,
    },
}

CreateThread(function ()
    local waittime = 1000
    while true do
        Wait(waittime)
        print("aa")
        for _,house in pairs(cfg) do
            house.secunde_ramase = house.secunde_ramase - 1
            TriggerClientEvent("get_wait_time_for_house", -1, house.name, house.secunde_ramase)
        end
    end
end)

RegisterNetEvent("house_robbed")
AddEventHandler("house_robbed", function (t_house)
    for _, house in pairs(cfg) do
        if house.name == t_house.name then
            house.secunde_ramase = 300
            TriggerClientEvent("get_wait_time_for_house", -1, house.name, house.secunde_ramase)            
            break
        end
    end
end)

RegisterNetEvent("rob_finished")
AddEventHandler("rob_finished", function (t_house)

    if t_house == nil then
        --trigger event ban
        TriggerEvent("kraneANTICHEAT:ban", source, " ROB_FINISHED nil")
    end


    for _, house in pairs(cfg) do
        if house.name == t_house.name then
            house.secunde_ramase = 300
            TriggerClientEvent("get_wait_time_for_house", -1, house.name, house.secunde_ramase)        

    local user = vRP.getUserId({source})
    local money = math.random(500, 1000)
    vRP.giveInventoryItem({user, "dirty_money", money,true})
    local diamante = math.random(1, 6)
    vRP.giveInventoryItem({user, "diamante", diamante,true})
    local bijuterii = math.random(1, 10)
    vRP.giveInventoryItem({user, "bijuterii", bijuterii,true})
    local date = math.random(1, 3)
    -- vRP.giveInventoryItem({user, "date_personale", date,true})
    -- local electronice = math.random(1, 3)
    vRP.giveInventoryItem({user, "electronice", electronice,true})

                TriggerEvent("kraneANTICHEAT:logger", "houses.txt", "ROB_FINISHED " .. house.name .. " bani: " .. money .. " bijuterii: ".. bijuterii .." diamante: "..diamante.." electronice: "..electronice.." " .. GetPlayerName(source))
            break
        end
    end
end)