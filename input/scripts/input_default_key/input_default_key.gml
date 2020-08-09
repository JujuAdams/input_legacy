/// @param key
/// @param verb
/// @param [alternate]

function input_default_key()
{
    var _key       = argument[0];
    var _verb      = argument[1];
    var _alternate = ((argument_count > 2) && (argument[2] != undefined))? argument[2] : 0;
    
    global.__input_default_player.set_binding(INPUT_SOURCE.KEYBOARD, _verb, _alternate,
                                              {
                                                  type          : "key",
                                                  value         : _key,
                                                  axis_negative : undefined,
                                              });
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[_p].set_binding(INPUT_SOURCE.KEYBOARD, _verb, _alternate,
                                               {
                                                   type          : "key",
                                                   value         : _key,
                                                   axis_negative : undefined,
                                               });
        ++_p;
    }
}