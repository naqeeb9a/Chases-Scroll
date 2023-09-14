class ApiResponse {
  dynamic message;

  int? status;
  ApiResponse({this.message, this.status});

  static ApiResponse toApiResponse(String message, int status) {
    return ApiResponse(message: message, status: status);
  }
}

class SuccessResponse {
  String? status;
  String? message;
  dynamic data;

  SuccessResponse({this.message, this.status, this.data});
  static SuccessResponse toApiResponse(Map<String, dynamic> response) {
    return SuccessResponse(
        data: response['data'],
        message: response['message'],
        status: response['statusCode']);
  }
}
