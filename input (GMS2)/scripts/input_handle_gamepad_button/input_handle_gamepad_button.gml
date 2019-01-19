/// @param input_slot
/// @param device
/// @param button
/// @param [button...]

if ( gamepad_is_connected( argument[1] ) )
{
    for( var _i = 2; _i < argument_count; _i++ )
    {
        if ( gamepad_button_check( argument[1], argument[_i] ) )
        {
            __input_handle_general( argument[0],
                                    argument[_i] + 0.2 + argument[1]/100,
                                    1,
                                    E_INPUT_DEVICE_KIND.GAMEPAD_BUTTON );
        }
    }
}