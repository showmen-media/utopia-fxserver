
-- Disable cinematographic sound that plays when you are on an airplane
Citizen.CreateThread(function()
	while true do
		SetAudioFlag('DisableFlightMusic', true)
		Citizen.Wait(0)
	end
end)
