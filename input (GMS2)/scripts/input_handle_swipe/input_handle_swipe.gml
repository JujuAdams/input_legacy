///input_handle_swipe(input, min_dist, dir, tolerance)
var _dist;
var _dir;
var _swipe_dist = argument[1];
var _swipe_dir = argument[2];
var _dir_tolerance = argument[3]
for (var i=0;i<5;i++) {
    if (!swipe_data[i,SWIPE_DATA.RELEASED]) continue;
    
    _dist = swipe_data[i,SWIPE_DATA.DISTANCE];
    _dir = swipe_data[i,SWIPE_DATA.DIRECTION];
    if (_dist > _swipe_dist) {
        if (abs(angle_difference(_swipe_dir,_dir)) < _dir_tolerance) {
            __input_handle_general(argument[0],2);
        } 
    }
}