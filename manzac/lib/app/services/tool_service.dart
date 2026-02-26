import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show rootBundle;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/literals.dart';

class ToolService extends GetxController {
  final _storage = FlutterSecureStorage();
  final Connectivity _conneccion = Connectivity();
  final snackbarTitulo = ''.obs;
  final snackbarMensaje = ''.obs;
  final snackbarVisible = false.obs;

  Future<bool> isOnline() async {
    try {
      var coneccion = await _conneccion.checkConnectivity();
      var wifi = coneccion.contains(ConnectivityResult.wifi);
      var datosMobiles = coneccion.contains(ConnectivityResult.mobile);
      return wifi || datosMobiles;
    } catch (_) {
      return false;
    }
  }

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
    final imageBytes = await imageFile.readAsBytes();
    final img.Image? original = img.decodeImage(imageBytes);
    if (original == null) return imageFile;
    img.Image resized = original;
    if (original.width > maxWidth) {
      resized = img.copyResize(original, width: maxWidth);
    }
    final newPath = '${imageFile.parent.path}/${DateTime.now().millisecondsSinceEpoch}_${path.basename(imageFile.path)}';
    final compressedFile = File(newPath)
      ..writeAsBytesSync(
        img.encodeJpg(resized, quality: quality),
      );
    return compressedFile;
  }

  Future<String> getImageBase64(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      Uint8List bytes = response.bodyBytes;
      return base64Encode(bytes);
    } else {
      throw "";
    }
  }

  Future<String> guardarImagen(File imageTemp, String subfijo) async {
    var dir = await getApplicationDocumentsDirectory();
    var carpeta = Directory("${dir.path}/${Literals.rutaImagenesApp}");
    if (!await carpeta.exists()) {
      await carpeta.create(recursive: true);
    }
    var nombreArchivo = "${subfijo}_${DateTime.now().millisecondsSinceEpoch}${path.extension(imageTemp.path)}";
    var nuevaRuta = "${carpeta.path}/$nombreArchivo";
    var nuevaImagen = await imageTemp.copy(nuevaRuta);
    return nuevaImagen.path;
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

  Future<String> getSecureStorage(String key) async {
    try {
      var idLocalStorage = await _storage.read(
        key: key,
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock
        ),
      );
      return idLocalStorage!;
    } catch(e) {
      return "";
    }
  }

  Future<void> setSecureStorage(String key, String id) async {
    await _storage.write(
      key: key,
      value: id,
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock
      ),
    );
    return;
  }

  void mostrarSnackbarProgreso(String titulo, String mensaje) {
    snackbarTitulo.value = titulo;
    snackbarMensaje.value = mensaje;
    
    if (!snackbarVisible.value) {
      snackbarVisible.value = true;
      Get.rawSnackbar(
        duration: null,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.zero,
        snackPosition: SnackPosition.BOTTOM,
        messageText: Obx(() => _buildSnackContent()),
        titleText: SizedBox.shrink(),
      );
    }
  }

  Widget _buildSnackContent() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            snackbarTitulo.value,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 4),
          Text(
            snackbarMensaje.value,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  void cerrarSnackbar() {
    snackbarVisible.value = false;
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
  }

  Future<void> guardarArchivoTxt(String nombre, String contenido) async {
    try {
      var ruta = await getApplicationDocumentsDirectory();
      var directorio = ruta.path;
      var archivo = File("$directorio/$nombre.txt");
      var _ = await archivo.writeAsString(contenido);
      return;
    } catch(e) {
      return;
    }
  }

  Future<String> leerArchivoTxt(String nombre) async {
    try {
      var ruta = await getApplicationDocumentsDirectory();
      var directorio = ruta.path;
      var archivo = File("$directorio/$nombre.txt");
      return await archivo.readAsString();
    } catch(e) {
      return "";
    }
  }
}