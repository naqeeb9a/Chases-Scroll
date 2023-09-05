class ApiResponse {
  String? message;
  String? title;
  String? status;
  ApiResponse({this.title, this.message, this.status});

  static ApiResponse toApiResponse(Map<String, dynamic> response) {
    return ApiResponse(
        title: response['data'],
        message: response['message'],
        status: response['status']);
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
        status: response['status']);
  }
}
