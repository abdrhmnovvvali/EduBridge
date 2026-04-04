import 'package:eduroom/data/models/remote/response/student/material_response.dart';

class MaterialsPageResponse {
  MaterialsPageResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  final List<MaterialResponse> data;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  factory MaterialsPageResponse.fromJson(Map<String, dynamic> json) {
    final raw = json['data'];
    final list = raw is List ? raw : <dynamic>[];
    return MaterialsPageResponse(
      data: list.map((e) => MaterialResponse.fromJson(e as Map<String, dynamic>)).toList(),
      total: _toInt(json['total']),
      page: _toInt(json['page'], fallback: 1),
      limit: _toInt(json['limit'], fallback: 20),
      totalPages: _toInt(json['totalPages'] ?? json['total_pages']),
    );
  }

  /// Supports `{ data, total, page, limit, totalPages }` or a legacy plain JSON array.
  factory MaterialsPageResponse.fromResponseBody(dynamic body) {
    if (body is Map<String, dynamic>) {
      if (body['data'] is List) {
        return MaterialsPageResponse.fromJson(body);
      }
    }
    if (body is List) {
      return MaterialsPageResponse(
        data: body.map((e) => MaterialResponse.fromJson(e as Map<String, dynamic>)).toList(),
        total: body.length,
        page: 1,
        limit: body.length,
        totalPages: 1,
      );
    }
    return MaterialsPageResponse(data: [], total: 0, page: 1, limit: 20, totalPages: 0);
  }

  static int _toInt(dynamic v, {int fallback = 0}) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse('$v') ?? fallback;
  }
}
