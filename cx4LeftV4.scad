use <boschImports_v4.scad>

use <polyround.scad>
use <bezier_curve.scad>

module moveFrontOrgCoverPoint1() {
  translate([199,91,-.5])
    rotate([0,0,-41])
    children();
}
module moveFrontCoverConnectionCircle(d=34, offsetV=0) {
  translate([198,102,0])
    rotate([0,0,frontAngle])
    translate([0,offsetV/2,0])
    translate([d/2,0,0])
    children();
}
module frontCoverConnectionCircle(d=34, offsetV=0) {
  moveFrontCoverConnectionCircle(d=d, offsetV=offsetV)
    circle(d=d,$fn=100);
}

frontAngle=18;
L1=35.5+14+2-.2+2;
Y1=69;
boschCoverAdjustmentL=26;
module boschCX2CoverOnCX4LeftOutlined(/*r=2.25,*/ offsetV=0) {


  function beamPoints()=[
      [  7,   47,    0    ],  // 0
      [-30,  140,  250    ],  // 1
      [100,  170,  500    ],  // 2
      [140,  164.5,900    ],  // 3
      [180,  157,  900    ],  // 4
      [230,  128,  200    ],  // 5
      [231,  100,  100    ],  // 6
      [224,   69,    0    ]   // 7
  ];
  module showBeamPoints(v) {
      for (i = [0: len(v)-1]) {
          translate([v[i].x,v[i].y,0]) color("red") 
          text(str(i), font = "Courier New", size=10);
           
      }
  }
  module makeOutlineFromPolyRound() {
    radiiPoints=beamPoints();
    polygon(polyRound(beamChain(radiiPoints,offset1=0.52, offset2=-0.52),20));
  }
  //showBeamPoints(beamPoints());
  
  bezier_curve_points=[
      [  7,   47,  0],  // 0
      [-25,  120,  0],  // 1
      [ 40,  220,  0],  // 2
      [140,  179.5,0],  // 3
      [192,  138,  0],  // 4
      [266.1,  158.4,  0],  // 5
      [225,  100,  0],  // 6
      [224,   69,  0]   // 7
  ];
//  draw_points(bezier_curve_points) circle(1);
//  showBeamPoints(bezier_curve_points);
  
  // Total rendering time: 0:02:28.441
  //makeOutlineFromPolyRound();
  // Total rendering time: 0:01:06.197
  bezier_fn = ($preview) ? 30:80;
  bezier_curve(bezier_curve_points, bezier_fn) circle(0.2);
  
//  #translate([L1,Y1,0]) rotate([0,0,180]) translate([0,offsetV,0]) square([47,1]);
//#  translate([L1,69,0]) rotate([0,0,180]) square([47,1]);
}
//!hull()
//!boschCX2CoverOnCX4LeftOutlined();
//!hull() boschCX2CoverOnCX4LeftOutlined();
//!boschCX2CoverOutlined();

cxSizeOffset=2;
module boschCX4EggCover(offsetV=0) {
//echo("offsetV",offsetV);
  difference()
  {
    union() {
      hull()
        boschCX2CoverOnCX4LeftOutlined(offsetV=offsetV);
      translate([23+10/2-offsetV/2,60+offsetV*0,0])
        circle(d=40+10-offsetV);
    }

    // takeout for Bosch CX4 Cover
    offset(offsetV)
    hull() {
      $fn=100;
      moveToCenterCX4() circle(d=60-cxSizeOffset);
      moveToCenterCX4() translate([69,-3,0]) circle(d=96-cxSizeOffset);
    }
    offset(offsetV)
      translate([L1,67,0])
      rotate([0,0,72])
      translate([0,-10+.75-cxSizeOffset/2,0])
      square([18,10]);
  }
}
//!boschCX4EggCover();


