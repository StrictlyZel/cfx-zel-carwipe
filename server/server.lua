if not Config.CarWipe.Enabled then return end

local ESX = exports['es_extended']:getSharedObject()
local wipeInProgress = false

local function cityTowMessage(message)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div><span style="color: #ef4444; font-weight: 600;">[City Tow]:</span> <span style="color: #ffffff;">{0}</span></div>',
        args = { message }
    })
end

local function commandFeedback(source, message)
    if source == 0 then
        print(('[City Tow] %s'):format(message))
        return
    end

    TriggerClientEvent('chat:addMessage', source, {
        args = { '^1[City Tow]:', ('^7%s'):format(message) }
    })
end

local function startCarWipe(source)
    if wipeInProgress then
        if source then
            commandFeedback(source, 'A vehicle wipe is already in progress.')
        end
        return false
    end

    wipeInProgress = true

    local countdown = math.max(30, tonumber(Config.CarWipe.CountdownSeconds) or 60)
    cityTowMessage(
        ('City services will begin clearing unattended vehicles in %d minute%s. Stay inside your vehicle to prevent it from being removed.')
            :format(math.floor(countdown / 60), countdown >= 120 and 's' or '')
    )

    SetTimeout((countdown - 30) * 1000, function()
        cityTowMessage('City services will begin clearing unattended vehicles in 30 seconds. Stay inside your vehicle to prevent it from being removed.')
    end)

    SetTimeout(countdown * 1000, function()
        TriggerClientEvent('cfx-zel-carwipe:carwipe:clear', -1)

        SetTimeout(3000, function()
            cityTowMessage('City tow completed. Thank you for your cooperation.')
            wipeInProgress = false
        end)
    end)
    
    return true
end

ESX.RegisterCommand(Config.CarWipe.Command, Config.CarWipe.Groups, function(xPlayer)
    startCarWipe(xPlayer and xPlayer.source or 0)
end, true)

CreateThread(function()
    local schedule = Config.CarWipe.Schedule
    if not schedule or not schedule.Enabled then return end

    local intervalMinutes = math.max(1, tonumber(schedule.IntervalMinutes) or 30)
    local intervalMilliseconds = intervalMinutes * 60 * 1000

    while true do
        Wait(intervalMilliseconds)
        startCarWipe()
    end
end)
