final P = BigInt.from(2).pow(256) - BigInt.from(2).pow(32) - BigInt.from(977);

class S256Field {
  BigInt _num;
  BigInt _prime = P;

  S256Field(BigInt number) {
    _num = number;
  }

  bool operator ==(covariant S256Field other) =>
      other._prime == _prime && other._num == _num;

  S256Field operator +(covariant S256Field other) {
    if (other._prime != _prime) throw Exception("Different fields");
    return S256Field((other._num + _num) % _prime);
  }

  S256Field operator -(covariant S256Field other) {
    if (other._prime != _prime) throw Exception("Different fields");
    return S256Field((other._num + _num) % _prime);
  }

  S256Field operator *(covariant S256Field other) {
    if (other._prime != _prime) throw Exception("Different fields");
    return S256Field((other._num * _num) % _prime);
  }

  S256Field pow(S256Field exponent) {
    var non_negative_exponent = exponent._num % (_prime - BigInt.from(1));
    return S256Field(_num.modPow(non_negative_exponent, _prime));
  }

  S256Field operator /(covariant S256Field other) {
    if (other._prime != _prime) throw Exception("Different fields");
    if (other._num == BigInt.from(0)) throw Exception("Can't divide by zero");
    var result =
        (_num * other._num.modPow(_prime - BigInt.from(2), _prime) % _prime);
    return S256Field(result);
  }

  String toString() {
    return "{n${_num},f${_prime}}";
  }

  void printElement() {
    print("Elemento ${_num} do campo ${_prime}");
  }
}
