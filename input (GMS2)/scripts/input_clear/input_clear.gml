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

for( var _p = 0; _p < input_max_players; _p++ )
{
    var _offset = _p*E_INPUT_SLOT.__SIZE;
    
    for( var _y = E_INPUT_STATE.__SIZE-1; _y >= 0; _y-- )
    {
    	for( var _x = E_INPUT_SLOT.__SIZE-1; _x >= 0; _x-- )
        {
    		input_state[ _offset + _x, _y ] = false;
    	}
    }
}