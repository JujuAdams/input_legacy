input_tick();
input_hotswap_tick();

if (input_check_press(VERB.PAUSE))
{
    rebinding = true;
}

if (rebinding)
{
    if (input_rebind_tick(VERB.DOWN) != 0)
    {
        rebinding = false;
        show_debug_message(input_bindings_write(true));
    }
}