use <boschImports_v4.scad>

use <cx4LeftV4.scad>

use <bezier_curve.scad>

 module cx4CoverLeftStl() {
  import("cx4LeftV4_cosin_test.stl");
}

 module cx4CoverRightStl() {
  %import("cx4RightV2_cover.stl");
  %import("cx4RightV2_front.stl");
}
//cx4CoverRightStl();


frontAngle=18;
L1=35.5+14+2-.2+2;
Y1=69;
module boschCX2CoverOnCX4RightOutlined(offsetV=0) {
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
  bezier_fn = ($preview) ? 31:90;
  bezier_curve(bezier_curve_points, bezier_fn) circle(0.2);
}

cxSizeOffset=2;
module boschCX4EggCover(offsetV=0) {
  difference() {
    union() {
      hull()
        boschCX2CoverOnCX4RightOutlined(offsetV=offsetV);
//      offset(offsetV)
      hull() {
        translate([23+10/2-offsetV/2,60+offsetV*0,0]) circle(d=40+10-offsetV);
        translate([42+10/2-offsetV/2,72+offsetV*0,0]) circle(d=10+10-offsetV);
        translate([62+10/2-offsetV/2,42+offsetV*0,0]) circle(d=10+10-offsetV);
        moveToCenterCX4() circle(d=80-offsetV);
      }
    }

    //Version 1
    // CX4 Cover
    //if (true==false)
    /*
    offset(offsetV)
    hull() {
      $fn=100;
      #moveToCenterCX4() circle(d=60-cxSizeOffset);
      #moveToCenterCX4() translate([35,12,0]) circle(d=55-cxSizeOffset);
      #moveToCenterCX4() translate([35,-60,0]) 
      intersection()
      {
        circle(d=200-cxSizeOffset);
        rotate([0,0,15]) translate([-25,90,0]) square([50,50]);
        
      }
      #moveToCenterCX4() translate([70,11,0]) circle(d=55-cxSizeOffset);
      #moveToCenterCX4() translate([70,11,0]) rotate([0,0,-37]) square([55,(55-cxSizeOffset)/2]);
    }
    */
    
    // CX4 Cover
    //if (true==false)
    offset(offsetV)
    difference() {
    hull() {
      $fn=100;
      moveToCenterCX4() circle(d=60-cxSizeOffset);
        // Version 2
        moveToCenterCX4()
        translate([0,30,0])
        rotate([0,0,-25]) translate([119,0,0])
        {
          circle(d=55-cxSizeOffset);
          rotate([0,0,2]) square([55,(55-cxSizeOffset)/2]);
        };
    }
    moveToCenterCX4() circle(d=80-cxSizeOffset);
    }
    moveToCenterCX4() circle(d=54-cxSizeOffset);

    //offset(offsetV)
    //translate([L1,67,0]) rotate([0,0,72]) translate([0,-10+.75-cxSizeOffset/2,0]) square([18,10]);
  }
}
//translate([0,0,-1]) boschCX4EggCover();


module moveFrontOrgCoverPoint1() {
  translate([199,91,40+5+.8])
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

//hull() cx4CoverFrontProfile(s=[1,1,1]);

//moveFrontOrgCoverPoint1() sphere(5);
boschCoverAdjustmentL=26;
module cx4CoverFrontProfile(s=[1,1,1]) {
  d=1;
  d2=16;
  $fn=20;
  //moveFrontOrgCoverPoint1() translate([boschCoverAdjustmentL,0,0]) sphere(5);
  
