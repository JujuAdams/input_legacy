/// @param action

var _action = argument0;

global.__input_actions_map[? _action] = global.__input_actions;

var _p = 0;
repeat(global.__input_max_players)
{
    input_action_clear(_p, _action);
    ++_p;
}

++global.__input_actions;