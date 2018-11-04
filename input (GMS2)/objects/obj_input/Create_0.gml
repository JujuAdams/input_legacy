enum E_INPUT_SLOT { UP,
                    DOWN,
                    LEFT,
                    RIGHT,
                    JUMP, //Add your own enum element to add another input slot
                    __SIZE }

enum E_INPUT_STATE { PRESSED, ON, RELEASED,                    //Simple behaviours
                     REPEATED, LONG, DOUBLE,                   //Advanced behaviours
                     PRESSED_TIME, PRESSED_INDEX, REPEAT_TIME, //Timers
                     NEW_ON, NEW_PRESSED_INDEX,                //Momentary states
                     __SIZE }

//Millisecond delay times for advanced behaviours
repeat_delay = 280;
long_delay   = 400;
double_delay = 210;

//No device has been found yet. This variable is handled in "Async - System"
gamepad_device = -1;

//Initialise the input system
input_clear();