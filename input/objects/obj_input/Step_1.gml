input_refresh_begin();

//Note that we can stack many different inputs for the same input slot
//This system supports gamepad axis, gamepad button, keyboard button, and mouse button input

input_handle_gamepad_axis(   E_INPUT.UP   , gamepad_device, gp_axislv, -0.3 );
input_handle_gamepad_button( E_INPUT.UP   , gamepad_device, gp_padu );
input_handle_keyboard(       E_INPUT.UP   , vk_up, ord("W") );

input_handle_gamepad_axis(   E_INPUT.DOWN , gamepad_device, gp_axislv,  0.3 );
input_handle_gamepad_button( E_INPUT.DOWN , gamepad_device, gp_padd );
input_handle_keyboard(       E_INPUT.DOWN , vk_down, ord("S") );

input_handle_gamepad_axis(   E_INPUT.LEFT , gamepad_device, gp_axislh, -0.3 );
input_handle_gamepad_button( E_INPUT.LEFT , gamepad_device, gp_padl );
input_handle_keyboard(       E_INPUT.LEFT , vk_left, ord("A") );

input_handle_gamepad_axis(   E_INPUT.RIGHT, gamepad_device, gp_axislh,  0.3 );
input_handle_gamepad_button( E_INPUT.RIGHT, gamepad_device, gp_padr );
input_handle_keyboard(       E_INPUT.RIGHT, vk_right, ord("D") );

input_handle_gamepad_button( E_INPUT.JUMP , gamepad_device, gp_face1 );
input_handle_keyboard(       E_INPUT.JUMP , vk_space, vk_enter );
input_handle_mouse(          E_INPUT.JUMP , mb_left );

input_refresh_end(); //Actual state processing happens in this script