magnets = 8; /* Magnets in holder */

/* Parameters in mm */
magnet_radius = 10;
magnet_height = 2;
thickness = 5; /* Extra thickness around magnets */
wheel_diameter = 90;
wheel_radius = wheel_diameter / 2;

hull_divider = 1.25; /* Amount to divide the hull by */


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
			magnet_transform(i, wheel_radius - magnet_radius, magnet_radius + thickness);
			hull()
			{
				magnet_transform(i, wheel_radius - magnet_radius, (magnet_radius + thickness) / hull_divider);
				magnet_transform(i + 1, wheel_radius - magnet_radius, (magnet_radius + thickness) / hull_divider);
			}
		}
	}
	/* Magnets to be subtracted */
	union()
	{
		for (i = [1:magnets]) {
			magnet_transform(i, wheel_radius - magnet_radius, magnet_radius);
		}
	}
}

