/// @param playerIndex
/// @param clearData

var _player     = argument0;
var _clear_data = argument1;

if ((_player < 0) || (_player >= global.__input_max_players))
{
    show_error("Input:\nPlayer index (" + string(_player) + ") is invalid (range is 0 to " + string(global.__input_max_players-1) + ")\n ", false);
    return undefined;
}

if (_player >= array_length_1d(global.__input_players_array))
{
    var _player_array = array_create(INPUT_PLAYER.__SIZE);
    global.__input_players_array[@ _player] = _player_array;
    
    _player_array[@ INPUT_PLAYER.DATA] = [];
}
else
{
    var _player_array = global.__input_players_array[_player];
    if (_clear_data) _player_array[@ INPUT_PLAYER.DATA] = [];
}

_player_array[@ INPUT_PLAYER.DEVICE          ] = INPUT_DEVICE_NONE;
_player_array[@ INPUT_PLAYER.DEVICE_CONNECTED] = false;
_player_array[@ INPUT_PLAYER.ACTIONS         ] = [];

var _action = ds_map_find_first(global.__input_actions_map);
repeat(ds_map_size(global.__input_actions_map))
{
    input_action_clear(_player, _action);
    _action = ds_map_find_next(global.__input_actions_map, _action);
}

return _player_array;