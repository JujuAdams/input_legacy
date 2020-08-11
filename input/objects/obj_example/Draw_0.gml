var _string  = "Left    = " + string(input_value(VERB.LEFT   )) + "\n";
    _string += "Right   = " + string(input_value(VERB.RIGHT  )) + "\n";
    _string += "Up      = " + string(input_value(VERB.UP     )) + "\n";
    _string += "Down    = " + string(input_value(VERB.DOWN   )) + "\n";
    _string += "Confirm = " + string(input_value(VERB.CONFIRM)) + "\n";
    _string += "Cancel  = " + string(input_value(VERB.CANCEL )) + "\n";
    _string += "Pause   = " + string(input_value(VERB.PAUSE  )) + "\n";
    
draw_text(10, 10, _string);

var _i = 0;
repeat(INPUT_MAX_PLAYERS)
{
    if (input_player_connected(_i))
    {
        draw_circle(input_cursor_x(_i), input_cursor_y(_i), 4, false);
        draw_circle(input_cursor_x(_i), input_cursor_y(_i), 6, true);
        draw_text(input_cursor_x(_i) + 5, input_cursor_y(_i) + 5, _i);
    }
    
    ++_i;
}