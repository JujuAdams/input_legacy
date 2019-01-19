/// @param player
/// @param input_slot
/// @param [input_slot...]
//  Returns what kind of device created this input

var _player = argument[0];

for( var _i = 1; _i < argument_count; _i++ )
{
    if ( input_device_kind( _player, argument[_i] ) == E_INPUT_DEVICE_KIND.GAMEPAD_ANALOGUE ) return true;
}
return false;