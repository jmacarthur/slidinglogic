include <orgate-twolayer.scad>

// Animation variables
phase = ($t*4.0)%1.0;
PI=3.1415;
anim_driveRod = (phase < 0.8) ? -travel*sin(phase*1.25*360) : 0;
anim_driveLever = (phase < 0.8) ? -11.37*sin(phase*1.25*360) : 0;

input1 = ($t < 0.5)? 0: 1;
input2 = ($t % 0.5 < 0.25)?0:1;

old_time = ($t + 0.75) % 1.0;
next_time = ($t + 0.25) % 1.0;

prev_input1 = (old_time < 0.5)? 0: 1;
prev_input2 = (old_time % 0.5 < 0.25)? 0: 1;

next_input1 = (next_time < 0.5)? 0: 1;
next_input2 = (next_time % 0.5 < 0.25)? 0: 1;

input_either = (input1 + input2 > 0)?1:0;
prev_input_either = (prev_input1 + prev_input2 > 0)?1:0;

// In 'phase 5' blend between 
blend = 5*(phase - 0.8);
antiblend = 1-blend;
gate1v = phase > 0.8 ? (blend*next_input1 + antiblend*input1) : input1;
gate2v = phase > 0.8 ? (blend*next_input2 + antiblend*input2) : input2;

anim_gates = (phase < 0.20)? anim_driveRod + travel :
  (phase < 0.40) ? 0:
  (phase < 0.60) ? anim_driveRod:
  travel;

anim_gate1 = (phase < 0.4) ? anim_gates * prev_input1 : anim_gates * input1;
anim_gate2 = (phase < 0.4) ? anim_gates * prev_input_either : anim_gates * input_either;

anim_output = anim_gate2;


// Add dowels?
module dowel() {
  color([1,1,0]) translate([0,0,0]) cylinder(d=3,h=6);
}

// Acutal objects

translate([0,0,3]) color([0.5,0.5,0.5]) linear_extrude(height=3) basePlate();

color([0.0,0.8,0]) linear_extrude(height=3) case1();
translate([anim_gate1,travel*gate1v,0]) color([1.0,0,0]) linear_extrude(height=3) cell1();
translate([anim_gate2,travel*gate2v,0]) color([1.0,0,0]) linear_extrude(height=3) cell2();

translate([anim_output+sliderWidth*2+clear*2,15+travel-5]) linear_extrude(height=3) outputRod();  

translate([5+travel, 0, 0]) {
  translate([0,travel*gate1v,0]) {
    translate([10,-36,00]) color([0.0,0.0,1.0])  linear_extrude(height=3) inputRod();
    translate([0,5,-3]) color([0.0,0.5,1.0,0.5])  linear_extrude(height=3) inputBridge();
    translate([10,-6,-3]) dowel();
    translate([20,5,-3]) dowel();
    translate([0,5,-3]) dowel();

  }
  translate([sliderWidth+clear,travel*gate2v,0]) {
    translate([10,-36,0]) color([0.0,0.0,1.0])  linear_extrude(height=3) inputRod();
    translate([0,5,-3]) color([0.0,0.5,1.0,0.5])  linear_extrude(height=3) inputBridge();
    translate([10,-6,-3]) dowel();
    translate([20,5,-3]) dowel();
    translate([0,5,-3]) dowel();
  }
}
translate([anim_driveRod,5+travel*2,-3]) {
  color([0,0,1.0,0.5]) linear_extrude(height=3) driverod(); 
  translate([-30,0,0]) dowel();
  translate([15,0,0]) dowel();
  translate([55,0,0]) dowel();
  translate([95,0,0]) dowel();
}

translate([-30,5+travel*2-50,0])  translate([0,inputLeverLen])  {
  color([0,0,1.0]) linear_extrude(height=3) rotate([0,0,anim_driveLever]) inputLever();
  translate([0,0,-3]) dowel();
}

translate([0,0,-3]) color([0.5,0.5,0.5,0.5]) linear_extrude(height=3) topPlate();
//translate([0,0,-6]) color([0.5,0.5,0.5,0.1]) linear_extrude(height=3) basePlate();

