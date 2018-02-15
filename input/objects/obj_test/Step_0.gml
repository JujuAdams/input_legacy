//Very simple move code!
x += 4*( input_check( E_INPUT.RIGHT ) - input_check( E_INPUT.LEFT ) );
y += 4*( input_check( E_INPUT.DOWN  ) - input_check( E_INPUT.UP   ) );
y -= 20*input_check_pressed( E_INPUT.JUMP );