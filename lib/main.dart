import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gather_mvp/routes.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'Provider/provider_chat.dart';

void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String favoriteFood = 'ramen';
  await FirebaseAnalytics.instance.setUserId(id:'123456');
  await FirebaseAnalytics.instance.setUserProperty(name: 'favorite_food', value: favoriteFood);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProviderChat()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(1456, 1284),
        builder: (context, child) => MaterialApp(
              title: '커리비',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              initialRoute: "/home",
              routes: route,
              navigatorObservers: <NavigatorObserver>[observer],
            ));
  }
}
