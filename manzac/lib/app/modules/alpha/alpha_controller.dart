import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  LocalStorage? _localStorage;

  @override
  Future<void> onInit() async {
    await _init();
    super.onInit();
  }

  Future<void> _init() async {
    try {
      await storage.init();
      await _localStorageInit();
      await tool.wait();
      _page = _localStorage!.login! ? const HomePage() : const LoginPage();
      _binding = _localStorage!.login! ? HomeBinding() : LoginBinding();
      GetInjection.administrador = _localStorage!.perfil! == Literals.perfilAdministrador;
      GetInjection.perfil = _localStorage!.perfil!;
      await firebase.init();
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
        arguments: {
          "nombre" : _localStorage!.nombre,
          "usuario" : _localStorage!.usuario,
        }
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

  Future<void> _localStorageInit() async {
    try {
      var localStorageTemp = await storage.getAll<LocalStorage>();
      var idLocalStorageTemp = tool.guid();
      if(localStorageTemp.isNotEmpty) {
        _localStorage = localStorageTemp.first;
        idLocalStorageTemp = _localStorage!.id!;
      } else {
        _localStorage = LocalStorage(id: idLocalStorageTemp,);
        await storage.save<LocalStorage>(_localStorage!);
      }
      await setIdLocalStorage(idLocalStorageTemp);
      return;
    } catch(e) { return; }
  }
}