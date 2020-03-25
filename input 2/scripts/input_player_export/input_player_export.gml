/// @param playerIndex
/// @param version

var _player  = argument0;
var _version = argument1;

var _player_array = global.__input_players_array[_player];

var _map = ds_map_create();
_map[? "format" ] = "Input 2 Player Profile";
_map[? "version"] = _version;
_map[? "player" ] = _player_array;
var _string = json_encode(_map);
ds_map_destroy(_map);

return _string;