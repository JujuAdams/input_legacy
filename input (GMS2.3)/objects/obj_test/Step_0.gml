//Very simple move code!

//Detect up/down/left/right input
var _h = input_check_analogue(0, E_INPUT_SLOT.RIGHT) - input_check_analogue(0, E_INPUT_SLOT.LEFT);
var _v = input_check_analogue(0, E_INPUT_SLOT.DOWN ) - input_check_analogue(0, E_INPUT_SLOT.UP  );

//Detect double-tapped input and speed up if we see it e.g. dashing
//Double-taps often don't work properly for analogue input, so we turn off this feature for gamepad stick input
if (!input_is_analogue(0, E_INPUT_SLOT.UP, E_INPUT_SLOT.DOWN, E_INPUT_SLOT.LEFT, E_INPUT_SLOT.RIGHT))
{
    _h += input_check_double(0, E_INPUT_SLOT.RIGHT) - input_check_double(0, E_INPUT_SLOT.LEFT);
    _v += input_check_double(0, E_INPUT_SLOT.DOWN ) - input_check_double(0, E_INPUT_SLOT.UP  );
}

//Check if the player has pressed a jump button
if (input_check_pressed(0, E_INPUT_SLOT.JUMP)) z_speed += 10;

//Apply gravity
z_speed -= 0.5;
z = max(0, z + z_speed);
if (z <= 0) z_speed = 0;

//Do the movement
x += 4*_h;
y += 4*_v;