frameT=25;
coverH=25;
totalH=coverH+frameT;
dividerH=7;
start=0;
step=($preview) ? .5:.2;
stepCosSin=step*10;
wallT=1;
wallT2=2;
module cx4CoverLeft() {
  module removeEggParts() {
    translate([10+19,0]) square([208-19,105]);
    translate([50,50]) square([145,80]);
  }
  module body_front_easy_print() {
    // front easy-print
    for (h=[start:step:dividerH])
      translate([0,0,dividerH-h])
      linear_extrude(step) {
//      echo("*********** h",h);
      difference() {
        offsetVcalc=($preview) ? -wallT*h:-wallT*h;
//      echo("*********** offsetVcalc",offsetVcalc);

        union() {
          offset(r=offsetVcalc) boschCX4EggCover(offsetV=offsetVcalc);
        }
        if ((dividerH-h)>2) offset(r=offsetVcalc-2) {
          difference() {
            boschCX4EggCover(offsetV=offsetVcalc);
            moveScrewHoleTopFront() circle(d=12);
            moveScrewHoleTopRear() circle(d=12);
          }
          removeEggParts();
        }
      }
    }
  }
  module body_front_cos_sin() {
    // front cos-sin
    for (a=[0:stepCosSin:90]) {
      radi=dividerH;
      h=radi-sin(a+stepCosSin)*radi;
      translate([0,0,h])
      linear_extrude(sin(a+stepCosSin)*radi-sin(a)*radi) {
        difference() {
          offsetVcalc=($preview) ? -radi+cos(a)*radi:-radi+cos(a)*radi;
          echo("*********** h=",h,", offsetVcalc=", offsetVcalc);

          // build body
          if (h<.2)
              // Make a small "jump" before the curve to make it easier to print
            offset(r=-5.07) boschCX4EggCover(offsetV=-5.07);
          else
            offset(r=offsetVcalc) boschCX4EggCover(offsetV=offsetVcalc);
          if (h>2) offset(r=offsetVcalc-2) {
            difference() {
              boschCX4EggCover(offsetV=offsetVcalc);
              moveScrewHoleTopFront() circle(d=12);
              moveScrewHoleTopRear() circle(d=12);
            }
            removeEggParts();
          }
        }
      }
    }
  }
  module body() {
    translate([0,0,0])
    {
      body_front_easy_print();
//      body_front_cos_sin();

      // sidewalls
      translate([0,0,dividerH])
      linear_extrude(totalH-dividerH-frameT) {
        difference() {
          boschCX4EggCover();
          offset(r=-wallT2) boschCX4EggCover();
          removeEggParts();
        }
        moveScrewHoleTopFront() circle(d=12);
        moveScrewHoleTopRear() circle(d=12);
      }
      // screwholemount for bottom cx4 cover
      linear_extrude(16)
        hull() {
          color("violet")
          moveScrewHoleCX4CoverTop() circle(d=9,$fn=15);
          moveScrewHoleCX4CoverTop() translate([0,12,0]) circle(d=9,$fn=15);
        }
    }
  }
  module removes() {
    $fn=20;
    moveScrewHoleTopFront() cylinder(h=40,d=4.5);
    moveScrewHoleTopRear() cylinder(h=40,d=4.5);
    moveScrewHoleTopFront() cylinder(h=coverH-3,d=8.5);
    moveScrewHoleTopRear() cylinder(h=coverH-3,d=8.5);
    
    extra_cutout_for_cx4_screw_mount = 5;
    linear_extrude(5.6+extra_cutout_for_cx4_screw_mount)
    hull()
    {
      $fn=100;
      moveToCenterCX4() circle(d=60-cxSizeOffset);
      moveToCenterCX4() translate([69,-3,0]) circle(d=96-cxSizeOffset);
    }
    // side cover meet bosch cover at front
    linear_extrude(5.6)
    moveFrontOrgCoverPoint1() rotate([0,0,-9]) translate([0,-20,0]) square([35,20]);

    // remove back of front
    translate([0,0,2.14])
      linear_extrude(5.6+45)
      translate([197.5,95,0])
      rotate([0,0,-41])

      rotate([0,0,])
      translate([0,-20,0])
      square([37.5,20]);

    
    // screwholes
    linear_extrude(5.6+extra_cutout_for_cx4_screw_mount)
      moveScrewHoleCX4CoverTop() circle(d=12.75,$fn=15);
    linear_extrude(totalH)
      moveScrewHoleCX4CoverTop() circle(d=3,$fn=15);
    // frame
//    translate([0,30,coverH]) cube([200,170,frameT+1]);
//    #translate([190,121,coverH]) cube([50,50,frameT+1]);
//    translate([190,121-70,dividerH]) cube([50,70,frameT+1]);

    // cutout for Bosch CX4 Cover
    linear_extrude(5.6+30)
    translate([33,33,0]) rotate([0,0,74]) {
      square([32.1,5]);
      translate([0,-20,0]) square([25,20]);
    }
    hull() cx4CoverFront();
  }
  difference() {
    body();
    removes();
  }
}

module cx4CoverFrontProfile(s=[1,1,1]) {
  d=1;
  d2=16;
  $fn=20;
  //moveFrontOrgCoverPoint1() translate([boschCoverAdjustmentL,0,0]) sphere(5);
  
    moveFrontOrgCoverPoint1()
      translate([boschCoverAdjustmentL,0,0])
      scale(s)
      rotate([0,0,18])
      rotate([0,-27,0])
      {
        //translate([0,0,-5])
        // Rear left point
        translate([0,.5+d/2,.4])
          rotate([0,180,0])
#          cylinder(h=.1+5,d=d);

        // testing - but need support on outside
        translate([0,.5+d/2,.4])
          rotate([0,27,0])
          rotate([0,0,-18])
          translate([5.5,0,0])
          rotate([0,180,0])
          rotate([0,-27,0])
          rotate([0,0,18])
%          cylinder(h=.1,d=d);
        translate([sqrt(pow(34,2)+pow(15,2))-1,0,0])
        {
          // front left rounded corner
          translate([1-d2/2+1.5,.5,-3.41+d2/2+1])
            rotate([-90,0,0])
            cylinder(h=1,d=d2,$fn=75);
#%          translate([1-d2/2+.8,.5,-3.41+d2/2+1])
            rotate([-90,0,0])
            cylinder(h=1,d=d2,$fn=75);
            //hull()
            {
              // left side front
              translate([1-d2/2,.5+d/2,.6-d])
                rotate([0,180,0])
                cylinder(d=d,h=2);
              // left side rear
              translate([-27,.5+d/2,.6-d])
                rotate([0,180,0])
                cylinder(d=d,h=2);
            }
          } // translate
      } // moveFrontOrgCoverPoint1 / rotate
    frontlipEdge(s=s);
    moveFrontOrgCoverPoint1()
      scale(s)
      translate([boschCoverAdjustmentL+1,1+4*0,2])
      #cylinder(h=coverFrontW-2-4.5,d=1,$fn=20);

}

