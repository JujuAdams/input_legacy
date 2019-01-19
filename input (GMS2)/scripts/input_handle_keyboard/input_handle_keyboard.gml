/// @param player
/// @param input_slot
/// @param keyboard_button
/// @param [keyboard_button...]

var _player     = argument[0];
var _input_slot = argument[1];

for( var _i = 2; _i < argument_count; _i++ )
{
    if ( keyboard_check( argument[_i] ) ) __input_handle_general( _player,
                                                                  _input_slot,
                                                                  argument[_i],
                                                                  1,
                                                                  E_INPUT_DEVICE_KIND.KEYBOARD );
}