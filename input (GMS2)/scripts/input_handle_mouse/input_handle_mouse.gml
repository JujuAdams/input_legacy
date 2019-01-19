/// @param input_slot
/// @param button
/// @param [device]

var _player     = argument[0];
var _input_slot = argument[1];
var _button     = argument[2];
var _device     = ((argument_count > 3) && (argument[3] != undefined))? argument[3] : 0;

if ( device_mouse_check_button( _device, _button ) )
{
    __input_handle_general( _player,
                            _input_slot,
                            _button + 0.3 + _device/100,
                            1,
                            E_INPUT_DEVICE_KIND.MOUSE );
}