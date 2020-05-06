/// @function					input_check(player, inputSlot);
/// @param {int}				player
/// @param {int}				inputSlot
/// @description				Checks if an input slot is currently ON, i.e. an input button is held down
function input_check(player, inputSlot)
{
	return obj_input.input_state[ player * E_INPUT_SLOT.__SIZE + inputSlot][E_INPUT_STATE.ON ];
}

/// @function					input_check_analogue(player, inputSlot);
/// @param {int}				player
/// @param {int}				inputSlot
/// @description				Checks the analogue value of an input
function input_check_analogue(player, inputSlot)
{
	return obj_input.input_state[ player * E_INPUT_SLOT.__SIZE + inputSlot][E_INPUT_STATE.ANALOGUE ];
}

/// @function					input_check_double(player, inputSlot);
/// @param {int}				player
/// @param {int}				inputSlot
/// @description				Checks if an input slot has been double-tapped
function input_check_double(player, inputSlot)
{
	return obj_input.input_state[ player * E_INPUT_SLOT.__SIZE + inputSlot][E_INPUT_STATE.DOUBLE_ON ];
}

/// @function					input_check_double_pressed(player, inputSlot);
/// @param {int}				player
/// @param {int}				inputSlot
/// @description				Checks if an input slot has been newly double-tapped this frame
function input_check_double_pressed(player, inputSlot)
{
	return obj_input.input_state[ player * E_INPUT_SLOT.__SIZE + inputSlot][E_INPUT_STATE.DOUBLE_PRESSED ];
}

/// @function					input_check_double_released(player, inputSlot);
/// @param {int}				player
/// @param {int}				inputSlot
/// @description				Checks if a doubel-tapped input slot has been newly deactivated this frame
function input_check_double_released(player, inputSlot)
{
	return obj_input.input_state[ player * E_INPUT_SLOT.__SIZE + inputSlot][E_INPUT_STATE.DOUBLE_RELEASED ];
}

/// @function					input_check_long(player, inputSlot);
/// @param {int}				player
/// @param {int}				inputSlot
/// @description				Checks if an input slot has been held down for a long period of time
function input_check_long(player, inputSlot)
{
	return obj_input.input_state[ player * E_INPUT_SLOT.__SIZE + inputSlot][E_INPUT_STATE.LONG ];
}

/// @function					input_check_pressed(player, inputSlot);
/// @param {int}				player
/// @param {int}				inputSlot
/// @description				Checks if an input slot has been newly activated this frame
function input_check_pressed(player, inputSlot)
{
	return obj_input.input_state[ player * E_INPUT_SLOT.__SIZE + inputSlot][E_INPUT_STATE.PRESSED ];
}

/// @function					input_check_released(player, inputSlot);
/// @param {int}				player
/// @param {int}				inputSlot
/// @description				Checks if an input slot has been newly deactivated this frame
function input_check_released(player, inputSlot)
{
	return obj_input.input_state[ player * E_INPUT_SLOT.__SIZE + inputSlot][E_INPUT_STATE.RELEASED ];
}

/// @function					input_check_repeated(player, inputSlot);
/// @param {int}				player
/// @param {int}				inputSlot
/// @description				Checks if an input slot is firing a REPEAT state for long presses
function input_check_repeated(player, inputSlot)
{
	return obj_input.input_state[ player * E_INPUT_SLOT.__SIZE + inputSlot][E_INPUT_STATE.REPEATED ];
}

/// @function					input_device_kind(player, inputSlot);
/// @param {int}				player
/// @param {int}				inputSlot
/// @description				Returns what kind of device created this input
function input_device_kind(player, inputSlot)
{
	return obj_input.input_state[ player * E_INPUT_SLOT.__SIZE + inputSlot][E_INPUT_STATE.DEVICE_KIND ];
}

/// @function					input_is_analogue(player, inputSlot);
/// @param {int}				player
/// @param {int}				inputSlot
/// @param {int}				Optional inputSlot...
function input_is_analogue(player, inputSlot)
{
	for(var _i = 1; _i < argument_count; _i++)
	{
	    if (input_device_kind(player, argument[_i]) == E_INPUT_DEVICE_KIND.GAMEPAD_ANALOGUE) return true;
	}
	return false;
}

/// @function					input_set_max_players(numberOfPlayers);
/// @param {int}				numberOfPlayers		
function input_set_max_players(numberOfPlayers)
{
	obj_input.input_max_players = numberOfPlayers;
}

#region System

#macro __INPUT_VERSION "1.7.2"
#macro __INPUT_DATE    "2020/05/06"
show_debug_message("Input: " + __INPUT_VERSION + " @jujuadams " + __INPUT_DATE);

