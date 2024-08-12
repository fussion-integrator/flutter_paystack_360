import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> makeRequest(
  String method,
  String url, {
  Map<String, dynamic>? queryParameters,
  Map<String, dynamic>? body,
  required String secretKey,
}) async {
  final uri = Uri.parse(url).replace(queryParameters: queryParameters);
  final headers = {
    'Authorization': 'Bearer $secretKey',
    'Content-Type': 'application/json',
  };
  final requestBody = body != null ? jsonEncode(body) : null;

  http.Response response;
  switch (method.toUpperCase()) {
    case 'POST':
      response = await http.post(uri, headers: headers, body: requestBody);
      break;
    case 'PUT':
      response = await http.put(uri, headers: headers, body: requestBody);
      break;
    case 'DELETE':
      response = await http.delete(uri, headers: headers);
      break;
    case 'GET':
    default:
      response = await http.get(uri, headers: headers);
      break;
  }

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to make request: ${response.body}');
  }
}
