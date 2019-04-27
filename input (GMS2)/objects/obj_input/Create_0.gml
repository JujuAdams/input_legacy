//Millisecond delay times for extended behaviours
repeat_delay    = 280;
longpress_delay = 400;
doubletap_delay = 300;

//No device has been found yet. This variable is handled in "Async - System"
gamepad_device = -1;

//Set the maximum number of players
input_set_max_players(2);

//Initialise the input system
input_clear();