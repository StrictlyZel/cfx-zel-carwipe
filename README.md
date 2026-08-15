# cfx-zel-carwipe

A lightweight, configurable vehicle wipe resource for ESX-based FiveM servers.

The resource lets authorized staff start a vehicle wipe with a command and can also run wipes automatically on a configurable interval. Players receive countdown notifications before unattended vehicles are removed. Occupied vehicles are not deleted.

## Features

- ESX staff command with configurable permission groups
- Optional automatic vehicle wipes
- Configurable countdown and schedule interval
- 30-second warning before each wipe
- City Tow notifications in chat
- Protection for occupied vehicles
- Network control handling before vehicle deletion

## Preview

![Car wipe preview](https://i.imgur.com/crBom98.png)

## Requirements

- [FiveM](https://fivem.net/)
- [ESX Legacy](https://github.com/esx-framework/esx_core)
- The default FiveM `chat` resource for notifications

## Installation

1. Download or clone this repository into your server's `resources` directory.
2. Keep the resource folder named `cfx-zel-carwipe`.
3. Add the following line to your `server.cfg` after `es_extended` and `chat`:

   ```cfg
   ensure cfx-zel-carwipe
   ```

4. Edit `config.lua` to match your server's permissions and preferred schedule.
5. Restart the server or start the resource from the server console.

## Configuration

```lua
Config.CarWipe = {
    Enabled = true,

    Command = 'carwipe',
    Groups = { 'admin', 'senioradmin', 'developer', 'management', 'leadadmin' },
    CountdownSeconds = 60,

    Schedule = {
        Enabled = true,
        IntervalMinutes = 60,
    },
}
```

| Option | Description |
| --- | --- |
| `Enabled` | Enables or disables the entire resource logic. |
| `Command` | Sets the staff command name. |
| `Groups` | Lists the ESX groups allowed to use the command. |
| `CountdownSeconds` | Sets the delay before vehicles are removed. The script enforces a minimum of 30 seconds. |
| `Schedule.Enabled` | Enables or disables automatic wipes while leaving the staff command available. |
| `Schedule.IntervalMinutes` | Sets how often an automatic wipe begins. |

## Usage

Authorized staff can start a wipe with:

```text
/carwipe
```

The command name can be changed with `Config.CarWipe.Command`.

When a wipe starts, all players receive a warning. A second warning appears when 30 seconds remain, and unattended vehicles are removed when the countdown ends. Players should remain inside their vehicles to prevent them from being deleted.

The command can also be run from the server console.

## Notes

- Automatic schedule intervals begin when the resource starts or restarts.
- A new wipe cannot begin while another wipe is already in progress.
- Only vehicles with no occupants are targeted.

## License

This project is released under the [MIT License](LICENSE).

You are free to use, copy, modify, and distribute this software, provided that the original copyright notice and license are included in copies or substantial portions of the project.

Copyright © 2026 Zel.

## Author

Created by **Zel**.
