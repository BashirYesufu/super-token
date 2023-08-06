import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/shared_api_response.dart';
import '../config.dart';

class NetworkManager{
  static BaseOptions options = BaseOptions(
      baseUrl:BaseUrl.BASE_URL,
      connectTimeout: 30000,
      receiveTimeout: 60000,
      headers: {
        "content-type" :"application/json;charset=UTF-8",
      }
  );
  Dio client = Dio(options);

  Future<SharedApiResponse> networkRequestManager(RequestType vrxRequestType,String requestUrl, {dynamic body, queryParameters,
    bool useAuth = true, BehaviorSubject<int>? progressStream, File? backFile}) async{

    late SharedApiResponse apiResponse;
    var baseUrl =  BaseUrl.BASE_URL;
    String url = '$baseUrl$requestUrl';
    client.interceptors.add(RequestsInspectorInterceptor());

    try{
      switch(vrxRequestType){
        case RequestType.GET:
          var response = await client
              .get(url,queryParameters: queryParameters,);
          //  debugPrint("get: ${response.data.toString()}");
          apiResponse = SharedApiResponse.fromJson(response);
          break;
        case RequestType.POST:
          var response = await client
              .post(url,data: body,queryParameters: queryParameters, onSendProgress:(int count, int total){
            if(progressStream!=null){
              double percentage  = (count/total) * 100 ;
              progressStream.sink.add(percentage.toInt());
            }
          });
          debugPrint("post: ${response.data.toString()}");
          if(response.statusCode==204){
            apiResponse = SharedApiResponse("Success",{"status": "Success"},true);
          }else{
            apiResponse = SharedApiResponse.fromJson(response);
          }
          break;
        case RequestType.MULTI_PART_POST:
        // client.interceptors.add(InterceptorsWrapper(
        //     onRequest: (Options options) async {
        //       options.headers["Content-Type"] = "multipart/form-data";
        //       return options;
        //     }
        // ));
          var response = await client
              .post(url,data: body,queryParameters: queryParameters,);
          debugPrint("post: ${response.data.toString()}");
          apiResponse = SharedApiResponse.fromJson(response);
          break;
        case RequestType.PUT:
          var response = await client
              .put(url,data: body,queryParameters: queryParameters);
          debugPrint("put: ${response.data.toString()}");
          apiResponse = SharedApiResponse.fromJson(response);
          break;
        case RequestType.PATCH:
          var response = await client
              .patch(url,data: body,queryParameters: queryParameters);
          debugPrint("put: ${response.data.toString()}");
          apiResponse = SharedApiResponse.fromJson(response);
          break;
        case RequestType.DELETE:
          var response = await client
              .delete(url,data: body,queryParameters: queryParameters);
          debugPrint("delete: ${response.data.toString()}");
          apiResponse = SharedApiResponse.fromJson(response);
          break;
        default:
          var response = await client
              .post(url,data: body,queryParameters: queryParameters);
          debugPrint("post: ${response.data.toString()}");
          apiResponse = SharedApiResponse.fromJson(response);
          break;
      }
      return apiResponse;

    }on TimeoutException catch(n) {
      debugPrint("Network Timeout Error response: $n");
      throw ("Network timed out, please check your network connection and try again");
    } on DioError catch(e){
      debugPrint("Internal Error response: ${e.error}");

      if (DioErrorType.receiveTimeout == e.type || DioErrorType.connectTimeout == e.type) {
        debugPrint("Network Timeout Error response: $e");
        throw ("Network timed out, please check your network connection and try again");
      } else if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          debugPrint("No Network Error response: $e");
          throw ("No internet connection, please check your network connection and try again");
        }else if (e.message.contains('XMLHttpRequest')) {
          debugPrint("No Network Error response: $e");
          throw ("No internet connection, please check your network connection and try again");
        }else{
          debugPrint("No Network Error response: $e");
          throw ("An error occurred processing this request, please try again later");
        }
      }
      if(e.response==null){
        if(e.error.toString().contains("XMLHttpRequest")){
          throw ("Internet connection error, please check your network connection and try again");
        }
        throw ("Unable to process this request at this time");
      }
      if (e.response?.statusCode == 401) {
        apiResponse = SharedApiResponse.fromJson(e.response);
        throw(apiResponse.message);
      }else if (e.response?.statusCode == 404) {
        throw ("Resource not found, please try again later");
      }else if (e.response?.statusCode?.isBetween(399,499)==true) {
        apiResponse = SharedApiResponse.fromJson(e.response);
        debugPrint("Server ${e.response?.statusCode} response: ${apiResponse.message}");
        throw (apiResponse.message);
      } else if (e.response?.statusCode?.isBetween(500,599)==true)  {
        //debugPrint("Server 500 response: ${apiResponse}");
        throw ("We are unable to process request at this time, please try again later \n[${e.response?.statusCode}]");
      } else {
        apiResponse = SharedApiResponse.fromJson(e.response);
        debugPrint("Network Unknown response: ${e.response}");
        throw (apiResponse.message);
      }
    }
    catch(e){
      debugPrint("Internal error response $e");
      throw ("An internal error occurred while processing this request");
    }

  }

}

extension Range on num {
  bool isBetween(num from, num to) {
    return from < this && this < to;
  }
}

enum RequestType {
  GET,
  POST,
  PUT,
  PATCH,
  DELETE,
  MULTI_PART_POST,
}