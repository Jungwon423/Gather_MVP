import 'package:flutter/material.dart';
import 'package:gather_mvp/routes.dart';
import 'package:provider/provider.dart';

import 'Provider/provider_chat.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProviderChat()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '커리비',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/cafe",
      routes: route,
    );
  }
}