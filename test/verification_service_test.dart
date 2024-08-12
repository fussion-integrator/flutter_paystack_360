import 'package:flutter_paystack_360/src/service/verification_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('PaystackVerificationService', () {
    MockClient client;
    PaystackVerificationService service;

    setUp(() {
      client = MockClient();
      service = PaystackVerificationService(secretKey: 'test_key');
    });

    test('resolveAccount returns account data on success', () async {
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(
              '{"status": true, "data": {"account_name": "Test User"}}', 200));

      service.resolveAccount(
        accountNumber: '0022728151',
        bankCode: '063',
        onSuccess: (data) {
          expect(data.accountName, 'Test User');
        },
        onError: (error) {
          fail('Should not reach here');
        },
      );
    });

    test('resolveAccount handles error response', () async {
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async =>
              http.Response('{"message": "Invalid account number"}', 400));

      service.resolveAccount(
        accountNumber: 'invalid',
        bankCode: '063',
        onSuccess: (data) {
          fail('Should not reach here');
        },
        onError: (error) {
          expect(error.message, 'Invalid account number');
        },
      );
    });
  });
}
