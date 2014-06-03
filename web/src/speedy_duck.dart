part of DuckHunt;

class SpeedyDuck extends Duck {
  static List<ImageElement> _leftDuckImages = [new ImageElement(src:'images/speedyDuck/duck_left_1.png'), new ImageElement(src:'images/speedyDuck/duck_left_2.png'), new ImageElement(src:'images/speedyDuck/duck_left_3.png'), new ImageElement(src:'images/speedyDuck/duck_left_2.png')];
  static List<ImageElement> _rightDuckImages = [new ImageElement(src:'images/speedyDuck/duck_right_1.png'), new ImageElement(src:'images/speedyDuck/duck_right_2.png'), new ImageElement(src:'images/speedyDuck/duck_right_3.png'), new ImageElement(src:'images/speedyDuck/duck_right_2.png')];
  static ImageElement hitDuckImage = new ImageElement(src:'images/speedyDuck/hit.png');
  int imageIndex = 0;

  int get radius => _leftDuckImages[0].width ~/ 2;

  int get speedXMax => 600;

  int get speedYMax => 200;

  update(int time) {
    imageIndex = (time - birthTime) ~/ 100 % _leftDuckImages.length;
    super.update(time);
  }

  paint(CanvasRenderingContext2D context2d) {
    var image;
    if (hit) {
      image = hitDuckImage;
    } else {
      image = speedX > 0 ? _rightDuckImages[imageIndex] : _leftDuckImages[imageIndex];
    }
    context2d.drawImage(image, x - image.width ~/ 2, y - image.height ~/ 2);
  }
}