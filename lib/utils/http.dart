import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpHelper {
  final String baseUrl;
  final Map<String, String> defaultHeaders;

  HttpHelper({this.baseUrl = 'http://101.126.157.159/api', this.defaultHeaders = const {}});

  Future<bool> _checkAndSetAuthorization(Map<String, String> headers, bool requireAuth) async {
    if (requireAuth) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null) {
        return false;
      }
      headers['authorization'] = token;
    }
    return true;
  }

  Future<dynamic> _handleResponse(http.Response response) async {
    try {
      final responseBody = utf8.decode(response.bodyBytes);
      final decodedJson = jsonDecode(responseBody);
      if (decodedJson is Map<String, dynamic> || decodedJson is List<dynamic>) {
        return decodedJson;
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      throw Exception('Failed to parse response: $e');
    }
  }

  // GET Request
  Future<dynamic> getRequest(String endpoint, {Map<String, String>? headers, bool requireAuth = false}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final mergedHeaders = {...defaultHeaders, if (headers != null) ...headers};
    if (!mergedHeaders.containsKey('Content-Type')) {
      mergedHeaders['Content-Type'] = 'application/json; charset=utf-8';
    }

    bool proceed = await _checkAndSetAuthorization(mergedHeaders, requireAuth);
    if (!proceed) return null;

    final response = await http.get(url, headers: mergedHeaders);
    return _handleResponse(response);
  }

  // POST Request
  Future<dynamic> postRequest(String endpoint, Map<String, dynamic> body, {Map<String, String>? headers, bool requireAuth = false}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final mergedHeaders = {...defaultHeaders, if (headers != null) ...headers};
    if (!mergedHeaders.containsKey('Content-Type')) {
      mergedHeaders['Content-Type'] = 'application/json';
    }

    bool proceed = await _checkAndSetAuthorization(mergedHeaders, requireAuth);
    if (!proceed) return null;

    final response = await http.post(url, headers: mergedHeaders, body: jsonEncode(body));
    return _handleResponse(response);
  }

  // File Upload (Multipart)
  Future<dynamic> uploadFile(String endpoint, File file, {Map<String, String>? headers, bool requireAuth = false}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final mergedHeaders = {...defaultHeaders, if (headers != null) ...headers};

    bool proceed = await _checkAndSetAuthorization(mergedHeaders, requireAuth);
    if (!proceed) return null;

    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(mergedHeaders);
    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await request.send();
    final responseBody = await http.Response.fromStream(response);
    return _handleResponse(responseBody);
  }
}
