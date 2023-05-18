// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:validators/validators.dart';


class MostrarPass extends StatefulWidget {
  final String codeUnits;
  final String correoReceptor;
  const MostrarPass(this.codeUnits, this.correoReceptor, {Key? key}) : super(key : key);

@override
  MostrarPassState createState() {
    return MostrarPassState();
  }

}

class MostrarPassState extends State<MostrarPass>{

final _formKey = GlobalKey<FormState>();
final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 94, 18, 12),
);

String _codigo = "";

Future<void> comprobarCodigo(codigo, correoReceptor, codeUnits) async {

if (_formKey.currentState!.validate()) {

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Socios').where('email', isEqualTo: correoReceptor).get();

      if (querySnapshot.docs.length > 0) {

        if(codigo == codeUnits){

          DocumentSnapshot userData = await FirebaseFirestore.instance
                                  .collection('Socios')
                                  .doc(querySnapshot.docs[0].id)
                                  .get();

          String password = userData['password'];

          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Contraseña'),
                content: Text('Su contraseña es: $password'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cerrar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );



        }

      }else {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No se encontró un usuario con esas correo')),
              );
              }
}

 _formKey.currentState!.reset();

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
                decoration: const InputDecoration(labelText: 'Codigo'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa tu Codigo';
                  }
                  return null;
                },
                onSaved: (value) {
                  _codigo = value!;
                },
              ),
                       
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      comprobarCodigo(_codigo,widget.correoReceptor,widget.codeUnits);
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