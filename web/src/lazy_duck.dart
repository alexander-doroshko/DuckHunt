part of DuckHunt;

class LazyDuck extends Duck {
  static List<ImageElement> _leftDuckImages = [new ImageElement(src:'images/lazyDuck/duck_left_1.png'), new ImageElement(src:'images/lazyDuck/duck_left_2.png'), new ImageElement(src:'images/lazyDuck/duck_left_3.png'), new ImageElement(src:'images/lazyDuck/duck_left_2.png')];
  static List<ImageElement> _rightDuckImages = [new ImageElement(src:'images/lazyDuck/duck_right_1.png'), new ImageElement(src:'images/lazyDuck/duck_right_2.png'), new ImageElement(src:'images/lazyDuck/duck_right_3.png'), new ImageElement(src:'images/lazyDuck/duck_right_2.png')];
  static ImageElement hitDuckImage = new ImageElement(src:'images/lazyDuck/hit.png');
  int imageIndex = 0;

  int get duckRadius => _leftDuckImages[0].width ~/ 2;

  int get speedXMax => 300;

  int get speedYMax => 50;

  update(int time) {
    imageIndex = (time - birthTime) ~/ 200 % _leftDuckImages.length;
    super.update(time);
  }

  paint(CanvasRenderingContext2D context2d) {
    var image;
    if (speedX == 0) {
      image = hitDuckImage;
    } else {
      image = speedX > 0 ? _rightDuckImages[imageIndex] : _leftDuckImages[imageIndex];
    }
    context2d.drawImage(image, duckX - image.width ~/ 2, duckY - image.height ~/ 2);
  }
}