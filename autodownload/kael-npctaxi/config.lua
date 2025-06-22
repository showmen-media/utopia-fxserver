Config = {
    Debug = false,
    Core = 'qb-core',
    Target = 'qb-target',
}

Config.VIP = {
    Enable = false,
    DiscordRoleID = "1035785646083678208",
    Command = "calltaxi",
}

-- Config.DriverModel = "csb_prologuedriver"
Config.DriverModel = "s_m_y_marine_01"
Config.TaxiModel = "crusader"
Config.TaxiSpeed = 60.0
Config.DrivingStyle = 319
-- Config.DrivingStyle = 262462 -- Don't Change If you don't know.
Config.AutoDesapwnAfter = 30 -- min
Config.Cost = 0 -- per milisecound

Config.StandBlip = {
    Enable = false,
    Color = 60,
    Icon = 198,
    Size = 0.5,
    Text = "Taxi Stand",
}
Config.BoothModel = "prop_phonebox_04"
Config.TaxiStands = {}

Config.VehKeyExports = function(veh, plate, model)
    -- Set your own vehicle keys export here..
    TriggerEvent("vehiclekeys:client:SetOwner", plate)
    -- Set your own vehicle keys export here..
end




