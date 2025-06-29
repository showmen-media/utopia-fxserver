
-- Disable cinematographic sound that plays when you are on an airplane
Citizen.CreateThread(function()
	while true do
		SetAudioFlag('DisableFlightMusic', true)
		Citizen.Wait(0)
	end
end)


local tmp_blips = {
	{
		title="Welcome Center", id=850, colour=0,
		x = -1561.6, y = 2771.57, z = 17.31
	},
	{
		title="Medbay", id=61, colour=0,
		x = -1821.68, y = 3134.95, z = 32.81
	}
}

Citizen.CreateThread(function()
    for _, info in pairs(tmp_blips) do
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
