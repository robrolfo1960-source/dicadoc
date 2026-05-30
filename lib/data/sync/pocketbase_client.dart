import 'dart:convert';
import 'package:http/http.dart' as http;

/// Client HTTP minimale per PocketBase REST API (v0.22+).
/// Usato da [CloudSync] — nessuna dipendenza dal SDK Flutter.
class PocketBaseClient {
  PocketBaseClient(this.baseUrl);

  final String baseUrl;

  Uri _uri(String path, [Map<String, String>? query]) =>
      Uri.parse('$baseUrl/api$path').replace(queryParameters: query);

  static const _headers = {'Content-Type': 'application/json'};

  // ── records ──────────────────────────────────────────────────────────────

  Future<List<Map<String, dynamic>>> list(
    String collection, {
    String? filter,
    String? sort,
    int perPage = 500,
  }) async {
    final resp = await http.get(
      _uri('/collections/$collection/records', {
        'perPage': '$perPage',
        if (filter != null) 'filter': filter,
        if (sort != null) 'sort': sort,
      }),
      headers: _headers,
    );
    _check(resp);
    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    return (data['items'] as List).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> create(
    String collection,
    Map<String, dynamic> body,
  ) async {
    final resp = await http.post(
      _uri('/collections/$collection/records'),
      headers: _headers,
      body: jsonEncode(body),
    );
    _check(resp);
    return jsonDecode(resp.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> update(
    String collection,
    String id,
    Map<String, dynamic> body,
  ) async {
    final resp = await http.patch(
      _uri('/collections/$collection/records/$id'),
      headers: _headers,
      body: jsonEncode(body),
    );
    _check(resp);
    return jsonDecode(resp.body) as Map<String, dynamic>;
  }

  /// Crea o aggiorna in base al campo [uniqueField] con valore [uniqueValue].
  Future<Map<String, dynamic>> upsert(
    String collection,
    String uniqueField,
    String uniqueValue,
    Map<String, dynamic> body,
  ) async {
    final existing = await list(
      collection,
      filter: '$uniqueField="$uniqueValue"',
    );
    if (existing.isNotEmpty) {
      return update(collection, existing.first['id'] as String, body);
    }
    return create(collection, body);
  }

  void _check(http.Response resp) {
    if (resp.statusCode >= 400) {
      throw Exception(
          'PocketBase ${resp.statusCode}: ${resp.body.substring(0, resp.body.length.clamp(0, 200))}');
    }
  }
}
