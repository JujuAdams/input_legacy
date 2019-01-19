/// @param index
/// @param pressed_index
/// @param analog_value
/// @param device_kind

input_state[ argument0, E_INPUT_STATE.NEW_ON            ] = true;
input_state[ argument0, E_INPUT_STATE.NEW_PRESSED_INDEX ] = argument1;
input_state[ argument0, E_INPUT_STATE.ANALOGUE          ] = argument2;
input_state[ argument0, E_INPUT_STATE.DEVICE_KIND       ] = argument3;