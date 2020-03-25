/// @param maxPlayers

global.__input_max_players = argument0;

global.__input_players             = global.__input_max_players;
global.__input_players_array       = [];
global.__input_actions             = 0;
global.__input_actions_map         = ds_map_create();
global.__input_mouse_locked        = false;
global.__input_mouse_locked_time   = current_time;
global.__input_mouse_locked_prev_x = window_get_width()/2;
global.__input_mouse_locked_prev_y = window_get_height()/2;

var _i = 0;
repeat(global.__input_max_players)
{
    input_player_clear(_i, true);
    ++_i;
}



#macro INPUT_DEVICE_KEYBOARD          -1
#macro INPUT_DEVICE_REMOTE            -2
#macro INPUT_DEVICE_NONE              -3

#macro INPUT_BINDING_NOT_SET           0
#macro INPUT_BINDING_KEYBOARD          1
#macro INPUT_BINDING_MOUSE_BUTTON      2
#macro INPUT_BINDING_MOUSE_DX          3
#macro INPUT_BINDING_MOUSE_DY          4
#macro INPUT_BINDING_MOUSE_WHEEL_UP    5
#macro INPUT_BINDING_MOUSE_WHEEL_DOWN  6
#macro INPUT_BINDING_GAMEPAD_BUTTON    7
#macro INPUT_BINDING_GAMEPAD_AXIS      8

#macro INPUT_REPEAT_DELAY_SLOW   280
#macro INPUT_REPEAT_DELAY_FAST    80
#macro INPUT_REPEAT_FAST_TIME   2000
#macro INPUT_LONG_DELAY          450
#macro INPUT_DOUBLE_DELAY        300

enum INPUT_PLAYER
{
    DATA,
    DEVICE,
    DEVICE_CONNECTED,
    ACTIONS,
    __SIZE
}

enum INPUT_ACTION
{
    NAME,
    BINDINGS,
    VALUE,
    
    PRESSED,
    DOWN,
    RELEASED,
    
    REPEATED,
    LONG,
    
    DOUBLE_PRESSED,
    DOUBLE_DOWN,
    DOUBLE_RELEASED,
    
    PRESSED_TIME,
    PRESSED_INDEX,
    DOWN_TYPE,
    REPEAT_TIME,
    
    __SIZE
}

enum INPUT_BINDING
{
    BINDING,
    BINDING_TYPE,
    DEADZONE_MIN,
    DEADZONE_MAX,
    SENSITIVITY,
    __SIZE
}

#macro __INPUT_DATE    "2020-03-25"
#macro __INPUT_VERSION "2.0.0"