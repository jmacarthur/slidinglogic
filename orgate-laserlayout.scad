include <orgate-twolayer.scad>

$fn = 20;

translate([170,270]) basePlate();

translate([-40,0]) case1();
translate([-37.5,5]) cell1();
translate([-35,5]) cell2();

translate([55,90]) 
for(i=[0:1]) {
  translate([5+travel+i*(sliderWidth+clear)+10,-36]) inputRod();
  translate([5+travel+i*(sliderWidth+clear),20]) inputBridge();
}

translate([0,-30]) driverod();
translate([100,100]) inputLever();
translate([0,150]) topPlate();
translate([0,270]) basePlate();
translate([80,-10]) rotate([0,0,90]) outputRod();