enum E_INPUT_DEVICE_KIND
{
	UNKNOWN,
	KEYBOARD,
	MOUSE,
	GAMEPAD_BUTTON,
	GAMEPAD_ANALOGUE
}

enum E_INPUT_STATE 
{
	PRESSED, ON, RELEASED,                      //Basic behaviours
	REPEATED, LONG,                             //Extended behaviours
	DOUBLE_PRESSED, DOUBLE_ON, DOUBLE_RELEASED, //Double tap
	PRESSED_TIME, PRESSED_INDEX, REPEAT_TIME,   //Timers
	ANALOGUE,                                   //Get the analog value
	NEW_ON, NEW_PRESSED_INDEX,                  //Momentary states
	DEVICE_KIND,                                //What sort of device took precedence for this input
	__SIZE
}

/// @function					__input_handle_general(player, index, pressed_index, analog_value, device_kind)
function __input_handle_general(player, index, pressed_index, analog_value, device_kind)
{
	var _offset = index + player*E_INPUT_SLOT.__SIZE;

	input_state[ _offset][E_INPUT_STATE.NEW_ON            ] = true;
	input_state[ _offset][E_INPUT_STATE.NEW_PRESSED_INDEX ] = pressed_index;
	input_state[ _offset][E_INPUT_STATE.ANALOGUE          ] = analog_value;
	input_state[ _offset][E_INPUT_STATE.DEVICE_KIND       ] = device_kind;
}

/// @function					input_clear();
function input_clear()
{
	for(var _p = 0; _p < input_max_players; _p++)
	{
	    var _offset = _p*E_INPUT_SLOT.__SIZE;
	    for(var _y = 0; _y < E_INPUT_STATE.__SIZE; _y++)
	    {
	    	for(var _x = 0; _x < E_INPUT_SLOT.__SIZE; _x++)
	        {
	    		input_state[ _offset + _x, _y ] = false;
	    	}
	    }
	}


}

/// @function					input_handle_gamepad_axis(player, inputSlot, device, axis, threshold);
function input_handle_gamepad_axis(player, inputSlot, device, axis, threshold)
{
	if (gamepad_is_connected(device))
	{
	    if (gamepad_axis_value(device, axis) * sign(threshold) > abs(threshold))
	    {
	        __input_handle_general( player,
	                                inputSlot,
	                                axis + 0.1 + device/100,
	                                gamepad_axis_value(device, axis) * sign(threshold),
	                                E_INPUT_DEVICE_KIND.GAMEPAD_ANALOGUE );
	    }
	}
}

/// @function					input_handle_gamepad_button(player, inputSlot, device, button);
function input_handle_gamepad_button(player, inputSlot, device, button)
{
	if (gamepad_is_connected(device))
	{
	    for(var _i = 3; _i < argument_count; _i++)
	    {
	        if (gamepad_button_check(device, argument[_i]))
	        {
	            __input_handle_general( player,
	                                    inputSlot,
	                                    argument[_i] + 0.2 + device/100,
	                                    1,
	                                    E_INPUT_DEVICE_KIND.GAMEPAD_BUTTON );
	        }
	    }
	}
}

/// @function					input_handle_keyboard(player, inputSlot, keyboardButton);
function input_handle_keyboard(player, inputSlot, keyboardButton)
{
	for(var _i = 2; _i < argument_count; _i++)
	{
	    if (keyboard_check(argument[_i])) __input_handle_general( player,
	                                                              inputSlot,
	                                                              argument[_i],
	                                                              1,
	                                                              E_INPUT_DEVICE_KIND.KEYBOARD );
	}
}

/// @function					input_handle_mouse(player, inputSlot, button, device);
function input_handle_mouse(player, inputSlot, button, device)
{
	if (device == undefined) { device = 0; }

	if (device_mouse_check_button(device, button))
	{
	    __input_handle_general( player,
	                            inputSlot,
	                            button + 0.3 + device/100,
	                            1,
	                            E_INPUT_DEVICE_KIND.MOUSE );
	}
}

/// @function					input_refresh_begin();
/// @description				This script clears the momentary state for each input slot
/// @description				The "input_handle_*" functions modify these values
function input_refresh_begin()
{
	for(var _p = 0; _p < input_max_players; _p++)
	{
	    var _offset = _p*E_INPUT_SLOT.__SIZE;
    
	    for(var _i = 0; _i < E_INPUT_SLOT.__SIZE; _i++)
	    {
	    	input_state[ _offset + _i, E_INPUT_STATE.NEW_ON            ] = false;
	    	input_state[ _offset + _i, E_INPUT_STATE.NEW_PRESSED_INDEX ] = undefined;
	    	input_state[ _offset + _i, E_INPUT_STATE.ANALOGUE          ] = 0;
	    }
	}
}


