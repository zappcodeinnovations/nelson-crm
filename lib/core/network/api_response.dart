/// Unified API response wrapper.
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final int? statusCode;
  final PaginationMeta? pagination;

  const ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.statusCode,
    this.pagination,
  });

  factory ApiResponse.success(T data, {String? message, PaginationMeta? pagination}) {
    return ApiResponse(
      success: true,
      data: data,
      message: message,
      pagination: pagination,
    );
  }

  factory ApiResponse.error(String message, {int? statusCode}) {
    return ApiResponse(
      success: false,
      message: message,
      statusCode: statusCode,
    );
  }
}

/// Pagination metadata.
class PaginationMeta {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int perPage;
  final bool hasMore;

  const PaginationMeta({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.perPage,
    required this.hasMore,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    final currentPage = json['current_page'] as int? ?? 1;
    final totalPages = json['total_pages'] as int? ?? 1;
    return PaginationMeta(
      currentPage: currentPage,
      totalPages: totalPages,
      totalItems: json['total_items'] as int? ?? 0,
      perPage: json['per_page'] as int? ?? 20,
      hasMore: currentPage < totalPages,
    );
  }
}
