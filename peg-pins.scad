
$fa=0.5;
$fs=0.5;

boardThickness = 6.5;
holeDiameter = 6.05;
pinEndHeight = 1.5;
coneHeight = 2.5;
pinBaseHeight = boardThickness + pinEndHeight + coneHeight;

module pinBase(pinDiameter)
{
    translate([0, 0, -2 - (boardThickness + 0.5) - coneHeight])
        difference() {
            union()
            {
                cylinder(h=2, d1=(holeDiameter - 2), d2=(holeDiameter + 1));
            
                translate([0, 0, 2])
                    cylinder(h=(boardThickness + 0.5), d=holeDiameter);
                
                translate([0, 0, 9])
                    cylinder(h=coneHeight, d1=(holeDiameter + 2), d2=pinDiameter);
            }
            cube([(holeDiameter + 1), 1, (2 + boardThickness + 0.5) * 2], center=true);
            translate([holeDiameter / 2-0.05, -holeDiameter / 2, 0]) cube([2, holeDiameter, pinBaseHeight]);
            translate([-holeDiameter / 2 - 1, -2, 0]) cube([1, 4, coneHeight + 0.5]);
        }
}

module pin(d, h, ed)
{
    rotate([180, 0, 0])
        translate([0, 0, -h -pinEndHeight])
            union() {
                pinBase(d);
                cylinder(d=d, h=h);
                translate([0, 0, h])
                cylinder(d=ed, h=pinEndHeight);
            }
}

module torus(d, d1) {
    rotate_extrude(convexity = 10)
        translate([d / 2, 0, 0])
            circle(d = d1, $fn = 20);
}

module ring_hook(d, d1) {
    translate([holeDiameter / 2 - d1 / 2, 0, d / 2 + (0*d1 / 2)])
        rotate([90, 0, 90])
            torus(d, d1);
    pinBase(d1);
    //translate([0, 0, d1/4]) cube([d1, d1 * 2, d1*1.5], center=true);
}


module pinArray() {
    for (i = [0 : 4]) {
        translate([i * (holeDiameter + 2.5), 0, 0]) pin(d=4, h=10 + (5*i), ed=7.0);
        translate([i * (holeDiameter + 2.5), (holeDiameter + 2.5), 0]) pin(d=4, h=10 + (5*i), ed=4);
    }


    translate([8.5*2, 0, 15]) translate([0, -0.5, 0]) cube([8.5 * 2, 1, 1]);
    translate([8.5*2, 8, 15]) translate([0, -0.5, 0]) cube([8.5 * 2, 1, 1]);
    translate([8.5*4, 0, 15]) translate([-0.5, 0, 0]) cube([1, 8.5, 1]);
    translate([8.5*3, 0, 15]) translate([-0.5, 0, 0]) cube([1, 8.5, 1]);
    translate([8.5*2, 0, 15]) translate([-0.5, 0, 0]) cube([1, 8.5, 1]);
    
    translate([8.5*0, 0, 8]) translate([0, -0.5, 0]) cube([8.5 * 2, 1, 1]);
    translate([8.5*0, 8, 8]) translate([0, -0.5, 0]) cube([8.5 * 2, 1, 1]);
    
    translate([8.5*1, 0, 8]) translate([-0.5, 0, 0]) cube([1, 8.5, 1]);
    translate([8.5*0, 0, 8]) translate([-0.5, 0, 0]) cube([1, 8.5, 1]);
}

module ringArray() {
    translate([70, 0, 0]) rotate([0, 90, 0]) ring_hook(10, 3);
    translate([70, 17, 0]) rotate([0, 90, 0]) ring_hook(15, 4);
    translate([70, 40, 0]) rotate([0, 90, 0]) ring_hook(17.5, 4);
    translate([100, 50, 0]) rotate([0, 90, 0]) ring_hook(20, 4);
    translate([70, 70, 0]) rotate([0, 90, 0]) ring_hook(25, 4);
    translate([100, 90, 0]) rotate([0, 90, 0]) ring_hook(27.5, 4);
    translate([70, 110, 0]) rotate([0, 90, 0]) ring_hook(30, 4);
}
pinArray();
ringArray();
