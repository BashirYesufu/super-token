
import 'package:dio/dio.dart';

class SharedApiResponse<T>{
  late String message;
  late T data;
  late bool success=true;

  SharedApiResponse(this.message, this.data, this.success);

  SharedApiResponse.fromJson(Response<dynamic>? parsedJson) {
    message = parsedJson?.data?['message'] ?? "An error occurred while processing this request";
    data = parsedJson?.data?['data'];
    success = data!=null || parsedJson?.statusCode == 200;
  }

  Map toJson() {
    Map map = {};
    map["message"] = message;
    map["data"] = data;
    return map;
  }

}