//Very simple move code!



//Detect up/down/left/right input
var _h = input_check_analogue( 0, E_INPUT_SLOT.RIGHT ) - input_check_analogue( 0, E_INPUT_SLOT.LEFT );
var _v = input_check_analogue( 0, E_INPUT_SLOT.DOWN  ) - input_check_analogue( 0, E_INPUT_SLOT.UP   );



//Detect double-tapped input and speed up if we see it e.g. dashing
//Double-taps often don't work properly for analogue input, so we turn off this feature for gamepad stick input
if ( !input_is_analogue( 0, E_INPUT_SLOT.UP, E_INPUT_SLOT.DOWN, E_INPUT_SLOT.LEFT, E_INPUT_SLOT.RIGHT ) )
{
    _h += input_check_double( 0, E_INPUT_SLOT.RIGHT ) - input_check_double( 0, E_INPUT_SLOT.LEFT );
    _v += input_check_double( 0, E_INPUT_SLOT.DOWN  ) - input_check_double( 0, E_INPUT_SLOT.UP   );
}



//Do the movement
x += 4*_h;
y += 4*_v;
y -= 25*input_check_pressed( 0, E_INPUT_SLOT.JUMP );