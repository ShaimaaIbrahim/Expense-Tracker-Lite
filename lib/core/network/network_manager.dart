import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'exceptions.dart';

class NetworkManager {
  final String baseUrl;
  final http.Client _client;
  final Map<String, String> _defaultHeaders;

  NetworkManager({
    required this.baseUrl,
    http.Client? client,
    Map<String, String>? defaultHeaders,
  })  : _client = client ?? http.Client(),
        _defaultHeaders = defaultHeaders ?? {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        };

  // Main request method
  Future<dynamic> _request({
    required String method,
    required String endpoint,
    dynamic body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint').replace(
        queryParameters: queryParams,
      );

      final requestHeaders = {..._defaultHeaders, ...?headers};

      http.Response response;
      switch (method) {
        case 'GET':
          response = await _client.get(uri, headers: requestHeaders);
          break;
        case 'POST':
          response = await _client.post(
            uri,
            headers: requestHeaders,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        case 'PUT':
          response = await _client.put(
            uri,
            headers: requestHeaders,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        case 'DELETE':
          response = await _client.delete(uri, headers: requestHeaders);
          break;
        default:
          throw NetworkException('Unsupported HTTP method: $method');
      }

      return _handleResponse(response);
    } on TimeoutException {
      throw NetworkException('Request timeout');
    } on http.ClientException catch (e) {
      throw NetworkException(e.message);
    } catch (e) {
      throw NetworkException('Network error: ${e.toString()}');
    }
  }

  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody = response.body;

    if (statusCode >= 200 && statusCode < 300) {
      if (responseBody.isEmpty) return null;
      return jsonDecode(responseBody);
    } else {
      throw _parseError(statusCode, responseBody);
    }
  }

  NetworkException _parseError(int statusCode, String body) {
    final message = jsonDecode(body)['message'] ?? 'Unknown error';
    switch (statusCode) {
      case 400:
        return BadRequestException(message);
      case 401:
        return UnauthorizedException(message);
      case 403:
        return ForbiddenException(message);
      case 404:
        return NotFoundException(message);
      case 500:
        return ServerException(message);
      default:
        return NetworkException('HTTP $statusCode: $message');
    }
  }

  // Convenience methods
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParams}) =>
      _request(method: 'GET', endpoint: endpoint, queryParams: queryParams);

  Future<dynamic> post(String endpoint, {dynamic body}) =>
      _request(method: 'POST', endpoint: endpoint, body: body);

  Future<dynamic> put(String endpoint, {dynamic body}) =>
      _request(method: 'PUT', endpoint: endpoint, body: body);

  Future<dynamic> delete(String endpoint) =>
      _request(method: 'DELETE', endpoint: endpoint);

  void dispose() {
    _client.close();
  }
}