import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:http/http.dart' as http;
import 'package:integradora/src/model/user.dart';
import 'package:integradora/src/provider/users_provider.dart';

class PushNotificationsProvider{

  AndroidNotificationChannel channel;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void initNotifications()async{
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }






void onMessageListener(){
    //segundo plano
  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage message) {
    if (message != null) {
      print('Nueva notificación: $message');
    }
  });

    //Recibir las notificaciones en primer plano (abierta)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: 'launch_background',
          ),
        ),
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    /*Navigator.pushNamed(
      context,
      '/message',
      arguments: MessageArguments(message, true),
    );*/
  });
}

  void saveToken(User user, BuildContext context)async{
      String token = await FirebaseMessaging.instance.getToken();
      UsersProvider usersProvider = new UsersProvider();
      usersProvider.init(context, sessionUser: user);
      usersProvider.updateNotificationToken(user.id, token);
  }


  Future<void> sendMessage(String to, Map<String, dynamic> data, String title, String body) async{
    Uri uri = Uri.https('fcm.googleapis.com', '/fcm/send');

    await http.post(
      uri,
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Authorization': 'key=AAAAjS-kums:APA91bELiGR4Qs29EDpQpqFCjoC6AUBmt6uUZwe-kFOGVuumosTXdlFdiECpt0nk24jd7K6elYfalltoG83EiuMnaDbPH3BqKP7WV26EXFwUlXyjzsHT06rsrbwXh2ZTRajF0t4jgiyd'
      },
      body:  jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': body,
          'title': title,
        },
        'priority': 'high',
        'ttl': '4500s',
        'data': data,
        'to': to

      }
      )
    );
  }

  Future<void> sendMessageMultiple(List<String> toList, Map<String, dynamic> data, String title, String body) async{
    Uri uri = Uri.https('fcm.googleapis.com', '/fcm/send');

    await http.post(
        uri,
        headers: <String, String> {
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAAjS-kums:APA91bELiGR4Qs29EDpQpqFCjoC6AUBmt6uUZwe-kFOGVuumosTXdlFdiECpt0nk24jd7K6elYfalltoG83EiuMnaDbPH3BqKP7WV26EXFwUlXyjzsHT06rsrbwXh2ZTRajF0t4jgiyd'
        },
        body:  jsonEncode(
            <String, dynamic>{
              'notification': <String, dynamic>{
                'body': body,
                'title': title,
              },
              'priority': 'high',
              'ttl': '4500s',
              'data': data,
              'registration_ids': toList

            }
        )
    );
  }


}