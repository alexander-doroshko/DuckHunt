part of DuckHunt;

abstract class Duck {

  static Random _random = new Random();

  int birthTime;
  int x0, y0;
  int speedX, speedY;

  int duckX, duckY;

  Duck();

  factory Duck.newRandomDuck(int time, int canvasWidth, int canvasHeight) {
    Duck duck = _random.nextInt(4) == 0 ? new SpeedyDuck() : new LazyDuck();

    int speedXCoeff = _random.nextInt(2) * 2 - 1; // -1 or 1

    duck.birthTime = time;
    duck.x0 = speedXCoeff > 0 ? -duck.duckRadius : canvasWidth + duck.duckRadius;
    duck.y0 = _random.nextInt((canvasHeight - duck.duckRadius * 2) as int) + duck.duckRadius;
    duck.speedX = speedXCoeff * duck.speedXMax;
    duck.speedY = _random.nextInt(duck.speedYMax * 2) - duck.speedYMax;
    return duck;
  }

  int get duckRadius;

  int get speedXMax;

  int get speedYMax;

  update(int time) {
    duckX = x0 + speedX * (time - birthTime) ~/ 1000;
    duckY = y0 + speedY * (time - birthTime) ~/ 1000;
  }

  bool checkHit(int time, int x, int y) {
    if (sqrt((x - this.duckX) * (x - this.duckX) + (y - this.duckY) * (y - this.duckY)) < duckRadius && speedX != 0) {
      x0 = this.duckX;
      y0 = this.duckY;
      speedX = 0;
      speedY = 200;
      birthTime = time;
      return true;
    }
    return false;
  }

  bool isOutOfScreen(int screenWidth, int screenHeight)
    => duckX < -duckRadius ||
       duckX > screenWidth + duckRadius ||
       duckY < -duckRadius ||
       duckY > screenHeight + duckRadius;

  paint(CanvasRenderingContext2D context2d);
}