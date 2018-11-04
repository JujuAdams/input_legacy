if ( async_load[? "event_type" ] = "gamepad discovered" )
{
    //If a new controller has been connected...
    var _slot = async_load[? "pad_index" ];
    
    if ( gamepad_device < 0 )
    {
        //If we're not already set a gamepad, don't bother showing the confirmation dialogue
        gamepad_device = _slot;
        input_clear(); //Always clear your input states when changing controllers
    }
    else if ( show_question( "A new gamepad in slot " + string( _slot ) + " has been found.\n\nWould you like to swap to it?" ) )
    {
        //If the user has confirmed they want to change slot, do so!
        gamepad_device = _slot;
        input_clear(); //Always clear your input states when changing controllers
    }
}