import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../core/routing/route.dart';
import '../screens/children/child_details/tab/detailsItems/details_item.dart';
import '../screens/children/children_provider.dart';
import '../screens/notification/notification_provider.dart';

class NotificationServices {

  FirebaseMessaging messaging = FirebaseMessaging.instance ;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin  = FlutterLocalNotificationsPlugin();
  void initLocalNotifications(BuildContext context, RemoteMessage message)async{
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings ,
        iOS: iosInitializationSettings
    );
    await _flutterLocalNotificationsPlugin.initialize(
        initializationSetting,
      onDidReceiveNotificationResponse: (payload){
          handleMessage(context, message,false);
      }
    );
  }
  void firebaseInit(BuildContext context){
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification ;
      AndroidNotification? android = message.notification?.android ;
      if(Platform.isIOS){
        forgroundMessage();
      }
      if(Platform.isAndroid){
        initLocalNotifications(context, message);
        showNotification(message);
      }
      setFCMDataInApp(message,context);
    });
  }
  setFCMDataInApp(RemoteMessage message,BuildContext context){
    Provider.of<NotificationProvider>(context, listen: false).getCountNotification(context, message.data["student_id"].toString());
    Provider.of<NotificationProvider>(context, listen: false).getNotificationList(context, message.data["student_id"].toString());
    Provider.of<StudentsProvider>(context, listen: false).getStudentsList(context,message.data["parent_id"].toString());
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true ,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
      }
    } else {
      if (kDebugMode) {
      }
    }
  }
  Future<Map<Permission, PermissionStatus>> requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.notification
    ].request();
    return statuses;
  }
  Future<void> showNotification(RemoteMessage message)async{
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString() ,
      importance: Importance.max  ,
      showBadge: true ,
      playSound: true,
        sound: null
    );
     AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString() ,
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.high ,
      playSound: true,
      ticker: 'ticker' ,
         sound: channel.sound
    );
    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true ,
      presentBadge: true ,
      presentSound: true
    ) ;
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails
    );
    Future.delayed(Duration.zero , (){
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title.toString(),
          message.notification?.body.toString(),
          notificationDetails ,
      );
    });
  }
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token ?? "";
  }
  Future<void> setupInteractMessage(BuildContext context)async{
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if(initialMessage != null){
      handleMessage(context, initialMessage,true);
    }
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event,false);
    });
  }
  void handleMessage(BuildContext context, RemoteMessage message,bool isTerminatedApp) {
      Timer( Duration(seconds: isTerminatedApp ? 6 : 0), () {
        push(DetailsItems(witchScreen: message.data["type"].toString(), itemId: message.data["foreign_id"].toString(), studentId: message.data["student_id"].toString(),));
      });
  }
  Future forgroundMessage() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }


}