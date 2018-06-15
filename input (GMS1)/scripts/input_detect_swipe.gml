
for (var i=0;i<5;i++) {
    if (    !device_mouse_check_button(i,mb_left) && 
            !device_mouse_check_button_released(i,mb_left)) {
        swipe_data[i,SWIPE_DATA.RELEASED] = false;
    }
    if (device_mouse_check_button_pressed(i,mb_left)) {
        swipe_data[i,SWIPE_DATA.HELD] = true;
        swipe_data[i,SWIPE_DATA.START_X] = device_mouse_x(i);
        swipe_data[i,SWIPE_DATA.START_Y] = device_mouse_y(i);
    }
    if (device_mouse_check_button_released(i,mb_left)) {
        swipe_data[i,SWIPE_DATA.HELD] = false;
        swipe_data[i,SWIPE_DATA.RELEASED] = true;
        swipe_data[i,SWIPE_DATA.DISTANCE] = point_distance( swipe_data[i,SWIPE_DATA.START_X],
                                                            swipe_data[i,SWIPE_DATA.START_Y],
                                                            device_mouse_x(i),
                                                            device_mouse_y(i));
        swipe_data[i,SWIPE_DATA.DIRECTION]= point_direction(swipe_data[i,SWIPE_DATA.START_X],
                                                            swipe_data[i,SWIPE_DATA.START_Y],
                                                            device_mouse_x(i),
                                                            device_mouse_y(i));
    }
}
