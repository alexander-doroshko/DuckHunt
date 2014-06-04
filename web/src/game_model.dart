part of DuckHunt;


class GameModel {

  static const DUCK_BIRTH_INTERVAL = 1000;
  static const FIRE_LENGTH = 100;

  int gameStartTime;
  int score;

  int lastBirthTime = 0;

  int canvasWidth, canvasHeight;

  Set<Duck> ducks = new Set();

  int mouseX, mouseY;
  int mouseDownX, mouseDownY;

  bool mouseWasDown = false;
  int fireTime = -FIRE_LENGTH;
  bool fireState;

  CanvasRenderingContext2D context2d;

  ImageElement bgImage = new ImageElement(src:'images/background.png');
  ImageElement cursorImage = new ImageElement(src:'images/cursor.png');
  ImageElement cursorFireImage = new ImageElement(src:'images/cursor-fire.png');

  GameModel(CanvasElement canvas) {
    canvasWidth = canvas.width;
    canvasHeight = canvas.height;
    context2d = canvas.context2D;

    mouseX = canvas.width ~/ 2;
    mouseY = canvas.height ~/ 2;

    canvas.onMouseMove.listen(mouseMoved);
    canvas.onMouseDown.listen(mouseDown);
  }

  startGame() {
    gameStartTime = new DateTime.now().millisecondsSinceEpoch;
    score = 0;
  }

  mouseMoved(MouseEvent e) {
    mouseX = e.offset.x;
    mouseY = e.offset.y;
  }

  mouseDown(MouseEvent e) {
    mouseWasDown = true;
    mouseDownX = e.offset.x;
    mouseDownY = e.offset.y;
  }

  nextFrame(int time) {
    if (mouseWasDown) {
      fireTime = time;
      checkHits(time);
      mouseWasDown = false;
    }

    fireState = time - fireTime < FIRE_LENGTH;

    if (time - lastBirthTime > DUCK_BIRTH_INTERVAL) {
      ducks.add(new Duck.newRandomDuck(time, canvasWidth, canvasHeight));
      lastBirthTime = time;
    }

    Set<Duck> toRemove = new Set();
    for (Duck duck in ducks) {
      duck.update(time);
      if (duck.isOutOfScreen(canvasWidth, canvasHeight)) {
        toRemove.add(duck);
      }
    }

    ducks.removeAll(toRemove);

    paint();
    window.requestAnimationFrame(nextFrame);
  }

  checkHits(int time) {
    for (Duck duck in ducks) {
      if (duck.checkHit(time, mouseDownX, mouseDownY)) {
        score++;
      }
    }
  }

  paint() {
    HeadingElement timeHeader = querySelector("#time");
    HeadingElement scoreHeader = querySelector("#score");

    int time = (new DateTime.now().millisecondsSinceEpoch - gameStartTime) ~/ 1000;
    timeHeader.text = "Time: $time";
    scoreHeader.text = "Score: $score";

    context2d.drawImageScaled(bgImage, 0, 0, canvasWidth, canvasHeight);

    for (Duck duck in ducks) {
      duck.paint(context2d);
    }

    if (fireState) {
      context2d.drawImage(cursorFireImage, mouseX - cursorFireImage.width ~/ 2, mouseY - cursorFireImage.height ~/ 2);
    } else {
      context2d.drawImage(cursorImage, mouseX - cursorImage.width ~/ 2, mouseY - cursorImage.height ~/ 2);
    }
  }
}