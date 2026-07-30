enum ApiStatus { success, error }

class ApiResponse<T> {
  final ApiStatus status;
  final T? data;
  final String? message;

  const ApiResponse._({
    required this.status,
    this.data,
    this.message,
  });

  factory ApiResponse.success(T data) {
    return ApiResponse._(
      status: ApiStatus.success,
      data: data,
    );
  }

  factory ApiResponse.error(String message) {
    return ApiResponse._(
      status: ApiStatus.error,
      message: message,
    );
  }

  bool get isSuccess => status == ApiStatus.success;
  bool get isError => status == ApiStatus.error;

  static Future<ApiResponse<T>> executeApiCall<T>({
    required Future<T> Function() apiCall,
    T Function(dynamic json, dynamic response)? fromJson,
  }) async {
    try {
      final result = await apiCall();
      return ApiResponse.success(result);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
