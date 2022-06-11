$fn = 48;
use </home/bms/crazywalk/parts/SolidPython/../openscad/bearing.scad>


color(alpha = 1.0000000000, c = "#C37166") {
	union() {
		translate(v = [0.0000000000, 0, 0]) {
			support_base(connector = 0, height_c = 77.8225000000, length_c = 45.0000000000, text = "1B");
		}
		translate(v = [45.0000000000, 0, 0]) {
			support_base(connector = 0, height_c = 85.8100000000, length_c = 45.0000000000, text = "1C");
		}
		translate(v = [90.0000000000, 0, 0]) {
			support_base(connector = 1, height_c = 94.2025000000, length_c = 45.0000000000, text = "1D");
		}
	}
}