$fn = 48;
use </home/bms/crazywalk/parts/SolidPython/../openscad/bearing.scad>


color(alpha = 1.0000000000, c = "#73C0F5") {
	union() {
		translate(v = [0.0000000000, 0, 0]) {
			support_base(connector = 0, height_c = 3.3025000000, length_c = 45.0000000000, text = "9");
		}
		translate(v = [45.0000000000, 0, 0]) {
			support_base(connector = 0, height_c = 4.0000000000, length_c = 45.0000000000, text = "A");
		}
		translate(v = [90.0000000000, 0, 0]) {
			support_base(connector = 1, height_c = 5.1025000000, length_c = 45.0000000000, text = "B");
		}
	}
}