coverFrontW=45;
//translate([230,50,0]) cube([10,10,totalH]);
module cx4CoverFront(s=[1,1,1]) {
  module solid(s=[1,1,1]) {
    translate([0,0,totalH-coverFrontW])
    hull()
    {
      cx4CoverFrontProfile(s=s);
      // top rear
      toplipEdge(s=s);
    } // hull
  }
  
  difference() {
    solid(s=[1,1,1]);
    translate([4,2.5-10+1,2]) rotate([0,0,2.3])
      solid(s=[0.9,0.75,1]);
          translate([0,0,10])
      linear_extrude(5.6+45)
//      translate([199,91,0])
      translate([197.5,95,0])
      rotate([0,0,-41])
      rotate([0,0,])
      translate([0,-20,0])
      translate([26,15,0])
      square([10,10]);

  }
  frontCoverLip();
}
//cx4CoverFront();

module frontCoverLip() {
 translate([0.5,2.5-10+1,totalH-coverFrontW]) rotate([0,0,0])
  translate([0,0,10])
    intersection() {
  hull()
  {
    toplipEdge(s=[1,1,1]);
    frontlipEdge(s=[1,1,1]);
  }
  translate([0,0,7])
    moveFrontCoverConnectionCircle()
    rotate([0,0,3])
    translate([34/2+1.5-5,-10-25,0])
    cube([5,50,50]);
  }
}

module coverFrontLeftScrewholeBody() {
  $fn=20;
  dist=16.2;
  w=8;
  module moveScrewholeBody() {
      moveFrontOrgCoverPoint1()
      translate([boschCoverAdjustmentL,0,+0.5])
        rotate([0,0,18])
        translate([13,0,0])
    children();
  }
  
  translate([0,0,0])
    difference() {
      hull()      // either this
//      union()   // ot this for debuging
        {
          moveScrewholeBody()
            translate([-6,0,dist])
            #cube([w,1,coverFrontW-dist]); // org: coverFrontW-dist
          moveScrewholeBody()
            translate([0,-11.5,dist])
            cylinder(h=coverFrontW-dist,d=w); // org: coverFrontW-dist
        }
      moveScrewholeBody()
        translate([0,-11.5,0])
        cylinder(h=coverFrontW+10,d=4);
    }
}

//hull() cx4CoverFrontProfile(s=[1,1,1]);
//coverFrontLeftScrewholeBody();

//cx4CoverFront();
    
//difference() {
//  cx4CoverFrontProfile(s=[1,1,1]);
//  #translate([4,2.5-10,2]) rotate([0,0,2])
//  cx4CoverFrontProfile(s=[0.9,0.8,1]);
//}
//scale([0.8,0.8,0.8]) cx4CoverFrontProfile();

module frontlipEdge(s=[1,1,1], d=2) {
    $fn=20;
    moveFrontOrgCoverPoint1()
        scale(s)
        translate([boschCoverAdjustmentL,0,1])
        rotate([0,0,18])
        rotate([0,-27,0])
        translate([sqrt(pow(34,2)+pow(15,2))-1,.5,0])
        rotate([0,27,0])
        rotate([0,0,-18])
        {
          D=2;
          translate([-D*0,D/2/2,0])
            #cylinder(h=24-1,d=d,$fn=20);
//          translate([-d*0,d/2,-2.5])
//            %sphere(d=5);
//  //        translate([-2.5,2.5,-2.5])
//            %cylinder(d=d,h=100);
//          rotate([90,0,0])
//            %cylinder(d=d,h=100);
//          rotate([0,90,0])
//            %cylinder(d=d,h=100);
        }
}
module toplipEdge(s=[1,1,1],d=2) {
  translate([0,0,7])
    moveFrontCoverConnectionCircle()
    scale(s)
    rotate([0,0,30])
    translate([34/2+1.5,0,0])
    cylinder(h=coverFrontW-7-5,d=d,$fn=10);
}



//%linear_extrude(.1) boschCX4LeftImport();
//%linear_extrude(.1) boschCX4RightImport();
//%import("cx4LeftV2.stl");

module leftCoverComplete() {
  cx4CoverLeft();
  cx4CoverFront();
  coverFrontLeftScrewholeBody();
}
translate(getMoveToCenterCX2()*-1)
translate([0,0,45-totalH])
translate([0,0,-40])
leftCoverComplete();

//% translate([0,10,0])
//%import("cx4LeftV3.stl");

//%boschCX4model();
