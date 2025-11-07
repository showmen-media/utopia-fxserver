local QBCore = exports['qb-core']:GetCoreObject()

-- Disable cinematographic sound that plays when you are on an airplane
Citizen.CreateThread(function()
	while true do
		SetAudioFlag('DisableFlightMusic', true)
		Citizen.Wait(0)
	end
end)

-- Disable vehicle weapons
Citizen.CreateThread(function()
    while true do
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) and
                 GetCurrentPedWeapon(PlayerPedId(), false) then
                SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED")
            end
        else
            Citizen.Wait(3000)
        end
        Citizen.Wait(5)
    end
end)


local blips = {
	{
		title="New Beginnings Cafe", id=889, colour=0,
		x = 4493.06, y = -4526.19, z = 4.65
	}
}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)


-- Boat intro
local vehicle = nil

RegisterNetEvent('qb-multicharacter:client:closeNUIdefault', function()
    Wait(2200)

    local ped = PlayerPedId()
    local hash = joaat('tug')
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
    end

	local spawnCoords = vector4(-3500, 4500, -1.7, 270)

	spawnCoords += vector4(
		math.random(-250, 250),
		math.random(-500, 500),
		0,
		0
	)

    vehicle = CreateVehicle(hash, spawnCoords, true, false)
	FreezeEntityPosition(vehicle, true)
    -- TaskWarpPedIntoVehicle(ped, vehicle, -1)
    SetVehicleFuelLevel(vehicle, 100.0)
    SetVehicleDirtLevel(vehicle, 100.0)
    SetModelAsNoLongerNeeded(hash)
    TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(vehicle))

	spawnCoords += vector4(-11.73, 0.21, 5, -180)

    SetEntityCoords(PlayerPedId(), spawnCoords.x, spawnCoords.y, spawnCoords.z)
	SetEntityHeading(PlayerPedId(), spawnCoords.w)
end)

RegisterNetEvent('qb-clothing:client:onMenuClose', function()
	if vehicle then
		FreezeEntityPosition(vehicle, false)
	end
end)

print('YOU\'RE RUNNING ' .. GetGameBuildNumber())
