import 'package:test/test.dart';
import 'package:wallet/fieldelement.dart';
import 'package:wallet/point.dart';

void main() {
  group('elliptic curve point tests', () {
    test(
        'point addition (170,142) + (60,139) must be (220,181) on field 223, curve x^3+7',
        () {
      final prime = 223;
      final x1 = FieldElement.fromInt(170, prime);
      final y1 = FieldElement.fromInt(142, prime);
      final x2 = FieldElement.fromInt(60, prime);
      final y2 = FieldElement.fromInt(139, prime);
      final a = FieldElement.fromInt(0, prime);
      final b = FieldElement.fromInt(7, prime);

      final xr = FieldElement.fromInt(220, prime);
      final yr = FieldElement.fromInt(181, prime);

      final point1 = Point(x1, y1, a, b);
      final point2 = Point(x2, y2, a, b);
      final result = point1 + point2;
      final expected = Point(xr, yr, a, b);
      expect(result, expected);
    });
    test('addition (47,71) + (17,56) must be (215,68) field 223, curve x^3+7',
        () {
      final prime = 223;
      final x1 = FieldElement.fromInt(47, prime);
      final y1 = FieldElement.fromInt(71, prime);
      final x2 = FieldElement.fromInt(17, prime);
      final y2 = FieldElement.fromInt(56, prime);
      final a = FieldElement.fromInt(0, prime);
      final b = FieldElement.fromInt(7, prime);

      final xr = FieldElement.fromInt(215, prime);
      final yr = FieldElement.fromInt(68, prime);

      final point1 = Point(x1, y1, a, b);
      final point2 = Point(x2, y2, a, b);
      final result = point1 + point2;
      final expected = Point(xr, yr, a, b);
      expect(result, expected);
    });
  });
}
