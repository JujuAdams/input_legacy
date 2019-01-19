// This script clears the momentary state for each input slot
// The "input_handle_*" functions modify these values

for( var _p = 0; _p < input_max_players; _p++ )
{
    var _offset = _p*E_INPUT_SLOT.__SIZE;
    
    for( var _i = 0; _i < E_INPUT_SLOT.__SIZE; _i++ )
    {
    	input_state[ _offset + _i, E_INPUT_STATE.NEW_ON            ] = false;
    	input_state[ _offset + _i, E_INPUT_STATE.NEW_PRESSED_INDEX ] = undefined;
    	input_state[ _offset + _i, E_INPUT_STATE.ANALOGUE          ] = 0;
    }
}