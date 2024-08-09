
import 'package:http/http.dart' as http;

abstract class HttpServices{
  static const _baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<http.Response> get(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
    return response;
  }
}