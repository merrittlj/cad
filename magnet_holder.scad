magnets = 8; /* Magnets in holder */

/* Parameters in mm */
magnet_diameter = 10;
magnet_radius = magnet_diameter / 2;
magnet_height = 2;
thickness = 3; /* Extra thickness around magnets */
wheel_diameter = 85;
wheel_radius = wheel_diameter / 2;

translation = wheel_radius - magnet_radius - thickness;

hull_divider = 3; /* Amount to divide the hull by */


module magnet_transform(i, x, radius)
{
	rotate([0, 0, (360 / magnets) * i]) {
		translate([x, 0, 0]) {
			cylinder(magnet_height, r = radius, true);
		}
	}
}

difference()
{
	/* Outer shell, magnets subtracted from */
	union()
	{
		for (i = [1:magnets]) {
			magnet_transform(i, translation, magnet_radius + thickness);
			hull()
			{
				magnet_transform(i, translation, (magnet_radius + thickness) / hull_divider);
				magnet_transform(i + 1, translation, (magnet_radius + thickness) / hull_divider);
			}
		}
	}
	/* Magnets to be subtracted */
	union()
	{
		for (i = [1:magnets]) {
			magnet_transform(i, translation, magnet_radius);
		}
	}
}

/* Wheel reference */
/*translate([0, 0, -(60)]) {
	cylinder(60, r = 45, true);
}*/
