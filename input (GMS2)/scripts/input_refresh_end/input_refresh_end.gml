/// @param repeat_delay
/// @param longpress_delay
/// @param doubletap_delay

var _repeat_delay    = argument0;
var _longpress_delay = argument1;
var _doubletap_delay = argument2;

for( var _p = 0; _p < input_max_players; _p++ )
{
    var _i_start = _p*E_INPUT_SLOT.__SIZE
    var _i_end   = _i_start + E_INPUT_SLOT.__SIZE;
    
    for( var _i = _i_start; _i < _i_end; _i++ )
    {
        //Clear out our momentary states
    	input_state[ _i, E_INPUT_STATE.PRESSED         ] = false;
    	input_state[ _i, E_INPUT_STATE.RELEASED        ] = false;
    	input_state[ _i, E_INPUT_STATE.REPEATED        ] = false;
    	input_state[ _i, E_INPUT_STATE.LONG            ] = false;
    	input_state[ _i, E_INPUT_STATE.DOUBLE_PRESSED  ] = false;
    	input_state[ _i, E_INPUT_STATE.DOUBLE_RELEASED ] = false;
        
        if ( input_state[ _i, E_INPUT_STATE.NEW_ON ] )
        {
            //If this input is ON this frame...
            
        	if ( input_state[ _i, E_INPUT_STATE.ON ] )
            {
                //...and the input was ON last frame too...
                
        		if ( current_time - input_state[ _i, E_INPUT_STATE.REPEAT_TIME ] >= _repeat_delay )
                {
                    //...then trigger the REPEATED state if we've been holding the button for long enough
        			input_state[ _i, E_INPUT_STATE.REPEATED ] = true;
        			input_state[ _i, E_INPUT_STATE.REPEAT_TIME ] = current_time;
        		}
                
                //Update the LONG state based on the time since we set the input to PRESSED and now
        		input_state[ _i, E_INPUT_STATE.LONG ] = ( current_time - input_state[ _i, E_INPUT_STATE.PRESSED_TIME ] >= _longpress_delay );
        	}
            else
            {
                //...and the input was OFF last frame then we've switched on the input slot
        		input_state[ _i, E_INPUT_STATE.PRESSED ] = true;
        		input_state[ _i, E_INPUT_STATE.REPEATED ] = true;
		        
        		if ( input_state[ _i, E_INPUT_STATE.PRESSED_INDEX ] == input_state[ _i, E_INPUT_STATE.NEW_PRESSED_INDEX ] )
                {
                    //If we've pressed the same button as we did last time the button was pressed, check to see if this counts as a double tap
                    if ( current_time - input_state[ _i, E_INPUT_STATE.PRESSED_TIME ] <= _doubletap_delay )
                    {
            			input_state[ _i, E_INPUT_STATE.DOUBLE_PRESSED ] = true;
            			input_state[ _i, E_INPUT_STATE.DOUBLE_ON      ] = true;
                    }
        		}
                else
                {
                    //If we've pressed a different button than we did last time the button was pressed, update our input state
        			input_state[ _i, E_INPUT_STATE.PRESSED_INDEX ] = input_state[ _i, E_INPUT_STATE.NEW_PRESSED_INDEX ];
        		}
                
                //Set some timers to record when we first switched on this input slot
        		input_state[ _i, E_INPUT_STATE.PRESSED_TIME ] = current_time;
        		input_state[ _i, E_INPUT_STATE.REPEAT_TIME  ] = current_time;
        	}
        }
        else
        {
            //If this input is OFF this frame...
            
        	if ( input_state[ _i, E_INPUT_STATE.ON ] )
            {
                //...and we were ON the last frame, the input has been RELEASED
                input_state[ _i, E_INPUT_STATE.RELEASED ] = true;
            }
            
            if ( input_state[ _i, E_INPUT_STATE.DOUBLE_ON ] )
            {
                //If the input had been double-tapped, then turn that off too
                input_state[ _i, E_INPUT_STATE.DOUBLE_ON       ] = false;
                input_state[ _i, E_INPUT_STATE.DOUBLE_RELEASED ] = true;
            }
        }
        
        //Update the ON state for input checking, and for comparison next frame
        input_state[ _i, E_INPUT_STATE.ON ] = input_state[ _i, E_INPUT_STATE.NEW_ON ];
    }
}