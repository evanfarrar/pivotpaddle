// Measuring a paddle I like:
// the face is an oval: 150mm, 175mm,  5mm
// the handle overlaps the oval by about 5mm
// handle is a cylinder 9.5cm, 2.75cm, 2cm thick
// s curves meeting the handle shaft.
// x y z

include <pins.scad>;

face_thick = 5.0;
face_wide = 145.0;
face_high = 170.0;
handle_shaft_overlap = 5.0;
handle_shaft_high = 90.0;
handle_shaft_wide = 27.5;
handle_shaft_thick = face_thick;
handle_thick = 20.0;
pin_diameter = 5;

echo("Total paddle height (mm):", total_paddle_height);
total_paddle_height = face_high+handle_shaft_high-handle_shaft_overlap;
total_paddle_x_origin = -((total_paddle_height)/2 - face_high/2);

module handle_shaft() {
	difference() {
		cube([handle_shaft_high,handle_shaft_wide,handle_shaft_thick],true);
		translate([handle_shaft_high/3,0,0])
			cylinder(handle_shaft_thick,pin_diameter,pin_diameter,true);
		translate([-(handle_shaft_high*1/3),0,0])
			cylinder(handle_shaft_thick,pin_diameter,pin_diameter,true);
	}
}

module paddle_oval() {
	scale([(face_high / face_wide), 1, 1]) {
		cylinder(face_thick,face_wide/2,face_wide/2);
	}
}

module paddleface() {
	{
		translate([total_paddle_x_origin, 0, 0]) paddle_oval();
		handle_origin_x = face_high/2 + handle_shaft_high/2 - handle_shaft_overlap;
		translate([handle_origin_x+total_paddle_x_origin, 0, handle_shaft_thick/2]) {
			handle_shaft();
		}
	}
}

module paddlehandle() {
	translate([-total_paddle_x_origin-handle_shaft_overlap,0,handle_shaft_thick/2]) difference () {
		rotate([90,0,90]) {
			difference() {
				difference() {
					difference() {
						scale([1, (handle_thick / handle_shaft_wide), 1]) {
							cylinder(handle_shaft_high,handle_thick/2.0+4,handle_thick/2.0+4);
						}
						translate([0,0,handle_shaft_high/2]) {
							cube([handle_shaft_wide+3,handle_shaft_thick,handle_shaft_high],true);
						}
					}
					translate([0,handle_shaft_thick*2+3,0]) {
						rotate([-20,0,0]) {
							cube([handle_shaft_wide,handle_shaft_thick*3,handle_shaft_high],true);
						}
					}
				}
				translate([0,-handle_shaft_thick,handle_shaft_high/2]) {
					cube([handle_shaft_wide,handle_shaft_thick*3,handle_shaft_high],true);
				}
			}
		}
		translate([-total_paddle_x_origin+(handle_shaft_overlap/2),0,handle_shaft_thick/2]) {
		translate([handle_shaft_high*1/3,0,0])
			pinhole(6,5,3,1,0.3,true);
			
		translate([(-handle_shaft_high*1/3),0,0])
			pinhole(6,5,3,1,0.3,true);
		}
	}

//pinhole(h=10, r=4, lh=2, lt=1, t=0.3, tight=true)

}

//pinhole(10,5);

module pins() {
	pinpeg(handle_shaft_thick+12,pin_diameter);
}

//pins();
//paddlehandle();
paddleface();

