e=0.001;

function getMoveToCenterCX2()=[90.5,74.1,0];

module moveToCenterCX2() {
  translate([90.5,74.1,0]) children();
}

module moveScrewHoleTopFront() {
  moveToCenterCX2() translate([107.5,66,-1]) children();
}
module moveScrewHoleTopRear() {
  moveToCenterCX2() translate([-68,46,-1]) children();
}

module moveToCenterCX4() {
  translate([87,76,0]) children();
}

module moveScrewHoleCX4CoverTop() {
  moveToCenterCX4() translate([30.5+.5,31,-1]) children();
}

/*
module centerPointCX2() {
  moveToCenterCX2() circle(r=e,$fn=30);
}
module moveScrewHoleBottom() {
  moveToCenterCX2() translate([103,-41,-1]) children();
}
module moveScrewHoleCX2MotorBolt1() {
  moveToCenterCX2() translate([75.5+.5,73.5-1.25,-1]) children();
}
module moveScrewHoleCX2MotorBolt2() {
  moveToCenterCX2() translate([15+.75,83.5-2,-1]) children();
}
module moveScrewHoleCX2MotorBolt3() {
  moveToCenterCX2() translate([-79.5+1,0,-1]) children();
}
*/
//color("green")
//moveScrewHoleCX2MotorBolt3() circle(d=6);
//moveScrewHoleCX2MotorBolt2() circle(d=6);
//moveScrewHoleCX2MotorBolt1() circle(d=6);

module boschCX4model() {
  color("silver")
    translate([-3,2,0])
    rotate([90,0,180])
    rotate([0,-3,0])
    import("bosch_cx4_3d_scan.stl");
}
module boschCX4LeftImport() {
  scaleF=1.7555;
  translate([231.4,13.5,0])
  mirror([1,0,0]) 
  scale([scaleF,scaleF,scaleF])
  rotate([0,0,-5.4])
  import("20241107_153925_cx4_left_mod4.dxf");
}
#linear_extrude(.1) boschCX4LeftImport();
module boschCX4RightImport() {
  scaleF=4.2;
  translate([-12,-11,0])
//  mirror([1,0,0]) 
  scale([scaleF,scaleF,scaleF])
  rotate([0,0,4])
  import("20241108_102550_cx4_right_mod.dxf");
}
#linear_extrude(.1) boschCX4RightImport();

boschCX4model();