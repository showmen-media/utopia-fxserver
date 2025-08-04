
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

