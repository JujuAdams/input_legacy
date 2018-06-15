/// input_handle_mouse(input_index, button, [device])

var _device = 0
if ((argument_count >= 3) && (argument[2] != undefined)) {
 _device = argument[2]
}

if ( device_mouse_check_button( _device, argument1 ) ) __input_handle_general( argument0, argument1 + 0.3 + _device/100 );
