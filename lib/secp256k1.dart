final p = BigInt.two.pow(256) - BigInt.two.pow(32) - BigInt.from(977);

class FieldSecp256k1 {
  BigInt _num;
  BigInt _prime;

  FieldSecp256k1(BigInt number)
      : _num = number,
        _prime = p;

  FieldSecp256k1.fromInt(int number, int prime)
      : _num = BigInt.from(number),
        _prime = BigInt.from(prime);

  bool isZero() {
    return _num == BigInt.zero;
  }

  BigInt getPrime() {
    return _prime;
  }

  BigInt getNum() {
    return _num;
  }

  bool operator ==(covariant FieldSecp256k1 other) =>
      other._prime == _prime && other._num == _num;

  FieldSecp256k1 operator +(covariant FieldSecp256k1 other) {
    if (other._prime != _prime) throw Exception("Different fields");
    return FieldSecp256k1((_num + other._num) % _prime);
  }

  FieldSecp256k1 operator -(covariant FieldSecp256k1 other) {
    if (other._prime != _prime) throw Exception("Different fields");
    return FieldSecp256k1((_num - other._num) % _prime);
  }

  FieldSecp256k1 operator *(covariant FieldSecp256k1 other) {
    if (other._prime != _prime) throw Exception("Different fields");
    return FieldSecp256k1((_num * other._num) % _prime);
  }

  FieldSecp256k1 pow(BigInt exponent) {
    var non_negative_exponent = exponent % (_prime - BigInt.one);
    return FieldSecp256k1(_num.modPow(non_negative_exponent, _prime));
  }

  FieldSecp256k1 operator /(covariant FieldSecp256k1 other) {
    if (other._prime != _prime) throw Exception("Different fields");
    if (other._num == BigInt.zero) throw Exception("Can't divide by zero");
    var result =
        (_num * other._num.modPow(_prime - BigInt.two, _prime) % _prime);
    return FieldSecp256k1(result);
  }

  String toString() {
    return "($_num,$_prime)";
  }
}

final secp256k1_a = BigInt.zero;
final secp256k1_b = BigInt.from(7);
final n = BigInt.parse(
    "0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141");

class PointSecp256k1 {
  FieldSecp256k1 _x, _y, _a, _b;

  PointSecp256k1(FieldSecp256k1 x, FieldSecp256k1 y)
      : _a = FieldSecp256k1(secp256k1_a),
        _b = FieldSecp256k1(secp256k1_b),
        _x = x,
        _y = y {
    if (x == null && y == null) {
      return;
    }
    if (_y.pow(BigInt.two) != (_x.pow(BigInt.from(3)) + (_a * _x) + _b)) {
      throw Exception(
          "PointSecp256k1 (${_x},${_y}) not on the curve x^3+${_a}*x+${_b}!");
    }
  }

  String toString() {
    return "PointSecp256k1($_x,$_y)_$_a$_b";
  }

  bool operator ==(covariant PointSecp256k1 other) {
    return (_x == other._x) &&
        (_y == other._y) &&
        (_a == other._a) &&
        (_b == other._b);
  }

  PointSecp256k1 operator *(BigInt coef) {
    var c = coef % n;
    var current = this;
    var result = PointSecp256k1(null, null);
    while (c != BigInt.zero) {
      if (c & BigInt.one > BigInt.zero) {
        result += current;
      }
      current += current;
      c >>= 1;
    }
    return result;
  }

  PointSecp256k1 operator +(covariant PointSecp256k1 other) {
    if (_a != other._a || _b != other._b) {
      throw Exception(
          "PointSecp256k1s ${this} and ${other} are not on the same curve.");
    }

    if (_x == null) {
      // this is the PointSecp256k1 at infinity, return the other
      return other;
    }

    if (other._x == null) {
      // other is the PointSecp256k1 at infinity, return this
      return this;
    }

    if (other._x == _x && other._y != _y) {
      return PointSecp256k1(null, null);
    }

    if (_x != other._x) {
      var slope = (other._y - _y) / (other._x - _x);
      var new_x = slope.pow(BigInt.two) - _x - other._x;
      var new_y = slope * (_x - new_x) - _y;
      return PointSecp256k1(new_x, new_y);
    }

    if (this == other) {
      var three = FieldSecp256k1(BigInt.from(3));
      var two = FieldSecp256k1(BigInt.two);
      var slope = (three * _x.pow(BigInt.two) + _a) / (two * _y);
      var new_x = slope.pow(BigInt.two) - (two * _x);
      var new_y = (slope * (_x - new_x)) - _y;
      return PointSecp256k1(new_x, new_y);
    }

    if (this == other && _y.isZero()) {
      return PointSecp256k1(null, null);
    }
  }
}
