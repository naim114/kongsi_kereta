import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kongsi_kereta/firebase_options.dart';
import 'package:kongsi_kereta/src/model/user_model.dart';
import 'package:kongsi_kereta/wrapper.dart';
import 'package:provider/provider.dart';

import 'src/services/auth_services.dart';

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
  MaterialColor primaryColorShades = const MaterialColor(
    0xFF643FDB,
    <int, Color>{
      50: Color.fromRGBO(100, 63, 219, .1),
      100: Color.fromRGBO(100, 63, 219, .2),
      200: Color.fromRGBO(100, 63, 219, .3),
      300: Color.fromRGBO(100, 63, 219, .4),
      400: Color.fromRGBO(100, 63, 219, .5),
      500: Color.fromRGBO(100, 63, 219, .6),
      600: Color.fromRGBO(100, 63, 219, .7),
      700: Color.fromRGBO(100, 63, 219, .8),
      800: Color.fromRGBO(100, 63, 219, .9),
      900: Color.fromRGBO(100, 63, 219, 1),
    },
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kongsi Kereta',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primarySwatch: primaryColorShades,
      ),
      home: StreamProvider<UserModel?>.value(
        initialData: null,
        lazy: true,
        value: AuthService().onAuthStateChanged,
        catchError: (context, error) {
          print('An error occurred: $error');
          return null;
        },
        updateShouldNotify: (previous, current) {
          print('Previous Stream UserModel: ${previous.toString()}');
          print('Current Stream UserModel: ${current.toString()}');
          return true;
        },
        builder: (context, snapshot) {
          return const Wrapper();
        },
      ),
    );
  }
}
