import 'package:flutter/material.dart';
import 'Principal.dart';
import 'Registrar.dart';
import 'Editar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          /* colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 72, 0, 196)),
        useMaterial3: true,*/
          primaryColor: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => Principal(),
        '/Registrar': (context) => Registrar(),
        '/Editar': (context) => Editar(),
      },
      //home: const alerta(),
    );
  }
}
