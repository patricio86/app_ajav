// ignore: file_names
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:app_ajav/paginas/mostrarPass.dart';

// ignore: unused_import
import 'package:validators/validators.dart';


class RecuperarPass extends StatefulWidget {
  const RecuperarPass({super.key});

@override
  State<RecuperarPass> createState() => RecuperarPassState();
  }

class RecuperarPassState extends State<RecuperarPass>{

final _formKey = GlobalKey<FormState>();
final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 94, 18, 12),
);

String correoReceptor = "";
final String _correoEmisor = 'jovenesamigosdelvino@gmail.com';
final String _contrasenaEmisor = 'Amigos2021';
final String _asunto = 'Código de recuperación de contraseña';
String codeUnits = '';
int length = 6;

final databaseReference = FirebaseDatabase.instance.ref();

Future<void> recover(correoReceptor) async {

// Verificar si el DNI está registrado en Firebase

if (_formKey.currentState!.validate()) {
            // Realizar una consulta a la base de datos para verificar las credenciales del usuario
            QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Socios').where('email', isEqualTo: correoReceptor).get();
            // ignore: prefer_is_empty
            if (querySnapshot.docs.length > 0) {
              // ignore: unused_element
              String generateRandomCode(length) {
                final random = Random();
                const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
                final codeUnits = List.generate(
                  length,
                  (_) => chars.codeUnitAt(random.nextInt(chars.length)),
                );
                return String.fromCharCodes(codeUnits);
              }

              // ignore: unused_element
              
              enviarCorreo();

    // Redirige al usuario a la pantalla principal después de iniciar sesión exitosamente
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MostrarPass(codeUnits,correoReceptor)));

              } else {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No se encontró un usuario con esas correo')),
              );
              }
            } 

            _formKey.currentState!.reset();
          }
          
          Future<void> enviarCorreo() async {
                final smtpServer = gmail(_correoEmisor, _contrasenaEmisor);
                
                final message = Message()
                  ..from = Address(_correoEmisor, 'Asociacion Jovenes Amigos del Vino de Valdepeñas')
                  ..recipients.add(correoReceptor)
                  ..subject = _asunto
                  ..text = 'Su código de recuperación de contraseña es: $codeUnits';
                
                try {
                  final sendReport = await send(message, smtpServer);
                  print('Mensaje enviado: ${sendReport.toString()}');
                } on MailerException catch (e) {
                  print('Error al enviar el mensaje: $e');
                }
              }

            @override
            Widget build(BuildContext context) {
              return MaterialApp (
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                canvasColor: Color.fromARGB(255, 188, 189, 184),
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
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(labelText: 'Correo Electronico'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor ingresa tu Correo Electronico';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  correoReceptor = value!;
                                },
                              ),
                                      
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      recover(correoReceptor);
                                    }
                                  },
                                  child: const Text('Enviar'),
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