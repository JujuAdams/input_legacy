var _mouse_dx = 0;
var _mouse_dy = 0;

if (global.__input_mouse_locked)
{
    var _mouse_x  = window_mouse_get_x();
    var _mouse_y  = window_mouse_get_y();
    
    if (current_time - global.__input_mouse_locked_time > 120)
    {
        var _mouse_dx = _mouse_x - global.__input_mouse_locked_prev_x;
        var _mouse_dy = _mouse_y - global.__input_mouse_locked_prev_y;
    }
    
    global.__input_mouse_locked_prev_x = _mouse_x;
    global.__input_mouse_locked_prev_y = _mouse_y;
    
    window_mouse_set(window_get_width()/2, window_get_height()/2);
}

var _p = 0;
repeat(global.__input_max_players)
{
    var _player_array = global.__input_players_array[_p];
    
    //Grab the player's device
    var _device = _player_array[INPUT_PLAYER.DEVICE];
    var _device_connected = false;
    if ((_device == INPUT_DEVICE_KEYBOARD) || (_device == INPUT_DEVICE_REMOTE))
    {
        _device_connected = true;
    }
    else
    {
        _device_connected = gamepad_is_connected(_device);
    }
    
    _player_array[@ INPUT_PLAYER.DEVICE_CONNECTED] = _device_connected;
    
    //Process all actions
    var _actions_array = _player_array[INPUT_PLAYER.ACTIONS];
    var _a = 0;
    repeat(global.__input_actions)
    {
        var _action_array = _actions_array[_a];
        var _bindings_array = _action_array[INPUT_ACTION.BINDINGS];
        
        var _down_index    = -1;
        var _down_type     = INPUT_BINDING_NOT_SET;
        var _current_down  = false;
        var _current_value = 0.0;
        
        #region Find the current state of this action
        
        var _b = 0;
        repeat(array_length_1d(_bindings_array))
        {
            var _binding_array = _bindings_array[_b];
            if (!is_array(_binding_array))
            {
                ++_b;
                continue;
            }
            
            var _binding      = _binding_array[INPUT_BINDING.BINDING     ];
            var _binding_type = _binding_array[INPUT_BINDING.BINDING_TYPE];
            
            if (_device == INPUT_DEVICE_KEYBOARD)
            {
                switch(_binding_type)
                {
                    case INPUT_BINDING_KEYBOARD:
                        if (keyboard_check(_binding))
                        {
                            _current_down  = true;
                            _current_value = max(_current_value, 1.0);
                        }
                    break;
                    
                    case INPUT_BINDING_MOUSE_BUTTON:
                        if (mouse_check_button(_binding))
                        {
                            _current_down  = true;
                            _current_value = max(_current_value, 1.0);
                        }
                    break;
                    
                    case INPUT_BINDING_MOUSE_DX:
                        _current_value = max(_current_value, _mouse_dx);
                        if (_current_value > _deadzone_min) _current_down = true;
                    break;
                    
                    case INPUT_BINDING_MOUSE_DY:
                        _current_value = max(_current_value, _mouse_dy);
                        if (_current_value > _deadzone_min) _current_down = true;
                    break;
                    
                    case INPUT_BINDING_MOUSE_WHEEL_UP:
                        if (mouse_wheel_up())
                        {
                            _current_down  = true;
                            _current_value = max(_current_value, 1.0);
                        }
                    break;
                    
                    case INPUT_BINDING_MOUSE_WHEEL_DOWN:
                        if (mouse_wheel_down())
                        {
                            _current_down  = true;
                            _current_value = max(_current_value, 1.0);
                        }
                    break;
                }
            }
            else if ((_device >= 0) && _device_connected)
            {
                switch(_binding_type)
                {
                    case INPUT_BINDING_GAMEPAD_BUTTON:
                        if (gamepad_button_check(_device, _binding))
                        {
                            _current_down  = true;
                            _current_value = max(_current_value, 1.0);
                        }
                    break;
                    
                    case INPUT_BINDING_GAMEPAD_AXIS:
                        var _deadzone_min = _binding_array[INPUT_BINDING.DEADZONE_MIN];
                        var _deadzone_max = _binding_array[INPUT_BINDING.DEADZONE_MAX];
                        
                        var _axis_value = gamepad_axis_value(_device, _binding);
                        _axis_value = clamp((_axis_value - _deadzone_min) / (_deadzone_max - _deadzone_min), 0.0, 1.0);
                        _current_value = max(_current_value, _axis_value);
                        
                        if (_axis_value > 0.0) _current_down  = true;
                    break;
                }
            }
            
            if (_current_down)
            {
                _down_index = _b;
                _down_type  = _binding_type;
            }
            
            ++_b;
        }
        
        #endregion
        
        //Clear out our momentary states
        _action_array[@ INPUT_ACTION.PRESSED        ] = false;
        _action_array[@ INPUT_ACTION.RELEASED       ] = false;
        _action_array[@ INPUT_ACTION.REPEATED       ] = false;
        _action_array[@ INPUT_ACTION.LONG           ] = false;
        _action_array[@ INPUT_ACTION.DOUBLE_PRESSED ] = false;
        _action_array[@ INPUT_ACTION.DOUBLE_RELEASED] = false;
        
        if (_current_down)
        {
            //If this input is ON this frame...
            
            if (_action_array[INPUT_ACTION.DOWN])
            {
                //...and the input was ON last frame too...
                if ((current_time - _action_array[INPUT_ACTION.REPEAT_TIME]) >= lerp(INPUT_REPEAT_DELAY_SLOW, INPUT_REPEAT_DELAY_FAST, clamp((current_time - _action_array[INPUT_ACTION.PRESSED_TIME]) / INPUT_REPEAT_FAST_TIME, 0.0, 1.0)))
                {
                    //...then trigger the REPEATED state if we've been holding the button for long enough
                    _action_array[@ INPUT_ACTION.REPEATED   ] = true;
                    _action_array[@ INPUT_ACTION.REPEAT_TIME] = current_time;
                }
                
                //Update the LONG state based on the time since we set the input to PRESSED and now
                _action_array[@ INPUT_ACTION.LONG] = (current_time - _action_array[INPUT_ACTION.PRESSED_TIME] >= INPUT_LONG_DELAY);
            }
            else
            {
                //...and the input was OFF last frame then we've switched on the input slot
                _action_array[@ INPUT_ACTION.PRESSED ] = true;
                _action_array[@ INPUT_ACTION.REPEATED] = true;
                
                if (_action_array[INPUT_ACTION.PRESSED_INDEX] == _down_index)
                {
                    //If we've pressed the same button as we did last time the button was pressed, check to see if this counts as a double tap
                    if (current_time - _action_array[INPUT_ACTION.PRESSED_TIME] <= INPUT_DOUBLE_DELAY)
                    {
                        _action_array[@ INPUT_ACTION.DOUBLE_PRESSED] = true;
                        _action_array[@ INPUT_ACTION.DOUBLE_DOWN   ] = true;
                    }
                }
                else
                {
                    //If we've pressed a different button than we did last time the button was pressed, update our input state
                    _action_array[@ INPUT_ACTION.PRESSED_INDEX] = _down_index;
                }
                
                //Set some timers to record when we first switched on this input slot
                _action_array[@ INPUT_ACTION.PRESSED_TIME] = current_time;
                _action_array[@ INPUT_ACTION.REPEAT_TIME ] = current_time;
            }
        }
        else
        {
            //If this input is OFF this frame...
            if (_action_array[INPUT_ACTION.DOWN])
            {
                //...and we were ON the last frame, the input has been RELEASED
                _action_array[@ INPUT_ACTION.RELEASED] = true;
            }
            
            if (_action_array[INPUT_ACTION.DOUBLE_DOWN])
            {
                //If the input had been double-tapped, then turn that off too
                _action_array[@ INPUT_ACTION.DOUBLE_DOWN    ] = false;
                _action_array[@ INPUT_ACTION.DOUBLE_RELEASED] = true;
            }
        }
        
        _action_array[@ INPUT_ACTION.DOWN     ] = _current_down;
        _action_array[@ INPUT_ACTION.VALUE    ] = _current_value;
        _action_array[@ INPUT_ACTION.DOWN_TYPE] = _down_type;
        
        ++_a;
    }
    
    ++_p;
}