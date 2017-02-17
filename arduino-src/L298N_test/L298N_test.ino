//L298N_test.ino

#define PIN_ENB 5
#define PIN_IN4 6
#define PIN_IN3 7

#define SPEED_MIN 0
#define SPEED_MAX 255

bool forwards = false;
int speed = 0;
int delta_speed = 25;


void setup() {
  pinMode(PIN_IN3, OUTPUT);
  pinMode(PIN_IN4, OUTPUT);
  pinMode(PIN_ENB, OUTPUT);
}

void loop() {

	if (forwards) {
		digitalWrite(PIN_IN3, HIGH);
		digitalWrite(PIN_IN4, LOW);
	} else {
		digitalWrite(PIN_IN3, LOW);
		digitalWrite(PIN_IN4, HIGH);
	}


	speed += delta_speed;
	if (speed >= SPEED_MAX) {
		speed = SPEED_MAX;
		delta_speed = delta_speed*-1;
	} else if (speed <= SPEED_MIN) {
		speed = SPEED_MIN;
		delta_speed = delta_speed*-1;
		forwards = !forwards;
	}

	// range 0~255
	analogWrite(PIN_ENB, speed);

	delay(1000);

}