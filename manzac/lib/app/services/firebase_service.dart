import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/local_storage/local_storage.dart';
import '../data/models/system/notificacion_data.dart';
import '../utils/literals.dart';
import 'storage_service.dart';

class FirebaseService {
  final StorageService _storage = Get.find<StorageService>();

  Future<void> init() async {
    try {
      await Firebase.initializeApp();
      var token = await FirebaseMessaging.instance.getToken();
      await _updateFirebaseToken(token!);
      FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
      FirebaseMessaging.onMessage.listen((RemoteMessage message) => _onMessage(message.data));
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) => _onMessageOpen(message.data));
    } finally {
      FirebaseMessaging.instance.subscribeToTopic(Literals.notificacionTopic);
    }
  }

  void _onMessage(Map<String, dynamic> data) {
    try {
      var notificacion = NotificacionData.fromServer(data);
      switch(notificacion.accion) {
        case "USER-FORBIDEN-LOGOUT":
          Get.snackbar(
            'Atención!',
            notificacion.contenido,
            snackPosition: SnackPosition.BOTTOM,
            duration: 15.seconds,
            backgroundColor: Color(0xFFFADBD8),
          );
        default:
        return;
      }
    } finally { }
  }

  void _onMessageOpen(Map<String, dynamic> data) {
    try {

    } finally { }
  }

  Future<void> _updateFirebaseToken(String token) async {
    try {
      var localStorageTemp = await _storage.getAll<LocalStorage>();
      if(localStorageTemp.isEmpty) {
        return;
      }
      var localStorage = localStorageTemp.first;
      localStorage.idFirebase = token;
      await _storage.save(localStorage);
      return;
    } finally { }
  }
}

@pragma('vm:entry-point')
Future<void> _onBackgroundMessage(RemoteMessage data) async {
  try {
    
  } catch(e) {
    return;
  }
}