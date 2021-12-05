function rob(house)
    TriggerServerEvent("house_robbed", house)

    local ped = PlayerPedId()



    ExecuteCommand("e crossarms3")
    ExecuteCommand("me verifica zona")
    Wait(5000)
    ClearPedTasks(ped)

    while true do
        Wait(0)
        local ped_coords = GetEntityCoords(ped)
        if not house.seif.finished then
            k_draw3DText(house.seif.location.x, house.seif.location.y, house.seif.location.z + 1.5, "Seif", 1.0, 4)
            if Vdist(ped_coords, house.seif.location) < 2.0 then
                if IsControlJustPressed(1, 51) then
                    SetEntityCoords(ped, house.seif.location.x, house.seif.location.y, house.seif.location.z, 1, 0, 0, 0)
                    SetEntityHeading(ped, house.seif.heading)
                    ExecuteCommand(house.seif.anim)
                    showProgress("Spargi seiful")
                    Wait(150000)
                    house.seif.finished = true
                    ClearPedTasks(ped)
                end
            end
        end

        -- if not house.laptop.finished then
        --     k_draw3DText(house.laptop.location.x, house.laptop.location.y, house.laptop.location.z+1.5, "Balamale", 1.0, 4)
        --     if Vdist(ped_coords, house.laptop.location) < 2.0 then
        --         if IsControlJustPressed(1, 51) then
        --             SetEntityCoords(ped, house.laptop.location.x, house.laptop.location.y, house.laptop.location.z, 1, 0, 0, 0)
        --             SetEntityHeading(ped, house.laptop.heading)
        --             ExecuteCommand(house.laptop.anim)
        --             showProgress("Furi Date Personale")
        --             Wait(100000)
        --             house.laptop.finished = true
        --             ClearPedTasks(ped)
        --         end
        --     end
        -- end

        if not house.dulap1.finished then
            k_draw3DText(house.dulap1.location.x, house.dulap1.location.y, house.dulap1.location.z + 1.5, "Balamale",
                1.0, 4)
            if Vdist(ped_coords, house.dulap1.location) < 2.0 then
                if IsControlJustPressed(1, 51) then
                    SetEntityCoords(ped, house.dulap1.location.x, house.dulap1.location.y, house.dulap1.location.z, 1,
                        0, 0, 0)
                    SetEntityHeading(ped, house.dulap1.heading)
                    ExecuteCommand(house.dulap1.anim)
                    showProgress("Cauti in dulap")
                    Wait(80000)
                    house.dulap1.finished = true
                    ClearPedTasks(ped)
                end
            end
        end
        if not house.dulap2.finished then
            k_draw3DText(house.dulap2.location.x, house.dulap2.location.y, house.dulap2.location.z + 1.5, "Balamale",
                1.0, 4)
            if Vdist(ped_coords, house.dulap2.location) < 2.0 then
                if IsControlJustPressed(1, 51) then
                    SetEntityCoords(ped, house.dulap2.location.x, house.dulap2.location.y, house.dulap2.location.z, 1,
                        0, 0, 0)
                    SetEntityHeading(ped, house.dulap2.heading)
                    ExecuteCommand(house.dulap2.anim)
                    showProgress("Cauti in dulap")
                    Wait(80000)
                    house.dulap2.finished = true
                    ClearPedTasks(ped)
                end
            end
        end

        if house.laptop.finished and house.dulap1.finished and house.dulap2.finished then
            TriggerServerEvent("rob_finished", house)
            break
        end

    end
end

CreateThread(function()
    local waittime = 1000
    while true do
        Wait(waittime)
        local ped = PlayerPedId()
        local ped_coords = GetEntityCoords(ped)

        for _, house in pairs(cfg.houses) do
            local house_coords = house.location
            local seif = house.seif
            local dulap1 = house.dulap1
            local dulap2 = house.dulap2
            local dist = #(ped_coords - house_coords)

            if dist < 3.0 then
                waittime = 0
                if house.secunde_ramase <= 0 then
                    k_draw3DText(house_coords.x, house_coords.y, house_coords.z + 1.0, "Apasa [~b~E~w~] sa jefuiesti",
                        1, 1)
                    if IsControlJustPressed(1, 51) then
                        rob(house)
                    end
                else
                    -- draw cant rob
                    k_draw3DText(house_coords.x, house_coords.y, house_coords.z + 1.0,
                        "Asteapta " .. house.secunde_ramase, 1, 1)
                end
            end
        end
    end
end)

RegisterNetEvent("get_wait_time_for_house")
AddEventHandler("get_wait_time_for_house", function(house_name, ramase)
    for _, house in pairs(cfg.houses) do
        if house.name == house_name then
            house.secunde_ramase = ramase
            break
        end
    end
end)
