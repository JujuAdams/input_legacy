/// @param source
/// @param [playerIndex]

function input_player_source_set()
{
    var _source       = argument[0];
    var _player_index = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : 0;
    
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
    
    if (INPUT_NO_SEPARATE_KEYBOARD_AND_MOUSE && ((_source == INPUT_SOURCE.KEYBOARD) || (_source == INPUT_SOURCE.MOUSE)))
    {
        __input_error("INPUT_SOURCE.KEYBOARD and INPUT_SOURCE.MOUSE have been disabled\n(Set INPUT_NO_SEPARATE_KEYBOARD_AND_MOUSE to <false> to enable them)\n");
        return undefined;
    }
    
    global.__input_players[_player_index].source = _source;
}