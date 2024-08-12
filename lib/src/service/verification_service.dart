import 'dart:convert';
import 'package:flutter_paystack_360/src/exception/paystack_exception.dart';
import 'package:flutter_paystack_360/src/model/verification_response.dart';
import 'package:http/http.dart' as http;

typedef SuccessCallback = void Function(VerificationResponse response);
typedef ErrorCallback = void Function(PaystackException error);
typedef ProgressCallback = void Function(double progress);
typedef StatusCallback = void Function(String status);
typedef CallbackUrl = void Function(String url);

class PaystackVerificationService {
  final String secretKey;
  final String baseUrl = "https://api.paystack.co";

  PaystackVerificationService({required this.secretKey});

  Future<void> resolveAccount({
    required String accountNumber,
    required String bankCode,
    required SuccessCallback onSuccess,
    required ErrorCallback onError,
    ProgressCallback? onProgress,
    StatusCallback? onStatus,
    CallbackUrl? onCallbackUrl,
  }) async {
    final url =
        '$baseUrl/bank/resolve?account_number=$accountNumber&bank_code=$bankCode';
    final headers = {
      'Authorization': 'Bearer $secretKey',
    };

    try {
      onStatus?.call('Sending request...');
      onProgress?.call(0.3);

      final response = await http.get(Uri.parse(url), headers: headers);

      onProgress?.call(0.7);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['status']) {
          onSuccess(VerificationResponse.fromJson(data['data']));
          onStatus?.call('Account resolved successfully');
        } else {
          throw PaystackException(data['message'], response.statusCode);
        }
      } else {
        throw PaystackException(_parseError(response), response.statusCode);
      }
    } catch (error) {
      if (error is PaystackException) {
        onError(error);
      } else {
        onError(PaystackException('An unexpected error occurred', null));
      }
    } finally {
      onProgress?.call(1.0);
    }
  }

  String _parseError(http.Response response) {
    try {
      final data = jsonDecode(response.body);

      switch (response.statusCode) {
        case 400:
          return data['message'] ?? 'Bad request';
        case 401:
          return 'Unauthorized - Invalid API key';
        case 403:
          return 'Forbidden - You do not have permission to access this resource';
        case 404:
          return 'Resource not found';
        case 500:
          return 'Internal server error - please try again later';
        default:
          return data['message'] ?? 'Unknown error occurred';
      }
    } catch (e) {
      return 'Failed to parse error response';
    }
  }
}
