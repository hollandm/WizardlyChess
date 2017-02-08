#include <Arduino.h>
#include "DRV8825.h" // Provided by: https://github.com/laurb9/StepperDriver 

/**
 * General Settings
 */

// How fast do we want the plotter to move when it is not dragging a peice (mm/s)
#define PLOTTER_SPEED_UNLOADED 40

// How fast do we want the plotter to move when it is dragging a peice (mm/s)
#define PLOTTER_SPEED_LOADED 20

/**
 * Stepper Motor Settings 
 */

// Using a 200 step motor
#define STEPPER_STEPS 200

// Maximum RPM that your stepper can handle (will overide other speed settings)
#define STEPPER_MAX_RPM 150

// What level of microstepping to use
#define STEPPER_MICROSTEP 16

// For every 360 degree of roation of the stepper, how many millimeters does that move the belt
// 	should be close to circumferance of pully attached to stepper motor
#define STEPPER_MM_PER_ROTATION  5;	// Not yet knowm

// Define pins for the stepper motor controlling the x axis
#define PIN_XSTEPPER_DIRECTION 8
#define PIN_XSTEPPER_STEP 9
#define PIN_XSTEPPER_ENABLE 13
#define PIN_XSTEPPER_MS1 10
#define PIN_XSTEPPER_MS2 11
#define PIN_XSTEPPER_MS3 12

/**
 * Main
 */

bool is_plotter_loaded = false;

// using a 200-step motor
// pins used are DIRECTION, STEP, ENABLE, MS1, MS2, MS3 in that order
DRV8825 stepper_x(STEPPER_STEPS, PIN_XSTEPPER_DIRECTION, PIN_XSTEPPER_STEP, PIN_XSTEPPER_ENABLE, PIN_XSTEPPER_MS1, PIN_XSTEPPER_MS2, PIN_XSTEPPER_MS3);

void setup() {
	// Initalize the stepper motor
	stepper_x.setMicrostep(STEPPER_MICROSTEP);

}

void loop() {
	// Make the motor do something
	stepper_x.enable();

	double speed_x = (is_plotter_loaded ? PLOTTER_SPEED_LOADED : PLOTTER_SPEED_UNLOADED)/STEPPER_MM_PER_ROTATION;
	stepper_x.setRPM(speed_x);

	// Tell motor to rotate 360 degrees. That's it.
	stepper_x.rotate(-360);
	delay(1000);
	stepper_x.rotate(180);

	stepper_x.disable();

	delay(5000);

}
