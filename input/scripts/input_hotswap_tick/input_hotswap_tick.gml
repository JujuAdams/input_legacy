/// @param [playerIndex]

function input_hotswap_tick()
{
    var _player_index = ((argument_count > 0) && (argument[0] != undefined))? argument[0] : 0;
    
    if (_player_index < 0)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " vs. ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    with(global.__input_players[_player_index])
    {
        if ((last_input_time < 0) || (current_time - last_input_time > INPUT_HOTSWAP_DELAY))
        {
            var _new_device = __input_any_new_device_input(_player_index);
            if (_new_device.source != INPUT_SOURCE.NONE)
            {
                input_player_source_set(_new_device.source, _player_index);
                if (_new_device.source == INPUT_SOURCE.GAMEPAD) input_player_gamepad_set(_new_device.gamepad, _player_index);
            }
        }
    }
}