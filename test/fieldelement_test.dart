import 'package:test/test.dart';
import 'package:wallet/fieldelement.dart';

void main() {
  group('field element operations', () {
    test('sum 44,57 plus 33,57 should be 20', () {
      const prime = 57;
      final x = FieldElement.fromInt(44, prime);
      final y = FieldElement.fromInt(33, prime);
      final z = x + y;
      expect(z.getNum(), BigInt.from(20));
    });
    test('field 57,  9 minus 29 should be 37', () {
      final x = FieldElement.fromInt(9, 57);
      final y = FieldElement.fromInt(29, 57);
      final z = x - y;
      expect(z.getNum(), BigInt.from(37));
    });
    test('multiply 95, 45 and 31 in field 97 should be 23', () {
      final prime = 97;
      final x = FieldElement.fromInt(95, prime);
      final y = FieldElement.fromInt(45, prime);
      final z = FieldElement.fromInt(31, prime);
      final result = x * y * z;
      expect(result.getNum(), BigInt.from(23));
    });
    test('8 to the power of 2 in field 57 should be 7', () {
      final prime = 57;
      final x = FieldElement.fromInt(8, prime);
      final result = x.pow(BigInt.from(2));
      expect(result.getNum(), BigInt.from(7));
    });
    test('7 divided by 5 in field 19 must be 9', () {
      final prime = 19;
      final x = FieldElement.fromInt(7, prime);
      final y = FieldElement.fromInt(5, prime);
      final result = x / y;
      expect(result.getNum(), BigInt.from(9));
    });
  });
}
