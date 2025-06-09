config = {
    a_players_over_0 = { -- This will by checked first since keys are sorted and trigger if the playercount on the server is over 0
        VehicleDensityMultiplier = 0, -- 0.00 - 1.00
        ParkedVehicleDensityMultiplier = 0, -- 0.00 - 1.00
        PedDensityMultiplier = 0, -- 0.00 - 1.00
        ScenarioPedDensityMultiplier = 0, -- 0.00 - 1.00
        DisabledDispatchServices = { -- Which dispatch services to disable
            PoliceAutomobile = true,
            PoliceAutomobileWaitPulledOver = true,
            PoliceAutomobileWaitCruising = true,
            PoliceRoadBlock = true,
            PoliceRiders = true,
            PoliceVehicleRequest = true,
            PoliceHelicopter = true,
            PoliceBoat = true,
            SwatAutomobile = true,
            SwatHelicopter = true,
            ArmyVehicle = true,
            FireDepartment = true,
            AmbulanceDepartment = true,
            Gangs = true,
            BikerBackup = true
        },
        DisableCops = true -- Wether cops will chase the player or not
    }
}
