/// @param playerIndex
/// @param device

var _player = argument0;
var _device = argument1;

if ((_player < 0) || (_player >= global.__input_max_players))
{
    show_error("Input:\nPlayer index (" + string(_player) + ") is invalid (range is 0 to " + string(global.__input_max_players-1) + ")\n ", false);
    exit;
}

var _player_array = global.__input_players_array[_player];
_player_array[@ INPUT_PLAYER.DEVICE] = _device;