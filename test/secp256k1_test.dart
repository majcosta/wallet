import 'package:test/test.dart';
import 'package:wallet/secp256k1.dart';

void main() {
  group('secp256k1 field element operations', () {
    test('sum 44 plus 33 should be 77', () {
      final x = FieldSecp256k1(BigInt.from(44));
      final y = FieldSecp256k1(BigInt.from(33));
      final z = x + y;
      expect(z.getNum(), BigInt.from(77));
    });
  });
}
