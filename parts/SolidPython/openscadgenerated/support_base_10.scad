$fn = 48;
use </home/bms/crazywalk/parts/SolidPython/../openscad/bearing.scad>


color(alpha = 1.0000000000, c = "#D8ED7F") {
	union() {
		translate(v = [0.0000000000, 0, 0]) {
			support_base(connector = 0, height_c = 56.2900000000, length_c = 45.0000000000, text = "18");
		}
		translate(v = [45.0000000000, 0, 0]) {
			support_base(connector = 0, height_c = 63.0625000000, length_c = 45.0000000000, text = "19");
		}
		translate(v = [90.0000000000, 0, 0]) {
			support_base(connector = 1, height_c = 70.2400000000, length_c = 45.0000000000, text = "1A");
		}
	}
}