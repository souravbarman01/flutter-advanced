import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_utils/src/platform/platform.dart';

import 'core/helper/get_di.dart' as di;
import 'core/routes/app_router.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
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
      options: FirebaseOptions(
        apiKey: dotenv.env['FIREBASE_API_KEY']!,
        appId: dotenv.env['FIREBASE_APP_ID']!,
        messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
        projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET']!,
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
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: '6pm',
      routerDelegate: AppRouter.router.routerDelegate,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      );
  }
}

