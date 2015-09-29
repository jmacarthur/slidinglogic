$fn=10;

slotWidth = 3;
travel = 10;
clear = 0;
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
    square([30,travel*3]);
    if(slot0==1) {
      translate([29,0]) square([1+travel,travel]);
    }
    if(slot1==1) {
      translate([29,travel]) square([1+travel,travel]);
    }
  }
}

module slider(slot0, slot1) {
  difference() {
    square([50,40]);
    translate([10,5]) inputGateSlot();
    translate([travel+20,5]) inputGateSlot();
    translate([5,15]) inputPasser(slot0, slot1);
  } 
}

module flag() {
      translate([0,-travel*3]) square([10, travel*3+1]);
      translate([10,-travel*3])polygon(points=[[0,0], [10,2], [10,8], [0,10]], paths=[[0,1,2,3]]); 
}

module clockbar() {
  color([1.0,0,0]) {
    union() {
      translate([-50,0]) square([190,10]);
      translate([5,0]) flag();
      translate([55+clear,0]) flag();
      translate([105+clear*2,-10]) square([5,15]);
    }
  }
}

module outputPlate()
{
  difference() {
    square([50,20]);
    translate([5,15]) square([2*travel+5,10]);
  }
}

module orgate() {
  slider(0,1);
  translate([50+clear,00]) slider(0,1);
  translate([100+clear*2,20]) outputPlate();
  translate([20,45]) clockbar();
  color([0,0,1.0]) {
    translate([100+clear*2+travel,-15]) square([40,30-clear+5]);
    translate([0,-20-travel]) square([150,20-clear]);
    translate([100+30+clear*2,40]) square([40,5]);
    translate([-10,-20]) square([10,65]);
    translate([-10,55]) square([200,10]);
  }
}

orgate();
