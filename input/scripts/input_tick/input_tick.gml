function input_tick()
{
    global.__input_frame++;
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[_p].tick();
        ++_p;
    }
}

#region Initialisation

__input_trace("Welcome to Input by @jujuadams! This is version ", __INPUT_VERSION, ", ", __INPUT_DATE);

global.__input_players        = array_create(INPUT_MAX_PLAYERS, undefined);
global.__input_default_player = new __input_class_player();
global.__input_frame          = 0;
global.__input_valid_sources  = array_create(INPUT_SOURCE.__SIZE, false);
global.__input_valid_sources[@ INPUT_SOURCE.NONE] = true;

var _p = 0;
repeat(INPUT_MAX_PLAYERS)
{
    global.__input_players[@ _p] = new __input_class_player();
    ++_p;
}

#endregion

#region Utility

function __input_class_player() constructor
{
    source  = INPUT_SOURCE.NONE;
    gamepad = INPUT_NO_GAMEPAD;
    sources = array_create(INPUT_SOURCE.__SIZE, undefined);
    verbs   = {};
    last_input_time = -1;
    
    tick = function()
    {
        var _verb_names = variable_struct_get_names(verbs);
        var _v = 0;
        repeat(array_length(_verb_names))
        {
            with(variable_struct_get(verbs, _verb_names[_v]))
            {
                previous_held = held;
                
                held  = false;
                value = 0;
            }
            
            ++_v;
        }
        
        if (source == INPUT_SOURCE.KEYBOARD_AND_MOUSE)
        {
            tick_source(INPUT_SOURCE.KEYBOARD);
            tick_source(INPUT_SOURCE.MOUSE);
        }
        else
        {
            tick_source(source);
        }
        
        var _verb_names = variable_struct_get_names(verbs);
        var _v = 0;
        repeat(array_length(_verb_names))
        {
            with(variable_struct_get(verbs, _verb_names[_v]))
            {
                if (value > 0)
                {
                    held      = true;
                    held_time = INPUT_BUFFERED_REALTIME? current_time : global.__input_frame;
                    
                    other.last_input_time = current_time;
                }
                
                if (previous_held == held)
                {
                    press   = false;
                    release = false;
                }
                else
                {
                    if (held)
                    {
                        press   = true;
                        release = false;
                        
                        press_time = INPUT_BUFFERED_REALTIME? current_time : global.__input_frame;
                    }
                    else
                    {
                        press   = false;
                        release = true;
                        
                        release_time = INPUT_BUFFERED_REALTIME? current_time : global.__input_frame;
                    }
                }
            }
            
            ++_v;
        }
    }
    
    tick_source = function(_source)
    {
        var _source_verb_struct = sources[_source];
        if (is_struct(_source_verb_struct))
        {
            var _verb_names = variable_struct_get_names(_source_verb_struct);
            var _v = 0;
            repeat(array_length(_verb_names))
            {
                var _verb_name = _verb_names[_v];
                var _value = 0;
                
                var _alternate_array = variable_struct_get(_source_verb_struct, _verb_name);
                var _a = 0;
                repeat(array_length(_alternate_array))
                {
                    var _binding = _alternate_array[_a];
                    if (is_struct(_binding))
                    {
                        switch(_binding.type)
                        {
                            case "key":          if (keyboard_check(_binding.value))                _value = 1.0; break;
                            case "gp button":    if (gamepad_button_check(gamepad, _binding.value)) _value = 1.0; break;
                            case "mouse button": if (mouse_check_button(_binding.value))            _value = 1.0; break;
                            case "wheel up":     if (mouse_wheel_up())                              _value = 1.0; break;
                            case "wheel down":   if (mouse_wheel_down())                            _value = 1.0; break;
                            
                            case "gp axis":
                                var _found_value = gamepad_axis_value(gamepad, _binding.value);
                                
                                if (_binding.axis_negative) _found_value = -_found_value;
                                _found_value = (_found_value - INPUT_DEFAULT_MIN_THRESHOLD) / (INPUT_DEFAULT_MAX_THRESHOLD - INPUT_DEFAULT_MIN_THRESHOLD);
                                _found_value = clamp(_found_value, 0.0, 1.0);
                                
                                _value = max(_value, _found_value);
                            break;
                        }
                    }
                    
                    ++_a;
                }
                
                variable_struct_get(verbs, _verb_name).value = _value;
                
                ++_v;
            }
        }
    }
    
    /// @param source
    /// @param verb
    /// @param alternate
    /// @param bindingStruct
    set_binding = function(_source, _verb, _alternate, _binding_struct)
    {
        if ((_source < 0) || (_source >= INPUT_SOURCE.__SIZE))
        {
            __input_error("Invalid source (", _source, ")");
            return undefined;
        }
        
        if (_alternate < 0)
        {
            __input_error("Invalid \"alternate\" argument (", _alternate, ")");
            return undefined;
        }
            
        if (_alternate >= INPUT_MAX_ALTERNATE_BINDINGS)
        {
            __input_error("\"alternate\" argument too large (", _alternate, " vs. ", INPUT_MAX_ALTERNATE_BINDINGS, ")\nIncrease INPUT_MAX_ALTERNATE_BINDINGS for more alternate binding slots");
            return undefined;
        }
        
        var _source_verb_struct = sources[_source];
        if (_source_verb_struct == undefined)
        {
            _source_verb_struct = {};
            sources[@ _source] = _source_verb_struct;
        }
        
        var _verb_alternate_array = variable_struct_get(_source_verb_struct, _verb);
        if (_verb_alternate_array == undefined)
        {
            _verb_alternate_array = array_create(INPUT_MAX_ALTERNATE_BINDINGS, undefined);
            variable_struct_set(_source_verb_struct, _verb, _verb_alternate_array);
        }
        
        _verb_alternate_array[@ _alternate] = _binding_struct;
        
        //Set up a verb container on the player separate from the bindings
        if (!is_struct(variable_struct_get(verbs, _verb)))
        {
            variable_struct_set(verbs, _verb,
                                {
                                    previous_held : false,
                                    
                                    press   : false,
                                    held    : false,
                                    release : false,
                                    value   : 0.0,
                                    
                                    press_time   : -1,
                                    held_time    : -1,
                                    release_time : -1,
                                });
        }
        
        //Tell the system that this particular source is valid
        global.__input_valid_sources[@ _source] = true;
        if ((_source == INPUT_SOURCE.KEYBOARD) || (_source == INPUT_SOURCE.MOUSE)) global.__input_valid_sources[@ INPUT_SOURCE.KEYBOARD_AND_MOUSE] = true;
    }
}

