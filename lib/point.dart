import 'package:wallet/fieldelement.dart';

class Point {
  FieldElement _x, _y, _a, _b;

  Point(FieldElement x, FieldElement y, FieldElement a, FieldElement b)
      : _a = a,
        _b = b,
        _x = x,
        _y = y {
    if (x == null && y == null) {
      return;
    }
    if (y.pow(BigInt.two) != (x.pow(BigInt.from(3)) + (a * x) + b)) {
      throw Exception(
          "Point (${_x},${_y}) not on the curve x^3+${_a}*x+${_b}!");
    }
  }

  FieldElement get a => _a;
  FieldElement get b => _b;
  FieldElement get x => _x;
  FieldElement get y => _y;

  String toString() {
    return "Point($_x,$_y)_$_a$_b";
  }

  bool operator ==(covariant Point other) {
    return (_x == other._x) &&
        (_y == other._y) &&
        (_a == other._a) &&
        (_b == other._b);
  }

  Point operator *(BigInt coef) {
    var c = coef;
    var current = this;
    var result = this;
    result._x = null;
    result._y = null;
    while (c != BigInt.zero) {
      if (c & BigInt.one > BigInt.zero) {
        result += current;
      }
      current += current;
      c >>= 1;
    }
    return result;
  }

  Point operator +(covariant Point other) {
    if (_a != other._a || _b != other._b) {
      throw Exception("Points ${this} and ${other} are not on the same curve.");
    }

    if (_x == null) {
      // this is the point at infinity, return the other
      return other;
    }

    if (other._x == null) {
      // other is the point at infinity, return this
      return this;
    }

    if (other._x == _x && other._y != _y) {
      return Point(null, null, _a, _b);
    }

    if (_x != other._x) {
      var slope = (other._y - _y) / (other._x - _x);
      var new_x = slope.pow(BigInt.two) - _x - other._x;
      var new_y = slope * (_x - new_x) - _y;
      return Point(new_x, new_y, _a, _b);
    }

    if (this == other) {
      var prime = _x.getPrime();
      var three = FieldElement(BigInt.from(3), prime);
      var two = FieldElement(BigInt.two, prime);
      var slope = (three * _x.pow(BigInt.two) + _a) / (two * _y);
      var new_x = slope.pow(BigInt.two) - (two * _x);
      var new_y = (slope * (_x - new_x)) - _y;
      return Point(new_x, new_y, _a, _b);
    }

    if (this == other && _y.isZero()) {
      return Point(null, null, _a, _b);
    }
  }
}
