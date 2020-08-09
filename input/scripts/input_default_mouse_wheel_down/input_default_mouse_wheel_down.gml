/// @param verb
/// @param [alternate]

function input_default_mouse_wheel_down()
{
    var _verb      = argument[0];
    var _alternate = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : 0;
    
    global.__input_default_player.set_binding(INPUT_SOURCE.MOUSE, _verb, _alternate,
                                              {
                                                  type          : "wheel down",
                                                  value         : undefined,
                                                  axis_negative : undefined,
                                              });
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[_p].set_binding(INPUT_SOURCE.MOUSE, _verb, _alternate,
                                               {
                                                   type          : "wheel down",
                                                   value         : undefined,
                                                   axis_negative : undefined,
                                               });
        ++_p;
    }
}