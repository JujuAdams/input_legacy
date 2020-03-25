input_init(4);
input_action_add("test");
input_device_set(0, INPUT_DEVICE_KEYBOARD);

input_binding_set(0,   "test", 0,   ord("X"), INPUT_BINDING_KEYBOARD);
var _string = input_player_export(0, 0);
input_bindings_clear(0, "test");
input_player_import(_string, 0, 0);