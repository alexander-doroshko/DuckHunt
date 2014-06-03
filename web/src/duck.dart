part of DuckHunt;

abstract class Duck {

  static Random _random = new Random();

  int birthTime;
  int x0, y0;
  int speedX, speedY;

  int x, y;

  bool hit = false;

  Duck();

  factory Duck.newRandomDuck(int time, int canvasWidth, int canvasHeight) {
    Duck duck = _random.nextInt(4) == 0 ? new SpeedyDuck() : new LazyDuck();

    int speedXCoeff = _random.nextInt(2) * 2 - 1; // -1 or 1

    duck.birthTime = time;
    duck.x0 = speedXCoeff > 0 ? -duck.radius : canvasWidth + duck.radius;
    duck.y0 = _random.nextInt((canvasHeight - duck.radius * 2) as int) + duck.radius;
    duck.speedX = speedXCoeff * duck.speedXMax;
    duck.speedY = _random.nextInt(duck.speedYMax * 2) - duck.speedYMax;
    return duck;
  }

  int get radius;

  int get speedXMax;

  int get speedYMax;

  update(int time) {
    x = x0 + speedX * (time - birthTime) ~/ 1000;
    y = y0 + speedY * (time - birthTime) ~/ 1000;
  }

  bool checkHit(int time, int x, int y) {
    if (!hit && sqrt((x - this.x) * (x - this.x) + (y - this.y) * (y - this.y)) < radius) {
      hit = true;
      x0 = this.x;
      y0 = this.y;
      speedX = 0;
      speedY = 200;
      birthTime = time;
      return true;
    }
    return false;
  }

  paint(CanvasRenderingContext2D context2d);
}