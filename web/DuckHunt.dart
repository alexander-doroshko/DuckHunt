library DuckHunt;

import 'dart:html';
import 'dart:math';

part 'src/game_model.dart';
part 'src/duck.dart';
part 'src/lazy_duck.dart';
part 'src/speedy_duck.dart';

void main() {
  CanvasElement canvas = querySelector('#canvas');

  GameModel gameModel = new GameModel(canvas);
  gameModel.startGame();
  window.requestAnimationFrame(gameModel.nextFrame);
}
