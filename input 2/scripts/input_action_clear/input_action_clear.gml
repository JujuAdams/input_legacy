/// @param playerIndex
/// @param action

var _player = argument0;
var _action = argument1;

var _action_index = global.__input_actions_map[? _action];

var _player_array = global.__input_players_array[_player];
var _actions_array = _player_array[INPUT_PLAYER.ACTIONS];
var _action_array = array_create(INPUT_ACTION.__SIZE);
_actions_array[@ _action_index] = _action_array;

_action_array[@ INPUT_ACTION.NAME           ] = _action;
_action_array[@ INPUT_ACTION.BINDINGS       ] = [];
_action_array[@ INPUT_ACTION.VALUE          ] = 0.0;

_action_array[@ INPUT_ACTION.PRESSED        ] = false;
_action_array[@ INPUT_ACTION.DOWN           ] = false;
_action_array[@ INPUT_ACTION.RELEASED       ] = false;

_action_array[@ INPUT_ACTION.REPEATED       ] = false;
_action_array[@ INPUT_ACTION.LONG           ] = false;

_action_array[@ INPUT_ACTION.DOUBLE_PRESSED ] = false;
_action_array[@ INPUT_ACTION.DOUBLE_DOWN    ] = false;
_action_array[@ INPUT_ACTION.DOUBLE_RELEASED] = false;

_action_array[@ INPUT_ACTION.PRESSED_TIME   ] = current_time;
_action_array[@ INPUT_ACTION.PRESSED_INDEX  ] = -1;
_action_array[@ INPUT_ACTION.DOWN_TYPE      ] = INPUT_BINDING_NOT_SET;
_action_array[@ INPUT_ACTION.REPEAT_TIME    ] = current_time;

return _action_array;