/// @param input_slot
/// @param [input_slot...]
//  Returns what kind of device created this input

for( var _i = 0; _i < argument_count; _i++ )
{
    if ( input_device_kind( argument[_i] ) == E_INPUT_DEVICE_KIND.GAMEPAD_ANALOGUE ) return true;
}
return false;