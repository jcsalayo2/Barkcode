import 'package:barkcode/core/route/fluro_router.dart';
import 'package:barkcode/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FloruRouter.initRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BarkCode',
      initialRoute: "/",
      theme: ThemeData(
        fontFamily: "DM-Sans",
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      onGenerateRoute: FloruRouter.fluroRouter.generator,
    );
  }
}
