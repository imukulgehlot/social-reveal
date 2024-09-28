import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../basic_features.dart';
import '../utils/logger_util.dart';
import 'push_notification_entity.dart';

class NotificationManager {
  //
  bool iosNotify = false;

  init() {
    Future onSelectNotification(String data) async {
      if (kDebugMode) {
        print("onSelectNotification==? $onSelectNotification");
      }
      PushNotificationEntity p =
          PushNotificationEntity.fromJson(jsonDecode(data));
      _reDirectNotification(p, false);
    }

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

//VIEW IN PERMISSION IN IOS SETTING WHILE requestAlertPermission &&requestBadgePermission IS TRUE
    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // your call back to the UI
      },
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        onSelectNotification(notificationResponse.payload!);
      },
    );

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );

    Future<void> _showNotification(
        String title, String body, String param) async {
      var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
          'Push Notifications', 'Push Notifications description',
          importance: Importance.max,
          playSound: true,
          sound: RawResourceAndroidNotificationSound(""),
          showProgress: true,
          priority: Priority.high,
          ticker: 'test ticker');

      //  var iOSChannelSpecifics =  IOSNotificationDetails();
      var iOSChannelSpecifics = const DarwinNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
      await flutterLocalNotificationsPlugin
          .show(0, title, body, platformChannelSpecifics, payload: param);
    }

    void showNotification(String? title, String? body, String param) async {
      await _showNotification(title!, body!, param);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification?.android;
      // print('p.runtimeType== p p pp onMessage=> ${p}');

      logger.w('p.runtimeType==onMessage=> ${message.toString()}');
      logger.w('p.runtimeType=map=onMessage=> ${message.toMap()}');
      logger.w('p.runtimeType=[other=onMessage=> ${message.data}');
      logger.w('p.runtimeType=body=onMessage=> ${notification?.body!}');
      logger.w('p.runtimeType=data=onMessage=> ${message.data.toString()}');

      if (!iosNotify) {
        showNotification(message.notification?.title ?? "",
            message.notification?.body ?? "", jsonEncode(message.data));
      } else {
        iosNotify = false;
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;

      if (kDebugMode) {
        print(
            "onMessageOpenedApp message.notification.body:- ${message.data.toString()}");
        print(
            "onMessageOpenedApp notification.title:-  ${notification.title.toString()}");
      }
      PushNotificationEntity p =
          PushNotificationEntity.fromJson(jsonDecode(jsonEncode(message.data)));

      iosNotify = true;
      _reDirectNotification(p, false);
    });
    // FirebaseMessaging.onBackgroundMessage((_firebaseMessingBackgroundHandler));
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      Firebase.initializeApp();
      if (kDebugMode) {
        print("FirebaseMessaging.getInitialMessage=======> $message");
      }

      Future.delayed(const Duration(seconds: 3), () {
        if (message != null) {
          PushNotificationEntity p = PushNotificationEntity.fromJson(
              jsonDecode(jsonEncode(message.data)));

          //  MyApp.splashTimer!.cancel();

          iosNotify = true;
          _reDirectNotification(p, true);
        }
      });
    });

/* FirebaseMessaging.onBackgroundMessage.call((message) {

      print('A new onMessageOpenedApp event was published!');
      print('on lklklklk   ==> $message');

      Navigator.of(GlobalVariable.navigatorKey.currentContext).
      push(MaterialPageRoute(builder: (context) =>
          UserCritiqueDetailsScreen(critiqueId:"85")));
      return ;


    });*/
  }

  _reDirectNotification(PushNotificationEntity p, bool isFromTerminatedState) {
    logger.e("notification redirect hear now");
    // if (p.type == 2 || p.type == 3 || p.type == 4 || p.type == 6) {
    //   //2  job request

    //   Navigator.of(GlobalVariable.navigatorKey.currentContext!)
    //       .push(MaterialPageRoute(
    //     builder: (context) => ContainerHistoryScreen(
    //         tabId: 1, isFromTerminatedState: isFromTerminatedState),
    //   ));
    // } else if (p.type == 5) {
    //   //2  job request

    //   Navigator.of(GlobalVariable.navigatorKey.currentContext!)
    //       .push(MaterialPageRoute(
    //     builder: (context) => ContainerHistoryScreen(
    //         tabId: 2, isFromTerminatedState: isFromTerminatedState),
    //   ));
    // }
  }
}
