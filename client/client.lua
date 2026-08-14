if not Config.CarWipe.Enabled then return end

local function isVehicleOccupied(vehicle)
    local seats = GetVehicleMaxNumberOfPassengers(vehicle)

    for seat = -1, seats - 1 do
        if not IsVehicleSeatFree(vehicle, seat) then
            return true
        end
    end

    return false
end

local function requestControl(entity)
    if not NetworkGetEntityIsNetworked(entity) then return true end

    NetworkRequestControlOfEntity(entity)
    local timeout = GetGameTimer() + 1000

    while not NetworkHasControlOfEntity(entity) and GetGameTimer() < timeout do
        Wait(0)
        NetworkRequestControlOfEntity(entity)
    end

    return NetworkHasControlOfEntity(entity)
end

RegisterNetEvent('cfx-zel-carwipe:carwipe:clear', function()
    for _, vehicle in ipairs(GetGamePool('CVehicle')) do
        if DoesEntityExist(vehicle) and not isVehicleOccupied(vehicle) and requestControl(vehicle) then
            SetEntityAsMissionEntity(vehicle, true, true)
            DeleteVehicle(vehicle)

            if DoesEntityExist(vehicle) then
                DeleteEntity(vehicle)
            end
        end
    end
end)

