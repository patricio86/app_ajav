import 'package:app_ajav/paginas/listarsocios.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class Admin extends StatelessWidget {
  const Admin({super.key});

 @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initailization = Firebase.initializeApp();
    return FutureBuilder(
        future: _initailization,
        builder: (context, snapshot) {
          //Something from Firebase
          if (snapshot.hasError) {
            print('Something Went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                appBarTheme: const AppBarTheme(
                  centerTitle: true,
                ),
              ),
              home: const Listarsocios(),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

}