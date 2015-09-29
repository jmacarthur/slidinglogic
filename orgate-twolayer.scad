$fn=10;
	
slotWidth = 3;
travel = 10;
clear = 0.1;
tolerance = 3;
sliderWidth = 40;
sliderHeight = 35;
inputLeverLen = 100;

module inputGateSlot()
{
  union() {
    circle(r=slotWidth/2);
    translate([travel,0]) circle(r=slotWidth/2);
    translate([0,-slotWidth/2]) square([travel,slotWidth]);
  }
}

module inputPasser(slot0, slot1)
{
  union() {
    hull() {
      translate([0,0]) circle(r=slotWidth/2);
      translate([0,travel]) circle(r=slotWidth/2);
      translate([travel,0-tolerance]) circle(r=slotWidth/2);
      translate([travel,travel+tolerance]) circle(r=slotWidth/2);
    }
    if(slot0 == 1) {
       hull() {
         translate([travel,0+tolerance]) circle(r=slotWidth/2);
         translate([travel,0-tolerance]) circle(r=slotWidth/2);
         translate([travel*2,0]) circle(r=slotWidth/2);
       }
    }
    if(slot1 == 1) {
       hull() {
       translate([travel,travel-tolerance]) circle(r=slotWidth/2);
       translate([travel,travel+tolerance]) circle(r=slotWidth/2);
       translate([travel*2,travel]) circle(r=slotWidth/2);
       }
    }
  }
}

module slider(slot0, slot1) {
  difference() {
    square([sliderWidth,sliderHeight]);
    translate([5,5]) inputGateSlot();
    translate([travel+15,5]) inputGateSlot();
    translate([5,15]) inputPasser(slot0, slot1);
  } 
}

module driverod() {
  difference() {
    hull() {
      translate([-30,0]) circle(r=5);
      translate([95,0]) circle(r=5);
    }   
    translate([-30,0]) circle(r=slotWidth/2);
    translate([5+travel,0]) circle(r=slotWidth/2);
    translate([sliderWidth+clear+5+travel,0]) circle(r=slotWidth/2);
    translate([sliderWidth*2+clear*2+5+travel,0]) circle(r=slotWidth/2);
  }
} 

module outputRod() {
  difference() {
    union() {
      square([35,10]);
      translate([35,5])circle(r=5);
    }
    hull() {
      translate([5,5]) circle(r=slotWidth/2);
      translate([5+travel*2,5]) circle(r=slotWidth/2);
    }
    translate([5+travel*3,5]) circle(r=slotWidth/2);
  }
}

module cell1() {
  slider(0,1);
}

module cell2() {
  translate([sliderWidth+clear,0]) slider(0,1);
}

module inputBridge() {
  difference() {
      hull() {
      translate([0,0]) circle(r=5);
      translate([travel+10,0]) circle(r=5);
      translate([travel/2+5,-11]) circle(r=5);
    }
    translate([travel/2+5,-11]) circle(r=slotWidth/2);
    translate([travel+10,0]) circle(r=slotWidth/2);
    translate([0,0]) circle(r=slotWidth/2);
  }
}

module inputRod() {
  difference() {
    union() {
      hull() {
	translate([0,-10]) circle(r=5);
	translate([0,30]) circle(r=5);
      }
      translate([0,-10]) circle(r=8, $fn=20);
    }
    translate([0,-10]) circle(r=slotWidth/2);
    translate([0,30]) circle(r=slotWidth/2);
  }
}



module inputLever() {
  translate([0,-inputLeverLen]) {
  difference() {
    hull() {
      translate([0,-10]) circle(r=5);
      translate([0,inputLeverLen]) circle(r=5);
    }
    translate([0,inputLeverLen]) circle(r=slotWidth/2);
    hull() {
      translate([0,45]) circle(r=slotWidth/2);
      translate([0,55]) circle(r=slotWidth/2);
    }
  }
  }
}


module caseHoles() {
    translate([95,-10]) circle(r=slotWidth/2);
    translate([95,50]) circle(r=slotWidth/2);
    translate([-5,50]) circle(r=slotWidth/2);

    translate([55,-10]) circle(r=slotWidth/2);
    translate([35,-10]) circle(r=slotWidth/2);
    translate([0,-10]) circle(r=slotWidth/2);
}

module case1() {
  difference() {
   translate([-10,-20]) square(size=[110,75]);
   square(size=[sliderWidth*2+clear*2+travel,sliderHeight+travel+clear]); // Central section
   translate([sliderWidth*2+clear*2,10+travel]) square(size=[100,10+clear]);
   for(i=[0:1]) {
     translate([10+travel+(sliderWidth+clear)*i,-30]) square(size=[10,50]); // Holes for input levers
   }
   translate([-30,inputLeverLen+5+travel*2-50]) rotate(11.3) inputLever();
   caseHoles();
  }
}

module basePlate() {
  difference() {
  hull() {
    translate([0,-25]) circle(r=5);
    translate([-40,25]) circle(r=5);
    translate([100,-25]) circle(r=5);
    translate([100,55]) circle(r=5);
    translate([-30,75]) circle(r=5);
  }
    translate([-30,75]) circle(r=slotWidth/2);
    caseHoles();
   }

}

module topPlate() {
  fudge=5;
  difference() {
    basePlate();
    for(i=[0:1]) {
      translate([5+i*(sliderWidth+clear),5]) {
	hull() {
	  for(v=[0:1]) {
	    translate([travel,v*(travel+fudge)]) inputBridge();
	  }
	}
      }
    }
   hull() {
      translate([-5,5+travel*2]) {
     for(v=[0:1]) {
       translate([v*(2*travel+fudge)-10,0]) driverod();
      }
     }
   }
    translate([-30,75]) circle(r=slotWidth/2);
    caseHoles();
  }
}


