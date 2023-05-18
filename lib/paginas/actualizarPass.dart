import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


// ignore: unused_import
import 'package:validators/validators.dart';


class ActualizarPass extends StatefulWidget {
  const ActualizarPass({super.key});

@override
  State<ActualizarPass> createState() => ActualizarPassState();
  }

class ActualizarPassState extends State<ActualizarPass>{

final _formKey = GlobalKey<FormState>();
final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 94, 18, 12),
);



final databaseReference = FirebaseDatabase.instance.ref();

Future<void> recover(String email) async {

// Verificar si el DNI está registrado en Firebase


              }

    // Redirige al usuario a la pantalla principal después de iniciar sesión exitosamente
    // ignore: use_build_context_synchronously
    

     @override
            Widget build(BuildContext context) {
              return MaterialApp (
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                canvasColor: Colors.yellow,
                ),
                home: Scaffold(
                  body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Image.asset('assets/logo.png'),
                  ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(labelText: 'Contraseña Antigua'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor ingresa tu Contraseña Antigua';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  
                                },
                              ),
                                  TextFormField(
                                decoration: const InputDecoration(labelText: 'Contraseña Nueva'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor ingresa tu Contraseña Nueva';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  
                                },
                              ),    
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Modificar'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                                ],
                      )
                      )
                )
              );
          }
          
           
          
  } 
  







