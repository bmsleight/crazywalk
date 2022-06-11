$fn = 48;
use </home/bms/crazywalk/parts/SolidPython/../openscad/bearing.scad>


color(alpha = 1.0000000000, c = "#F281CF") {
	union() {
		translate(v = [0.0000000000, 0, 0]) {
			support_base(connector = 0, height_c = 6.6100000000, length_c = 45.0000000000, text = "C");
		}
		translate(v = [45.0000000000, 0, 0]) {
			support_base(connector = 0, height_c = 8.5225000000, length_c = 45.0000000000, text = "D");
		}
		translate(v = [90.0000000000, 0, 0]) {
			support_base(connector = 1, height_c = 10.8400000000, length_c = 45.0000000000, text = "E");
		}
	}
}