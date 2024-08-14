magnets = 8 /* Magnets in holder */
magnet_radius = 10 /* cm */
magnet_height = 8 /* cm */
wheel_diameter = 60 /* cm */
wheel_radius = wheel_diameter / 2
thickness = 5 /* Extra thickness around magnets */


module magnet_circle(radius)
{
	for (i = [1:magnets]) {
		rotate([0, 0, (360 / magnets) * i) {
			translate([wheel_radius], 0, 0) {
				cylinder(magnet_height, r = radius, true)
			}
		}
	}
}

difference()
{
	/* Outer shell, magnets subtracted from */
	magnet_circle(magnet_radius + thickness); /* Shell magnets */
	/* Magnets to be subtracted */
	magnet_circle(magnet_radius); /* Subtracting magnets */
}
