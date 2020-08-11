var _string  = "Left    = " + string(input_value(VERB.LEFT   )) + "\n";
    _string += "Right   = " + string(input_value(VERB.RIGHT  )) + "\n";
    _string += "Up      = " + string(input_value(VERB.UP     )) + "\n";
    _string += "Down    = " + string(input_value(VERB.DOWN   )) + "\n";
    _string += "Confirm = " + string(input_value(VERB.CONFIRM)) + "\n";
    _string += "Cancel  = " + string(input_value(VERB.CANCEL )) + "\n";
    _string += "Pause   = " + string(input_value(VERB.PAUSE  )) + "\n";
    
draw_text(10, 10, _string);

draw_circle(input_cursor_x(), input_cursor_y(), 4, true);