//Very simple move code!
x += 4*( input_check_analogue(input_obj, E_INPUT_SLOT.RIGHT ) - input_check_analogue(input_obj, E_INPUT_SLOT.LEFT ) );
y += 4*( input_check_analogue(input_obj, E_INPUT_SLOT.DOWN  ) - input_check_analogue(input_obj, E_INPUT_SLOT.UP   ) );
y -= 20*input_check_pressed(input_obj, E_INPUT_SLOT.JUMP );