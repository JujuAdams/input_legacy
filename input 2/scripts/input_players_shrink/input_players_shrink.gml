var _new_players_array = [];
var _count = 0;

var _p = 0;
repeat(global.__input_max_players)
{
    var _player_array = global.__input_players_array[_p];
    if (_player_array[INPUT_PLAYER.DEVICE] == INPUT_DEVICE_NONE)
    {
        _new_players_array[@ _count] = _player_array;
        ++_count;
    }
    
    ++_p;
}

var _p = 0;
repeat(_count)
{
    global.__input_players_array[@ _p] = _new_players_array[_p];
    ++_p;
}

repeat(global.__input_max_players - _count)
{
    input_player_clear(_p);
    ++_p;
}