function input_refresh_end(repeatDelay, longpressDelay, doubletapDelay)
{
	for(var _p = 0; _p < input_max_players; _p++)
	{
	    var _i_start = _p*E_INPUT_SLOT.__SIZE
	    var _i_end   = _i_start + E_INPUT_SLOT.__SIZE;
    
	    for(var _i = _i_start; _i < _i_end; _i++)
	    {
	        //Clear out our momentary states
	    	input_state[ _i][E_INPUT_STATE.PRESSED         ] = false;
	    	input_state[ _i][E_INPUT_STATE.RELEASED        ] = false;
	    	input_state[ _i][E_INPUT_STATE.REPEATED        ] = false;
	    	input_state[ _i][E_INPUT_STATE.LONG            ] = false;
	    	input_state[ _i][E_INPUT_STATE.DOUBLE_PRESSED  ] = false;
	    	input_state[ _i][E_INPUT_STATE.DOUBLE_RELEASED ] = false;
        
	        if (input_state[ _i][E_INPUT_STATE.NEW_ON ])
	        {
	            //If this input is ON this frame...
            
	        	if (input_state[ _i][E_INPUT_STATE.ON ])
	            {
	                //...and the input was ON last frame too...
                
	        		if (current_time - input_state[ _i][E_INPUT_STATE.REPEAT_TIME ] >= repeatDelay)
	                {
	                    //...then trigger the REPEATED state if we've been holding the button for long enough
	        			input_state[ _i][E_INPUT_STATE.REPEATED    ] = true;
	        			input_state[ _i][E_INPUT_STATE.REPEAT_TIME ] = current_time;
	        		}
                
	                //Update the LONG state based on the time since we set the input to PRESSED and now
	        		input_state[ _i][E_INPUT_STATE.LONG ] = (current_time - input_state[ _i][E_INPUT_STATE.PRESSED_TIME ] >= longpressDelay);
	        	}
	            else
	            {
	                //...and the input was OFF last frame then we've switched on the input slot
	        		input_state[ _i][E_INPUT_STATE.PRESSED  ] = true;
	        		input_state[ _i][E_INPUT_STATE.REPEATED ] = true;
		        
	        		if (input_state[ _i][E_INPUT_STATE.PRESSED_INDEX ] == input_state[ _i][E_INPUT_STATE.NEW_PRESSED_INDEX ])
	                {
	                    //If we've pressed the same button as we did last time the button was pressed, check to see if this counts as a double tap
	                    if (current_time - input_state[ _i][E_INPUT_STATE.PRESSED_TIME ] <= doubletapDelay)
	                    {
	            			input_state[ _i][E_INPUT_STATE.DOUBLE_PRESSED ] = true;
	            			input_state[ _i][E_INPUT_STATE.DOUBLE_ON      ] = true;
	                    }
	        		}
	                else
	                {
	                    //If we've pressed a different button than we did last time the button was pressed, update our input state
	        			input_state[ _i][E_INPUT_STATE.PRESSED_INDEX ] = input_state[ _i][E_INPUT_STATE.NEW_PRESSED_INDEX ];
	        		}
                
	                //Set some timers to record when we first switched on this input slot
	        		input_state[ _i][E_INPUT_STATE.PRESSED_TIME ] = current_time;
	        		input_state[ _i][E_INPUT_STATE.REPEAT_TIME  ] = current_time;
	        	}
	        }
	        else
	        {
	            //If this input is OFF this frame...
            
	        	if (input_state[ _i][E_INPUT_STATE.ON ])
	            {
	                //...and we were ON the last frame, the input has been RELEASED
	                input_state[ _i][E_INPUT_STATE.RELEASED ] = true;
	            }
            
	            if (input_state[ _i][E_INPUT_STATE.DOUBLE_ON ])
	            {
	                //If the input had been double-tapped, then turn that off too
	                input_state[ _i][E_INPUT_STATE.DOUBLE_ON       ] = false;
	                input_state[ _i][E_INPUT_STATE.DOUBLE_RELEASED ] = true;
	            }
	        }
        
	        //Update the ON state for input checking, and for comparison next frame
	        input_state[ _i][E_INPUT_STATE.ON ] = input_state[ _i][E_INPUT_STATE.NEW_ON ];
	    }
	}
}

#endregion