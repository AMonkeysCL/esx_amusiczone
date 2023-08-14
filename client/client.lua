

--- [[Creado por AMonkeys]] ---


local isPlaying = false
local currentVolume = 0.5
local currentLink = ""

RegisterNetEvent('esx_amusiczone:playMusic')
AddEventHandler('esx_amusiczone:playMusic', function(link)
    currentLink = link
    isPlaying = true
    TriggerEvent('esx_amusiczone:updateMusic')
end)

RegisterNetEvent('esx_amusiczone:stopMusic')
AddEventHandler('esx_amusiczone:stopMusic', function()
    isPlaying = false
    TriggerEvent('esx_amusiczone:updateMusic')
end)

RegisterNetEvent('esx_amusiczone:updateVolume')
AddEventHandler('esx_amusiczone:updateVolume', function(volume)
    currentVolume = volume
    TriggerEvent('esx_amusiczone:updateMusic')
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(playerCoords, Config.MusicZone.x, Config.MusicZone.y, Config.MusicZone.z, true)

        if isPlaying and distance <= Config.MusicZone.radius then
            SendNUIMessage({
                type = "playMusic",
                link = currentLink,
                volume = currentVolume
            })
        else
            SendNUIMessage({
                type = "stopMusic"
            })
        end
    end
end)
