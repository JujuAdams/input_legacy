/// @param player
/// @param input_slot
/// @param device
/// @param button
/// @param [button...]

var _player     = argument[0];
var _input_slot = argument[1];
var _device     = argument[2];

if ( gamepad_is_connected( _device ) )
{
    for( var _i = 3; _i < argument_count; _i++ )
    {
        if ( gamepad_button_check( _device, argument[_i] ) )
        {
            __input_handle_general( _player,
                                    _input_slot,
                                    argument[_i] + 0.2 + _device/100,
                                    1,
                                    E_INPUT_DEVICE_KIND.GAMEPAD_BUTTON );
        }
    }
}