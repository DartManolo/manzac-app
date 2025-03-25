import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:manzac_app/app/data/models/local_storage/local_storage.dart';

import 'tool_service.dart';

class StorageService {
  final _storage = FlutterSecureStorage();
  final ToolService _tool = Get.find<ToolService>();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  IOSOptions _getIOSOptions() => const IOSOptions(
    accessibility: KeychainAccessibility.first_unlock
  );

  Future<void> init() async {
    try {
      var versionCode = LocalStorage().version!;
      var localStorage = await get<LocalStorage>(LocalStorage());
      if(localStorage!.version! != versionCode) {
        var nuevoStorage = _nuevoLocalStorage(actual: localStorage);
        await _storage.write(
          key: nuevoStorage!.tabla!,
          value: jsonEncode(nuevoStorage),
          aOptions: _getAndroidOptions(),
          iOptions: _getIOSOptions(),
        );
      }
      return;
    } catch(e) {
      return;
    }
  }

  Future<S?> get<S>(dynamic elem) async {
    try {
      var isArray = S.toString().contains("List<");
      var jsonData = jsonDecode(jsonEncode(elem));
      var tabla = isArray ? jsonData[0]['tabla'] : jsonData['tabla'];
      var dataStorage = await _storage.read(
        key: tabla,
        aOptions: _getAndroidOptions(),
      );
      if(dataStorage != null) {
        return isArray
          ? elem.fromArray(jsonDecode(dataStorage))
          : elem.fromJson(jsonDecode(dataStorage));
      }
      return isArray
        ? elem.fromArray(jsonData)
        : elem.fromJson(jsonData);
    } catch(e) {
      return null;
    }
  }

  Future<bool> put(dynamic elem) async {
    try {
      var jsonData = jsonDecode(jsonEncode(elem));
      var isArray = _tool.isArray(jsonData);
      var tabla = isArray ? jsonData[0]['tabla'] : jsonData['tabla'];
      await _storage.write(
        key: tabla,
        value: jsonEncode(jsonData),
        aOptions: _getAndroidOptions(),
      );
      return true;
    } catch(e) {
      return false;
    }
  }

  Future<void> update(dynamic elem) async {
    try {
      var jsonData = jsonDecode(jsonEncode(elem));
      var tabla = _tool.isArray(jsonData) ? jsonData[0]['tabla'] : jsonData['tabla'];
      await _storage.delete(
        key: tabla,
        aOptions: _getAndroidOptions(),
      );
      await _storage.write(
        key: tabla,
        value: jsonEncode(jsonData),
        aOptions: _getAndroidOptions(),
      );
      await Future.delayed(1.seconds);
      return;
    } catch(e) {
      return;
    }
  }

  Future<bool> delete(dynamic elem) async {
    try {
      var jsonData = jsonDecode(jsonEncode(elem));
      var tabla = _tool.isArray(jsonData) ? jsonData[0]['tabla'] : jsonData['tabla'];
      await _storage.delete(
        key: tabla,
        aOptions: _getAndroidOptions(),
      );
      return true;
    } catch(e) {
      return false;
    }
  }

  Future<bool> verify(dynamic elem) async {
    try {
      var jsonData = jsonDecode(jsonEncode(elem));
      var tabla = _tool.isArray(jsonData) ? jsonData[0]['tabla'] : jsonData['tabla'];
      var storage = await _storage.read(
        key: tabla,
        aOptions: _getAndroidOptions(),
      );
      return storage != null;
    } catch(e) {
      return false;
    }
  }

  Future<void> clearAll() async {
    try {
      await _storage.deleteAll(
        aOptions: _getAndroidOptions(),
      );
    } finally { }
  }

  LocalStorage? _nuevoLocalStorage({
    LocalStorage? actual,
  }) {
    try {
      var nuevoStorage = LocalStorage();
      Map<String, dynamic> nuevoStorageTemp = jsonDecode(jsonEncode(nuevoStorage));
      Map<String, dynamic> actualStorageTemp = jsonDecode(jsonEncode(actual));
      actualStorageTemp.forEach((key, value) {
        if(nuevoStorageTemp[key] != null) {
          nuevoStorageTemp[key] = value;
        }
      });
      var storageString = jsonEncode(nuevoStorageTemp);
      return LocalStorage.fromString(storageString);
    } catch(e) {
      return null;
    }
  }
}