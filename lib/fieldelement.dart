class FieldElement {
  BigInt _num = BigInt.from(0);
  BigInt _prime = BigInt.from(0);

  FieldElement(int number, int prime) {
    _num = BigInt.from(number);
    _prime = BigInt.from(prime);
  }

  FieldElement.fromBigInt(BigInt number, BigInt prime) {
    _num = number;
    _prime = prime;
  }

  bool operator ==(covariant FieldElement other) =>
      other._prime == _prime && other._num == _num;

  FieldElement operator +(covariant FieldElement other) {
    if (other._prime != _prime) throw Exception("Different fields");
    return FieldElement.fromBigInt((other._num + _num) % _prime, _prime);
  }

  FieldElement operator -(covariant FieldElement other) {
    if (other._prime != _prime) throw Exception("Different fields");
    return FieldElement.fromBigInt((other._num + _num) % _prime, _prime);
  }

  FieldElement operator *(covariant FieldElement other) {
    if (other._prime != _prime) throw Exception("Different fields");
    return FieldElement.fromBigInt((other._num * _num) % _prime, _prime);
  }

  FieldElement operator ^(covariant int exponent) {
    return FieldElement.fromBigInt(
        _num.modPow(BigInt.from(exponent), _prime), _prime);
  }

  FieldElement operator /(covariant FieldElement other) {
    if (other._prime != _prime) throw Exception("Different fields");
    if (other._num == BigInt.from(0)) throw Exception("Can't divide by zero");
    //var result =
  }

  void printElement() {
    print("Elemento ${_num} do campo ${_prime}");
  }
}