    moveFrontOrgCoverPoint1()
     mirror([0,0,1])
      translate([boschCoverAdjustmentL,0,-4])
      scale(s)
      rotate([0,0,18])
      rotate([0,-27,0])
      {
        //translate([0,0,-5])
        // Rear left point
        translate([0,.5+d/2,.4])
          rotate([0,180,0])
#          cylinder(h=.1,d=d);
        translate([sqrt(pow(34,2)+pow(15,2))-1,0,0])
        {
          // front left rounded corner
#          translate([1-d2/2+1.5,.5,-3.41+d2/2+1])
            rotate([-90,0,0])
            cylinder(h=1,d=d2,$fn=75);
%          translate([1-d2/2+.8,.5,-3.41+d2/2+1])
            rotate([-90,0,0])

            cylinder(h=1,d=d2,$fn=75);
            //hull()
            {
              // left side front
#              translate([1-d2/2,.5+d/2,.6-d])
                rotate([0,180,0])
                cylinder(d=d,h=2);
              // left side rear
//%#              translate([-27,.5+d/2,.6-d])
//                rotate([0,180,0])
//                cylinder(d=d,h=2);
            }
          } // translate
      } // moveFrontOrgCoverPoint1 / rotate
    frontlipEdge(s=s);
    moveFrontOrgCoverPoint1()
     mirror([0,0,1])
      scale(s)
      translate([boschCoverAdjustmentL,1,2-4])
      cylinder(h=45-2+.80+4,d=1,$fn=20);

}
//cx4CoverFrontProfile();

module frontlipEdge(s=[1,1,1],d=2) {
    $fn=20;
    moveFrontOrgCoverPoint1()
      mirror([0,0,1])
        scale(s)
        translate([boschCoverAdjustmentL,0,1])
        rotate([0,0,18])
        rotate([0,-27,0])
        translate([sqrt(pow(34,2)+pow(15,2))-1,.5,0])
        rotate([0,27,0])
        rotate([0,0,-18])
        {
          translate([-d*0,d/2/2,0])
            cylinder(h=29-.62,d=d,$fn=20);
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
    cylinder(h=coverFrontW-7,d=d,$fn=10);
}

coverFrontW=45;
module cx4CoverFront(s=[1,1,1], withConnectionLip=true) {
  intersection() {
    cx4CoverFrontRaw(s=[1,1,1], withConnectionLip=true);
    hull()
    cx4CoverFrontRaw(s=[1,1,1], withConnectionLip=false);
  }
  if (withConnectionLip==true)
  intersection() {
    cx4CoverFrontRaw(s=[1,1,1], withConnectionLip=true);
    moveFrontCoverConnectionCircle() cube([30,20,20]);
  }
}
module cx4CoverFrontRaw(s=[1,1,1], withConnectionLip=true) {
  module solid(s=[1,1,1]) {
    hull()
    {
      cx4CoverFrontProfile(s=s);
      // top rear
      translate([0,0,-7+5])
        moveFrontCoverConnectionCircle()
        //mirror([0,0,1])
        #scale(s) rotate([0,0,30]) translate([34/2+1.5,0,2]) cylinder(h=45-7+4,d=2.08,$fn=10);

    } // hull
  }
  
  difference() {
    union() {
      solid(s=[1,1,1]);
      coverFrontRightScrewholeBody();
    }
    //translate([4,2.5-10+1,-2]) rotate([0,0,2]) solid(s=[0.9,0.75,1]);
    translate([4,2.5-10+1,-2-7]) rotate([0,0,2.3]) solid(s=[0.9,0.75,1]);

    translate([0,0,-45]) frontCoverLip();
    
    coverScrewholeBodyLink();
    coverScrewholeBodyLink(cut=0);
  }
  if (withConnectionLip==true)
  frontCoverLipRight();
}

module frontCoverLipRight() {
  difference() {
    translate([0.5,2.5-10+1,totalH-coverFrontW-2]) rotate([0,0,0])
    translate([0,0,00])
    intersection() {
      hull()
      {
        toplipEdge(s=[1,1,1],d=8);
        frontlipEdge(s=[1,1,1],d=8);
      }
      translate([0,0,7])
      moveFrontCoverConnectionCircle()
      rotate([0,0,3])
      translate([34/2+1.5-5,-10-27.5,0])
      cube([5,50,55]);
    }
    translate([0,0,-45]) frontCoverLip();
  }
}

//cx4CoverFront();
//coverFrontRightScrewholeBody();

//%#translate([0,0,40]) cube([250,200,20]);
  module moveScrewholeBody() {
      moveFrontOrgCoverPoint1()
      mirror([0,0,1])
      translate([boschCoverAdjustmentL,0,0])
        rotate([0,0,18])
        translate([13,0,5.5])
    children();
  }
module coverFrontRightScrewholeBody(dist=11.2-7) {
  $fn=20;
  w=8;
  
