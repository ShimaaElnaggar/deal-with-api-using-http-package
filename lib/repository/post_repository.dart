import 'dart:convert';

import 'package:deal_with_api_using_http_package/models/call_result.dart';
import 'package:deal_with_api_using_http_package/repository/call_repository.dart';
import 'package:deal_with_api_using_http_package/services/http_services.dart';

class PostsRepository extends CallRepository {
  @override
  Future<CallResult> delete(String id, [Map<String, dynamic>? args]) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<CallResult> get([Map<String, dynamic>? args]) async {
    try {
      var response = await HttpServices.get('posts');
      if ((response.statusCode) >= 200 && (response.statusCode) < 299) {
        return CallResult(
            status: response.statusCode,
            statusMessage: response.reasonPhrase!,
            data: json.decode(response.body),
            isSuccess: true,
            error: '');
      } else {
        return CallResult(
            isSuccess: false,
            status: response.statusCode,
            statusMessage: response.reasonPhrase!,
            data: null,
            error: 'Error : ${response.statusCode}');
      }
    } catch (e) {
      return CallResult(
          isSuccess: false,
          status: 500,
          statusMessage: '',
          data: null,
          error: '$e');
    }
  }

  @override
  Future<CallResult> patch(String id, Map<String, dynamic> data,
      [Map<String, dynamic>? args]) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<CallResult> post(Map<String, dynamic> data,
      [Map<String, dynamic>? args]) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<CallResult> put(String id, Map<String, dynamic> data,
      [Map<String, dynamic>? args]) {
    // TODO: implement put
    throw UnimplementedError();
  }
}
