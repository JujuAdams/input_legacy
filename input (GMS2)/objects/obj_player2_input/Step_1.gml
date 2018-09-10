input_refresh_begin();

//Note that we can stack many different inputs for the same input slot
//This system supports gamepad axis, gamepad button, keyboard button, and mouse button input

input_handle_gamepad_axis(   E_INPUT_SLOT.UP   , gamepad_device, gp_axislv, -0.3 );
input_handle_gamepad_button( E_INPUT_SLOT.UP   , gamepad_device, gp_padu );
input_handle_keyboard(       E_INPUT_SLOT.UP   , ord("I") );

input_handle_gamepad_axis(   E_INPUT_SLOT.DOWN , gamepad_device, gp_axislv,  0.3 );
input_handle_gamepad_button( E_INPUT_SLOT.DOWN , gamepad_device, gp_padd );
input_handle_keyboard(       E_INPUT_SLOT.DOWN , ord("K") );

input_handle_gamepad_axis(   E_INPUT_SLOT.LEFT , gamepad_device, gp_axislh, -0.3 );
input_handle_gamepad_button( E_INPUT_SLOT.LEFT , gamepad_device, gp_padl );
input_handle_keyboard(       E_INPUT_SLOT.LEFT , ord("J") );

input_handle_gamepad_axis(   E_INPUT_SLOT.RIGHT, gamepad_device, gp_axislh,  0.3 );
input_handle_gamepad_button( E_INPUT_SLOT.RIGHT, gamepad_device, gp_padr );
input_handle_keyboard(       E_INPUT_SLOT.RIGHT, ord("L") );

input_handle_gamepad_button( E_INPUT_SLOT.JUMP , gamepad_device, gp_face1 );
input_handle_keyboard(       E_INPUT_SLOT.JUMP , vk_enter );
input_refresh_end(); //Actual state processing happens in this script