/// @param source
/// @param [gamepad]

function __input_source_is_available()
{
    var _source  = argument[0];
    var _gamepad = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : INPUT_NO_GAMEPAD;
    
    if (!global.__input_valid_sources[_source]) return false;
    
    switch(_source)
    {
        case INPUT_SOURCE.NONE:
            return true;
        break;
        
        case INPUT_SOURCE.GAMEPAD:
            if (_gamepad == INPUT_NO_GAMEPAD) return true;
            
            var _p = 0;
            repeat(INPUT_MAX_PLAYERS)
            {
                if ((global.__input_players[_p].source == INPUT_SOURCE.GAMEPAD) && (global.__input_players[_p].gamepad == _gamepad)) return false;
                ++_p;
            }
        break;
        
        case INPUT_SOURCE.KEYBOARD:
            var _p = 0;
            repeat(INPUT_MAX_PLAYERS)
            {
                var _other_source = global.__input_players[_p].source;
                
                if ((_other_source == INPUT_SOURCE.KEYBOARD)
                ||  (_other_source == INPUT_SOURCE.KEYBOARD_AND_MOUSE))
                {
                    return false;
                }
                
                ++_p;
            }
        break;
        
        case INPUT_SOURCE.MOUSE:
            var _p = 0;
            repeat(INPUT_MAX_PLAYERS)
            {
                var _other_source = global.__input_players[_p].source;
                
                if ((_other_source == INPUT_SOURCE.MOUSE)
                ||  (_other_source == INPUT_SOURCE.KEYBOARD_AND_MOUSE))
                {
                    return false;
                }
                
                ++_p;
            }
        break;
        
        case INPUT_SOURCE.KEYBOARD_AND_MOUSE:
            var _p = 0;
            repeat(INPUT_MAX_PLAYERS)
            {
                var _other_source = global.__input_players[_p].source;
                
                if ((_other_source == INPUT_SOURCE.KEYBOARD)
                ||  (_other_source == INPUT_SOURCE.MOUSE)
                ||  (_other_source == INPUT_SOURCE.KEYBOARD_AND_MOUSE))
                {
                    return false;
                }
                
                ++_p;
            }
        break;
    }
    
    return true;
}

function __input_trace()
{
    var _string = "";
    var _i = 0;
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    show_debug_message("Input: " + _string);
}

function __input_error()
{
    var _string = "";
    var _i = 0;
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    show_error("Input:\n" + _string + "\n ", false);
}

#endregion

#region Internal macros

#macro __INPUT_VERSION "3.0.0"
#macro __INPUT_DATE    "2020-08-09"

enum INPUT_SOURCE
{
    NONE,
    KEYBOARD,
    MOUSE,
    KEYBOARD_AND_MOUSE,
    GAMEPAD,
    __SIZE
}

#macro INPUT_NO_GAMEPAD  -1

#endregion