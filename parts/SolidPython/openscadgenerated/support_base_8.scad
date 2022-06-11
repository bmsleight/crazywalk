$fn = 48;
use </home/bms/crazywalk/parts/SolidPython/../openscad/bearing.scad>


color(alpha = 1.0000000000, c = "#E4B96D") {
	union() {
		translate(v = [0.0000000000, 0, 0]) {
			support_base(connector = 0, height_c = 24.1600000000, length_c = 45.0000000000, text = "12");
		}
		translate(v = [45.0000000000, 0, 0]) {
			support_base(connector = 0, height_c = 28.5025000000, length_c = 45.0000000000, text = "13");
		}
		translate(v = [90.0000000000, 0, 0]) {
			support_base(connector = 1, height_c = 33.2500000000, length_c = 45.0000000000, text = "14");
		}
	}
}