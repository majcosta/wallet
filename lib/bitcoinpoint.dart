/* import "dart:math";
import "package:wallet/fieldelement.dart";

class BitcoinPoint {
  FieldElement _x, _y, _a, _b;

  BitcoinPoint(FieldElement x, FieldElement y, FieldElement a, FieldElement b) {
    _a = a;
    _b = b;
    _x = x;
    _y = y;
    if (x == null && y == null) {
      return;
    }
    if (y.pow(2) != (x.pow(3) + (a * x) + b)) {
      throw Exception(
          "Point (${_x},${_y}) not on the curve x^3+${_a}*x+${_b}!");
    }
  }

  String toString() {
    return "(${_x},${_y})";
  }

  bool operator ==(covariant BitcoinPoint other) {
    return (_x == other._x) &&
        (_y == other._y) &&
        (_a == other._a) &&
        (_b == other._b);
  }

  BitcoinPoint operator +(covariant BitcoinPoint other) {
    if (_a != other._a || _b != other._b) {
      throw Exception("Points ${this} and ${other} are not on the same curve.");
    }

    if (_x == null) {
      return other;
    }

    if (other._x == null) {
      return this;
    }

    if (other._x == _x && other._y != _y) {
      return BitcoinPoint(null, null, _a, _b);
    }

    if (_x != other._x) {
      var slope = (other._y - _y) / (other._x - _x);
      var new_x = slope.pow(2) - _x - other._x;
      var new_y = slope * (_x - new_x) - _y;
      return BitcoinPoint(new_x, new_y, _a, _b);
    }

    if (this == other) {
      var slope = FieldElement(3 * _x.pow(2) + _a) / (2 * _y));
      var new_x = slope.pow(2) - (2 * _x);
      var new_y = slope * (_x - new_x) - _y;
      return BitcoinPoint(new_x, new_y, _a, _b);
    }

    if (this == other && _y == 0) {
      return BitcoinPoint(null, null, _a, _b);
    }
  }
}
 */
