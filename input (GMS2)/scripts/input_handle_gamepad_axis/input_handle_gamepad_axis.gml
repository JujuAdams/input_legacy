/// @param player
/// @param input_slot
/// @param device
/// @param axis
/// @param threshold

var _player     = argument0;
var _input_slot = argument1;
var _device     = argument2;
var _axis       = argument3;
var _threshold  = argument4;

if ( gamepad_is_connected( _device ) )
{
    if ( gamepad_axis_value( _device, _axis )*sign( _threshold ) > abs( _threshold ) )
    {
        __input_handle_general( _player,
                                _input_slot,
                                _axis + 0.1 + _device/100,
                                gamepad_axis_value( _device, _axis )*sign( _threshold ),
                                E_INPUT_DEVICE_KIND.GAMEPAD_ANALOGUE );
    }
}