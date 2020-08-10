function input_rebind_undo()
{
    if (instanceof(global.__input_rebind_last_player) == "__input_class_player")
    {
        with(global.__input_rebind_last_player)
        {
            var _binding = undefined;
            
            var _source_verb_struct = sources[rebind_source];
            if (is_struct(_source_verb_struct))
            {
                var _alternate_array = variable_struct_get(_source_verb_struct, rebind_verb);
                if (is_array(_alternate_array))
                {
                    _binding = _alternate_array[rebind_alternate];
                }
            }
            
            if (is_struct(_binding))
            {
                __input_trace("Rebinding undo successful (source=", rebind_source, ", verb=", rebind_verb, ", alternate=", rebind_alternate, "). Overwriting ", _binding, " with backup ", rebind_backup);
                
                _binding.type          = rebind_backup.type;
                _binding.value         = rebind_backup.value;
                _binding.axis_negative = rebind_backup.axis_negative;
                
                return true;
            }
        }
    }
    
    __input_trace("Rebinding undo failed");
    return false;
}