  difference() {
    hull()
        {
          moveScrewholeBody()
            translate([-6,0,dist])
            cube([w,1,totalH-dist]);
          moveScrewholeBody()
            translate([0,-11.5,dist])
            cylinder(h=totalH-dist,d=w);
        }
    moveScrewholeBody()
      translate([0,-11.5,0])
      cylinder(h=totalH+1,d=4);
  }
}

module coverScrewholeBodyLink(cut=5) {
  dist=totalH;
  linkT=10;
  linkL=32;
  coverFrontRightScrewholeBody(dist=totalH-linkT);
  translate([0,0,-.3])
    moveScrewholeBody() rotate([0,0,-8])
    {
//      %translate([10-linkL,0,dist-linkT]) cube([linkL-5,5,linkT-cut]);
      hull() {
        translate([2-9,0,dist-linkT]) cube([9,5,linkT-cut]);
        translate([5-linkL,0,dist-linkT-cut*2]) cube([10,5,5]);
      }
      translate([5-linkL,0,0]) cube([10,5,totalH-linkT-cut*2]);
    }
}
module rightCoverComplete() {
  difference()
  {
    cx4CoverRight();
    hull() cx4CoverFront(withConnectionLip=false);
  }
  coverScrewholeBodyLink();

}
//rightCoverComplete();
//cx4CoverFront();
//translate([0,0,-10])
//%#cube([250,150,10]);

frameT=20;
coverH=20;
totalH=coverH+frameT;
H=totalH;
dividerH=7;
step=($preview) ? .5:.2;
stepCosSin=step*10;
wallT=1;
wallT2=2;
module cx4CoverRight() {
  module body_front_easy_print() {
    for (h=[0:step:dividerH])
    translate([0,0,H-dividerH+h])
    linear_extrude(step) {
      difference() {
        offsetVcalc=-wallT*h;

        union() {
          offset(r=-wallT*h) boschCX4EggCover(offsetV=offsetVcalc);
//          intersection() {
//            offset(r=-2*h) boschCX4EggCover(offsetV=-2*h);
//            moveScrewHoleTopFront() circle(d=12);
//            moveScrewHoleTopRear() circle(d=12);
//          }
        }
        if ((dividerH-h)>2) offset(r=offsetVcalc-2) {
          difference() {
            boschCX4EggCover(offsetV=offsetVcalc);
            moveScrewHoleTopFront() circle(d=12);
            moveScrewHoleTopRear() circle(d=12);
          }
          translate([10,0]) square([208,105]);
          translate([50,50]) square([145,80]);
        }
      }
    }
  }
  module body_front_cos_sin() {
    for (a=[0:stepCosSin:90]) {
      radi=dividerH;
      h=sin(a)*radi;
      translate([0,0,H-dividerH+h])
      linear_extrude(sin(a+stepCosSin)*radi-sin(a)*radi) {
        difference() {
          offsetVcalc=-wallT*h;

          union() {
  //          offset(r=-wallT*h) boschCX4EggCover(offsetV=offsetVcalc);
          offsetVcalc=($preview) ? -radi+cos(a)*radi:-radi+cos(a)*radi;
            offset(r=offsetVcalc) boschCX4EggCover(offsetV=offsetVcalc);

  //          intersection() {
  //            offset(r=-2*h) boschCX4EggCover(offsetV=-2*h);
  //            moveScrewHoleTopFront() circle(d=12);
  //            moveScrewHoleTopRear() circle(d=12);
  //          }
          }
          if ((dividerH-h)>2) offset(r=offsetVcalc-2) {
            difference() {
              boschCX4EggCover(offsetV=offsetVcalc);
              moveScrewHoleTopFront() circle(d=12);
              moveScrewHoleTopRear() circle(d=12);
            }
            translate([10,0]) square([208,105]);
            translate([50,50]) square([145,80]);
          }
        }
      }
    }
  }

  module body() {
  
    body_front_easy_print();
//    body_front_cos_sin();

    // sidewalls
    //#translate([0,0,dividerH])
    linear_extrude(H-dividerH) {
      difference() {
        boschCX4EggCover();
        offset(r=-wallT2) boschCX4EggCover();
          translate([10,0]) square([208,105]);
          translate([50,50]) square([145,80]);
      }
      moveScrewHoleTopFront() circle(d=12);
      moveScrewHoleTopRear() circle(d=12);
    }
  }
  module removes() {
    $fn=20;
    moveScrewHoleTopFront() cylinder(h=20+16,d=3);
    moveScrewHoleTopRear() cylinder(h=20+16,d=3);
//    #moveScrewHoleTopFront() cylinder(h=17,d=8.5);
//    moveScrewHoleTopRear() cylinder(h=17,d=8.5);
  
/*  
    if (false==true)
    %linear_extrude(5.6)
    //#hull()
    {
      $fn=100;
      // axle
      moveToCenterCX4() circle(d=60-cxSizeOffset);
      moveToCenterCX4() translate([35,12,0]) circle(d=55-cxSizeOffset);
      moveToCenterCX4() translate([35,-60,0]) 
      intersection()
      {
        circle(d=200-cxSizeOffset);
        rotate([0,0,15]) translate([-25,90,0]) square([50,50]);
      }
      moveToCenterCX4() translate([70,11,0]) circle(d=55-cxSizeOffset);
    }
*/
    // frame
    translate([0,30,0]) cube([200,170,20]);
    translate([190,121,0]) cube([50,50,20]);
  }
  difference() {
    body();
    removes();
  }
}

translate(getMoveToCenterCX2()*-1)
rightCoverComplete();
//translate(getMoveToCenterCX2()*-1)
//cx4CoverFront();
//%cx4CoverLeftStl();

//intersection() {
//  translate(getMoveToCenterCX2()*-1)
//  rightCoverComplete();
//  cx4CoverLeftStl();
//}

//%translate([0,0,38]) boschCX4RightImport();
//%boschCX4model();
//%cx4CoverLeftStl();