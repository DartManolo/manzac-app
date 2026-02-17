import 'package:hive_ce_flutter/adapters.dart';
import 'package:manzac_app/hive_registrar.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../data/models/hive_model.dart';
import '../data/models/local_storage/local_storage.dart';
import '../data/models/reportes/reporte_alta_local.dart';

class StorageService {
  final _uuid = const Uuid();
  final Map<Type, String> _boxNames = {};

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive
    ..init(dir.path)
    ..registerAdapters();
    await _open();
    return;
  }

  Future<List<T>> getAll<T>() async {
    final box = _getBox<T>();
    return box.values.toList();
  }

  Future<T?> get<T>(dynamic key) async {
    final box = _getBox<T>();
    return box.get(key);
  }

  Future<bool> save<T extends HiveModel>(T value) async {
    try {
      if(value.id == null || value.id == "") {
        value.id = _uuid.v1();
      }
      final box = _getBox<T>();
      await box.put(value.id , value);
      return true;
    } catch(e) {
      return false;
    }
  }

  Future<void> saveAll<T>(Map<dynamic, T> values) async {
    final box = _getBox<T>();
    await box.putAll(values);
  }

  Future<bool> delete<T>(dynamic key) async {
    try {
      final box = _getBox<T>();
      await box.delete(key);
      return true;
    } catch(e) {
      return false;
    }
  }

  Future<bool> clear<T>() async {
    try {
      final box = _getBox<T>();
      await box.clear();
      return true;
    } catch(e) {
      return false;
    }
  }

  Box<T> _getBox<T>() {
    final boxName = _boxNames[T];
    if (boxName == null) {
      throw Exception('Box no registrado para el tipo $T');
    }
    return Hive.box<T>(boxName);
  }

  Future _open() async {
    await Hive.openBox<LocalStorage>(LocalStorage.boxName);
    await Hive.openBox<ReporteAltaLocal>(ReporteAltaLocal.boxName);
    _boxNames[LocalStorage] = LocalStorage.boxName;
    _boxNames[ReporteAltaLocal] = ReporteAltaLocal.boxName;
  }
}