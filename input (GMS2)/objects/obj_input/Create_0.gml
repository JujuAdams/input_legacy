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
					 SWIPE, SWIPE_START, SWIPE_DIST, SWIPE_DIR,//Swipes
                     __SIZE }
enum SWIPE_DATA {
    DISTANCE,
    DIRECTION,
    HELD,
    RELEASED,
    START_X,
    START_Y
}
//Millisecond delay times for advanced behaviours
repeat_delay = 280;
long_delay   = 400;
double_delay = 210;

for (var i=0;i<5;i++) {
    swipe_data[i,SWIPE_DATA.DISTANCE] = 0;
    swipe_data[i,SWIPE_DATA.DIRECTION] = 0;
    swipe_data[i,SWIPE_DATA.HELD] = 0;
}

//We're using gamepad device 0
gamepad_device = 0;

//Initialise the input system
input_clear();