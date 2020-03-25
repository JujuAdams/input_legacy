/// @param string
/// @param playerIndex
/// @param expectedVersion

var _string           = argument0;
var _player           = argument1;
var _expected_version = argument2;

var _json        = json_decode(_string);
var _format      = _json[? "format" ];
var _version     = _json[? "version"];
var _player_list = _json[? "player" ];

if (_format != "Input 2 Player Profile")
{
    ds_map_destroy(_json);
    return false;
}

if (_version != _expected_version)
{
    return false;
}

var _player_array = global.__input_players_array[_player];

var _actions_list  = _player_list[| INPUT_PLAYER.ACTIONS];
var _actions_array = _player_array[INPUT_PLAYER.ACTIONS];

var _a = 0;
repeat(ds_list_size(_actions_list))
{
    var _action_list   = _actions_list[| _a];
    var _bindings_list = _action_list[| INPUT_ACTION.BINDINGS];
    
    var _action_array   = _actions_array[_a];
    var _bindings_array = [];
    _action_array[@ INPUT_ACTION.BINDINGS] = _bindings_array;
    
    var _b = 0;
    repeat(ds_list_size(_bindings_list))
    {
        var _binding_list  = _bindings_list[| _b];
        var _binding_array = array_create(INPUT_BINDING.__SIZE);
        
        _binding_array[@ INPUT_BINDING.BINDING     ] = _binding_list[| INPUT_BINDING.BINDING     ];
        _binding_array[@ INPUT_BINDING.BINDING_TYPE] = _binding_list[| INPUT_BINDING.BINDING_TYPE];
        _binding_array[@ INPUT_BINDING.DEADZONE_MIN] = _binding_list[| INPUT_BINDING.DEADZONE_MIN];
        _binding_array[@ INPUT_BINDING.DEADZONE_MAX] = _binding_list[| INPUT_BINDING.DEADZONE_MAX];
        _binding_array[@ INPUT_BINDING.SENSITIVITY ] = _binding_list[| INPUT_BINDING.SENSITIVITY ];
        
        _bindings_array[@ _b] = _binding_array;
        
        ++_b;
    }
    
    ++_a;
}

ds_map_destroy(_json);
return _player_array;