$fn = 48;
use </home/bms/crazywalk/parts/SolidPython/../openscad/bearing.scad>


color(alpha = 1.0000000000, c = "#7D8798") {
	union() {
		translate(v = [0.0000000000, 0, 0]) {
			support_base(connector = 0, height_c = 3.6400000000, length_c = 45.0000000000, text = "6");
		}
		translate(v = [45.0000000000, 0, 0]) {
			support_base(connector = 0, height_c = 3.1225000000, length_c = 45.0000000000, text = "7");
		}
		translate(v = [90.0000000000, 0, 0]) {
			support_base(connector = 1, height_c = 3.0100000000, length_c = 45.0000000000, text = "8");
		}
	}
}