import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../data/models/local_storage/local_storage.dart';
import '../utils/literals.dart';
import 'storage_service.dart';
import 'tool_service.dart';

class ApiService {
  final StorageService _storage = Get.find<StorageService>();
  final ToolService _tool = Get.find<ToolService>();

  Future<String?> post(String url, dynamic data) async {
    return await _call(url, data);
  }

  Future<String?> get(String url) async {
    return await _call(url, null, false);
  }

  Future<String?> _call(String url, dynamic data, [bool post = true]) async {
    try {
      var api = await _api();
      var response = post ? await api.post(
        "${Literals.uri}$url",
        data: json.encode(data),
      ) : await api.get(
        "${Literals.uri}$url"
      );
      if(response.statusCode != 200) {
        return response.data;
      }
      var result = response.data;
      if(_tool.isObject(result)) {
        return jsonEncode(result);
      } else {
        return result.toString();
      }
    } catch(e) {
      return null;
    }
  }

  Future<Dio> _api() async {
    var localStorage = await _storage.get<LocalStorage>(LocalStorage());
    var api = Dio()
    ..options.headers = {
      Literals.apiToken : localStorage!.token,
    }
    ..options.receiveTimeout = 9.minutes
    ..options.connectTimeout = 9.minutes
    ..options.sendTimeout = 9.minutes
    ..options.followRedirects = false
    ..options.contentType = Literals.applicationJson
    ..options.validateStatus = (status) => status! < 500;
    return api;
  }
}