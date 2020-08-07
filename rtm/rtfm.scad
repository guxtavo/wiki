/**
Raspberry Pi Keyboard (UK layout) specifications
  * 79 keys
  * 3x USB 2.0 type-A ports for connecting other peripherals
  * USB type-A to micro USB type-B cable for connection (1m)
  * Dimensions: 285x120x22mm
**/

$fn=50;

minkowski(){
    cube([285,120,22], center=true);
    sphere(5);
}
