Config.CarWipe = {
    Enabled = true,

    Command = 'carwipe',
    Groups = { 'admin', 'senioradmin', 'developer', 'management', 'leadadmin' },
    CountdownSeconds = 60,

    -- Car Wipe started automatically. Set Enabled to false to
    -- disable scheduled wipes while leaving the staff command available.
    Schedule = {
        Enabled = true,
        IntervalMinutes = 60,
    },
}

