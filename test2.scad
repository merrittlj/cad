magnets = 8; /* Magnets in holder */
magnet_radius = 20; /* mm */
magnet_height = 20; /* mm */
wheel_diameter = cm_to_mm(60); /* cm */
wheel_radius = wheel_diameter / 2;
thickness = 5; /* Extra thickness around magnets */
hull_divider = 2; /* Amount to divide the hull by */


function cm_to_mm(cm) = cm * 10;

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

