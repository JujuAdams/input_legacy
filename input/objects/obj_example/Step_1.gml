input_tick();
input_hotswap_tick();

if (input_check_press(VERB.PAUSE))
{
    rebinding = true;
}

if (rebinding)
{
    var _result = input_rebind_tick(VERB.RIGHT);
    if (_result != 0) rebinding = false;
}