import 'package:collection/collection.dart';

class TempPoint {
  final double x;
  final double y;
  TempPoint({required this.x, required this.y});
}

List<TempPoint> get temperaturepoints {
  final data = <double>[2, 4, 6, 11, 3, 6, 4];
  return data
      .mapIndexed(
          (index, element) => TempPoint(x: index.toDouble(), y: element))
      .toList();
}
