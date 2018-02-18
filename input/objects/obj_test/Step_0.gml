//Very simple move code!
x += 4*( input_check( E_INPUT_SLOT.RIGHT ) - input_check( E_INPUT_SLOT.LEFT ) );
y += 4*( input_check( E_INPUT_SLOT.DOWN  ) - input_check( E_INPUT_SLOT.UP   ) );
y -= 20*input_check_pressed( E_INPUT_SLOT.JUMP );