import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/models/local_storage/local_storage.dart';
import '../../utils/get_injection.dart';
import '../../utils/literals.dart';
import '../home/home_binding.dart';
import '../home/home_page.dart';
import '../login/login_binding.dart';
import '../login/login_page.dart';

class AlphaController extends GetInjection {
  late StatelessWidget _page;
  late Bindings _binding;
  
  File? fotografia;
  final ImagePicker seleccionarFoto = ImagePicker();

  @override
  Future<void> onInit() async {
    await _init();
    super.onInit();
  }

  Future<void> _init() async {
    try {
      await storage.init();
      var localStorage = await storage.get<LocalStorage>(LocalStorage());
      await tool.wait();
      _page = localStorage!.login! ? const HomePage() : const LoginPage();
      _binding = localStorage.login! ? HomeBinding() : LoginBinding();
      GetInjection.administrador = localStorage.perfil! == Literals.perfilAdministrador;
      GetInjection.perfil = localStorage.perfil!;
      return;
    } catch(e) {
      return;
    } finally {
      _verificarPermisos();
      Get.offAll(
        _page,
        binding: _binding,
        transition: Transition.cupertino,
        duration: 1.5.seconds,
      );
    }
  }

  void _verificarPermisos() async {
    await Permission.notification.isDenied.then((denegado) {
      if (denegado) {
        Permission.notification.request();
      }
    });
    await Permission.storage.isDenied.then((denegado) {
      if(denegado) {
        Permission.storage.request();
      }
    });
  }

  Future<void> tomarFotografia() async {
    try {
      isBusy();
      var fotoCamara = await seleccionarFoto.pickImage(
        source: ImageSource.camera,
      );
      tool.debug(fotoCamara);
      if (fotoCamara != null) {
        var fotoTemp = File(fotoCamara.path);
        fotografia = await tool.imagenResize(fotoTemp);
        var base64Foto = await tool.imagen2base64(fotografia);
        var data = {
          "imagenb64": base64Foto
        };
        var jsonSend = [data];
        var g = await api.post("api/configuracion/test", jsonSend);
        tool.debug("------------------------- BASE64 -------------------------");
        tool.debug(base64Foto);
        tool.debug(g);
      }
    } finally {
      update();
      isBusy(false);
    }
  }
}