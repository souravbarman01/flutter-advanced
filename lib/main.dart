import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_utils/src/platform/platform.dart';

import 'core/helper/get_di.dart' as di;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /*///Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };


  ///Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };*/

  /* if(GetPlatform.isWeb){
    await Firebase.initializeApp(options: const FirebaseOptions(
        apiKey: "AIzaSyD0Z911mOoWCVkeGdjhIKwWFPRgvd6ZyAw",
        authDomain: "stackmart-500c7.firebaseapp.com",
        projectId: "stackmart-500c7",
        storageBucket: "stackmart-500c7.appspot.com",
        messagingSenderId: "491987943015",
        appId: "1:491987943015:web:d8bc7ab8dbc9991c8f1ec2"
    ));
  }  */

    if(GetPlatform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBJhxsY7Hdo2rBqWpgYEl07xflWiIUA3dY",
        appId: "1:83177097833:android:e2c9eb3a6531bafeee30f8",
        messagingSenderId: "83177097833",
        projectId: "flutter-advanced-73a0b",
        storageBucket: "flutter-advanced-73a0b.firebasestorage.app",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

   Map<String, Map<String, String>> languages = await di.init();

  // NotificationBodyModel? body;
  // try {
  //   if (GetPlatform.isMobile) {
  //     final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
  //     if (remoteMessage != null) {
  //       body = NotificationHelper.convertNotification(remoteMessage.data);
  //     }
  //     await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  //     FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  //   }
  // }catch(_) {}
  //
  // if (ResponsiveHelper.isWeb()) {
  //   await FacebookAuth.instance.webAndDesktopInitialize(
  //     appId: "380903914182154",
  //     cookie: true,
  //     xfbml: true,
  //     version: "v15.0",
  //   );
  // }

  runApp(MyApp(languages: languages));
}

class MyApp extends StatefulWidget {
  final Map<String, Map<String, String>>? languages;
  const MyApp({super.key, required this.languages});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text("Welcome to 6pm"),
        ),
      ),
      );
  }
}

