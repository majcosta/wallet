class FieldElement {
  BigInt _num;
  BigInt _prime;

  FieldElement(BigInt number, BigInt prime)
      : _num = number,
        _prime = prime;

  FieldElement.fromInt(int number, int prime)
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

  bool operator ==(covariant FieldElement other) =>
      other._prime == _prime && other._num == _num;

  FieldElement operator +(covariant FieldElement other) {
    if (other._prime != _prime) throw Exception("Different fields");
    return FieldElement((_num + other._num) % _prime, _prime);
  }

  FieldElement operator -(covariant FieldElement other) {
    if (other._prime != _prime) throw Exception("Different fields");
    return FieldElement((_num - other._num) % _prime, _prime);
  }

  FieldElement operator *(covariant FieldElement other) {
    if (other._prime != _prime) throw Exception("Different fields");
    return FieldElement((_num * other._num) % _prime, _prime);
  }

  FieldElement pow(BigInt exponent) {
    var non_negative_exponent = exponent % (_prime - BigInt.one);
    return FieldElement(_num.modPow(non_negative_exponent, _prime), _prime);
  }

  FieldElement operator /(covariant FieldElement other) {
    if (other._prime != _prime) throw Exception("Different fields");
    if (other._num == BigInt.zero) throw Exception("Can't divide by zero");
    var result =
        (_num * other._num.modPow(_prime - BigInt.two, _prime) % _prime);
    return FieldElement(result, _prime);
  }

  String toString() {
    return "($_num,$_prime)";
  }
}
