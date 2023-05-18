import 'package:app_ajav/paginas/perfil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_ajav/firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
// ignore: unused_import
import 'package:validators/validators.dart';
import 'package:app_ajav/paginas/recuperarPass.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Color.fromARGB(255, 209, 212, 207), 
      ),  
      home: Scaffold(
        body: Stack(
          children: [
            Container(
          decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/logologin.png'),
        fit: BoxFit.none
          ),
          ),
          child: const Positioned(
              top: 120,
              left: 50,
              child: LoginForm(), 
            ),
          ),
          ],
    )));
  }
}


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

@override
  LoginFormState createState() {
    return LoginFormState();
  }

}

class LoginFormState extends State<LoginForm>{

bool _obscureText = true;
final _formKey = GlobalKey<FormState>();
final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 116, 24, 17),
);

String _dni = '';
String _password = '';
final databaseReference = FirebaseDatabase.instance.ref();

Future<void> login(String dni,String password) async {

// Verificar si el DNI está registrado en Firebase
try {
    
if (_formKey.currentState!.validate()) {
            // Realizar una consulta a la base de datos para verificar las credenciales del usuario
            QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Socios').where('dni', isEqualTo: dni).get();
            // ignore: prefer_is_empty
            if (querySnapshot.docs.length > 0) {

              DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
              String storedPassword = documentSnapshot['password'];
              // Verificar si la contraseña ingresada coincide con la contraseña almacenada en la base de datos
              if (storedPassword == password) {
                // Iniciar sesión en la aplicación
                // ...
                        DocumentSnapshot userData = await FirebaseFirestore.instance
                                  .collection('Socios')
                                  .doc(querySnapshot.docs[0].id)
                                  .get();
                        
                    String nombre = userData['nombre'];
                    String apellidos = userData['apellidos'];
                    String numsocio = userData['numsocio'];
                    String rol = userData['rol'];

    // Redirige al usuario a la pantalla principal después de iniciar sesión exitosamente
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Perfil(nombre,apellidos,numsocio,rol)));

              } else {
               // ignore: use_build_context_synchronously
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contraseña incorrecta')),
                );
              }
            } else {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No se encontró un usuario con esas credenciales')),
              );
            }

            _formKey.currentState!.reset();
          }
  } catch (e) {

    print(e);
    // Muestra un mensaje de error al usuario si la autenticación falla
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error al iniciar sesión')),
    );
  }
  
}

@override
  Widget build(BuildContext context) {
      return Padding(
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
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'DNI'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa tu DNI';
                  }
                  return null;
                },
                onSaved: (value) {
                  _dni = value!;
                },
              ),
              TextFormField(
                          obscureText: _obscureText,
                          validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa tu contraseña';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                        ),
                        
                ),
              ),
            Builder(
                             builder: (context) {
                               return TextButton(
                                           onPressed: () { 
                                                Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => const RecuperarPass())
                                            );
                                            },
                                           child: const Text('¿Olvidastes contraseña?'),
                                         );
                             }
                           ),
              ElevatedButton(
                style: raisedButtonStyle,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    login(_dni, _password);
                  }
                },
                child: const Text('Iniciar sesión'),
              ),
            
            ],
        ),
      ),
      ),
                ]
      ));

}
}