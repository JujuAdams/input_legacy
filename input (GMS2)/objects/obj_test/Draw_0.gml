//Draw a shadow
draw_set_colour(c_black);
draw_set_alpha(0.4);
draw_ellipse(x-16, y+12, x+16, y+20, false);

//Draw the object
draw_set_colour(c_white);
draw_set_alpha(1.0);
draw_circle(x, y-z, 16, false);