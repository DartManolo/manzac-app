import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

import '../utils/literals.dart';

class ToolService extends GetxController {
  String guid() {
    const uuid = Uuid();
    var newGuid = uuid.v4();
    return newGuid;
  }

  Future<void> wait([int segundos = 2]) async {
    await Future.delayed(Duration(seconds: segundos));
    return;
  }  

  bool isNullOrEmpty(TextEditingController? input) {
    return input?.text == "" || input == null;
  }

  bool isEmail(String cadena) {
    var esEmail = RegExp(Literals.regexEmail).hasMatch(cadena);
    return esEmail;
  }

  bool isObject(dynamic data) {
    return isJson(data) || isArray(data) || isJsonArray(data);
  }

  bool isJson(dynamic elemento) {
    try {
      var jsonCadena = jsonEncode(elemento);
      return jsonCadena[jsonCadena.length - 1] == "}";
    } catch (e) {
      return false;
    }
  }

  bool isArray(dynamic elemento) {
    try {
      var jsonCadena = jsonEncode(elemento);
      return jsonCadena[jsonCadena.length - 1] == "]";
    } catch (e) {
      return false;
    }
  }

  bool isJsonArray(dynamic data) {
    try {
      var cadAux = jsonEncode(data);
      var cadJson = cadAux[cadAux.length - 2] + cadAux[cadAux.length - 1];
      return cadJson == "}]";
    } catch (e) {
      return false;
    }
  }

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  bool str2bool(String cadena) {
    return cadena.toLowerCase() == 'true';
  }

  double str2double(String cadena) {
    return double.tryParse(cadena) ?? 0.0;
  }

  int str2int(String cadena) {
    return int.tryParse(cadena) ?? 0;
  }

  DateTime str2date(String cadena) {
    var dateArr = cadena.split("-");
    return DateTime.utc(
        int.parse(dateArr[2]), int.parse(dateArr[1]), int.parse(dateArr[0]));
  }

  String fechaHoy([String formato = "dd-MM-yyyy"]) {
    var fechaHoy = DateFormat(formato).format(DateTime.now()).toString();
    return fechaHoy;
  }

  String horaHoy() {
    var selectedHour = TimeOfDay.now();
    var horaAux = selectedHour.hour;
    var prefijo = "a.m.";
    var hora = horaAux;
    if(horaAux == 0) {
      hora = 12;
    } else if(horaAux > 12) {
      hora = horaAux - 12;
      prefijo = "p.m.";
    }
    if(horaAux == 12) {
      prefijo = "p.m.";
    }
    var minutos = selectedHour.minute;
    return "${(hora > 9 ? "$hora" : "0$hora")}:${(minutos > 9 ? "$minutos" : "0$minutos")} $prefijo";
  }

  Future<String> imagen2base64(File? imgArchivo) async {
    var fotoBytes = await imgArchivo!.readAsBytes();
    var base64Foto = base64Encode(fotoBytes);
    return base64Foto;
  }

  Future<File> imagenResize(File imageFile, {int maxWidth = 1024, int quality = 65}) async {
    var imageBytes = await imageFile.readAsBytes();
    img.Image? original = img.decodeImage(imageBytes);

    if (original == null) return imageFile; 
    img.Image resized = img.copyResize(original, width: maxWidth);
    File compressedFile = File(imageFile.path)
      ..writeAsBytesSync(img.encodeJpg(resized, quality: quality));
    return compressedFile;
  }

  void closeBottomSheet() {
    var sysContext = Get.context!;
    Navigator.of(sysContext, rootNavigator: true).pop(true);
  }

  void debug(dynamic e, [bool isJson = false]) {
    // ignore: avoid_print
    print(isJson ? jsonEncode(e) : e);
  }

  Future<Uint8List> loadAssetImage(String path) async {
    var data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  String fecha(String formato, [DateTime? fechaPers]) {
    var hoy = fechaPers ?? DateTime.now();
    return DateFormat(
     formato,
     'es_MX'
    ).format(hoy);
  }
}