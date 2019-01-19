enum E_INPUT_SLOT
{
    UP,
    DOWN,
    LEFT,
    RIGHT,
    JUMP, //Add your own enum element to add another input slot!
    __SIZE
}

//Millisecond delay times for extended behaviours
repeat_delay = 280;
long_delay   = 400;
double_delay = 210;

//No device has been found yet. This variable is handled in "Async - System"
gamepad_device = -1;

//Initialise the input system
input_clear();