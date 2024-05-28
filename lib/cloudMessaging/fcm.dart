import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
//firebase cloud messaging
class FirebaseCm{
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifictaions() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    debugPrint('Token: $fCMToken');
    initPushNotifications();
  }
  void handleMessage(RemoteMessage? message){
    if(message == null) return;
    navigatorKey.currentState?.pushNamed('/notification_screen',arguments: message,);
  }
  Future initPushNotifications() async{
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}