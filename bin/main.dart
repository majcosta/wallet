import 'package:wallet/secp256k1.dart';

void main() {
  /* final Gx = FieldSecp256k1(BigInt.parse(
      "0x79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798"));
  final Gy = FieldSecp256k1(BigInt.parse(
      "0x483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8")); */
  final x = BigInt.parse("15");
  final y = BigInt.parse("86");
  
  final Gx = FieldSecp256k1(x);
  final Gy = FieldSecp256k1(y);
  final G = PointSecp256k1(Gx, Gy);

  var inf = PointSecp256k1(FieldSecp256k1(null),FieldSecp256k1(null));

  var product = G;
  var count = 1;

  while (product != inf) {
    product += G;
    count++;
  }
}
