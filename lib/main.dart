import 'package:flutter/material.dart';
import 'package:gerencia_estado_mobx/screens/stores/login_store.dart';
import 'package:provider/provider.dart';

import 'screens/login_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => LoginStore(),
      child: MaterialApp(
        title: 'MobX Tutorial',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          scaffoldBackgroundColor: Colors.deepPurpleAccent,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
