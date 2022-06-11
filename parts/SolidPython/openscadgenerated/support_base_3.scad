$fn = 48;
use </home/bms/crazywalk/parts/SolidPython/../openscad/bearing.scad>


color(alpha = 1.0000000000, c = "#EFB1A3") {
	union() {
		translate(v = [0.0000000000, 0, 0]) {
			support_base(connector = 0, height_c = 7.6225000000, length_c = 45.0000000000, text = "3");
		}
		translate(v = [45.0000000000, 0, 0]) {
			support_base(connector = 0, height_c = 5.8900000000, length_c = 45.0000000000, text = "4");
		}
		translate(v = [90.0000000000, 0, 0]) {
			support_base(connector = 1, height_c = 4.5625000000, length_c = 45.0000000000, text = "5");
		}
	}
}