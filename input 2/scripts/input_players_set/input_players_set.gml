/// @param count

var _count = argument0;

if ((_count < 1) || (_count > global.__input_max_players))
{
    show_error("Input:\nNew player count (" + string(_count) + ") is invalid (range is 1 to " + string(global.__input_max_players) + ")\n ", false);
    exit;
}

if (_count == global.__input_players) exit;

var _a = min(_count, global.__input_players);
var _b = max(_count, global.__input_players);

var _i = _a;
repeat(1 + _b - _a)
{
    input_player_clear(_i);
    ++_i;
}