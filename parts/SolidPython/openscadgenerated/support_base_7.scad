$fn = 48;
use </home/bms/crazywalk/parts/SolidPython/../openscad/bearing.scad>


color(alpha = 1.0000000000, c = "#A76783") {
	union() {
		translate(v = [0.0000000000, 0, 0]) {
			support_base(connector = 0, height_c = 13.5625000000, length_c = 45.0000000000, text = "F");
		}
		translate(v = [45.0000000000, 0, 0]) {
			support_base(connector = 0, height_c = 16.6900000000, length_c = 45.0000000000, text = "10");
		}
		translate(v = [90.0000000000, 0, 0]) {
			support_base(connector = 1, height_c = 20.2225000000, length_c = 45.0000000000, text = "11");
		}
	}
}