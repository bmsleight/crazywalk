$fn = 48;
use </home/bms/crazywalk/parts/SolidPython/../openscad/bearing.scad>


color(alpha = 1.0000000000, c = "#97E2CD") {
	union() {
		translate(v = [0.0000000000, 0, 0]) {
			support_base(connector = 0, height_c = 38.4025000000, length_c = 45.0000000000, text = "15");
		}
		translate(v = [45.0000000000, 0, 0]) {
			support_base(connector = 0, height_c = 43.9600000000, length_c = 45.0000000000, text = "16");
		}
		translate(v = [90.0000000000, 0, 0]) {
			support_base(connector = 1, height_c = 49.9225000000, length_c = 45.0000000000, text = "17");
		}
	}
}