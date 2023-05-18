import 'package:app_ajav/constraints.dart/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  //form key
  final _formkey = GlobalKey<FormState>();
  // text for textfield
  String nombre = '';
  String apellidos = '';
  String dni = '';
  String numsocio = '';
  String rol = '';
  // textfield
  final nombreController = TextEditingController();
  final apellidosController = TextEditingController();
  final dniController = TextEditingController();
  final numsocioController = TextEditingController();
  final rolController = TextEditingController();

  //Clearing Text
  _clearText() {
    nombreController.clear();
    apellidosController.clear();
    dniController.clear();
    numsocioController.clear();
    rolController.clear();
  }

  //Resigtering Users
  CollectionReference addUser =
      FirebaseFirestore.instance.collection('Socios');
  Future<void> _registerUser() {
    return addUser
        .add({'nombre': nombre, 'apellidos': apellidos, 'dni': dni, 'numsocio': numsocio, 'rol':rol})
        .then((value) => print('User Added'))
        .catchError((_) => print('Something Error In registering User'));
  }

  //Disposing Textfield
  @override
  void dispose() {
    nombreController.dispose();
    apellidosController.dispose();
    dniController.dispose();
    numsocioController.dispose();
    rolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 90, 2, 31),
        title: const Text('Añadir'),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: [
            CustomTextEditField(
              controller: nombreController,
              labettxt: 'Nombre',
              visibility: false,
            ),
            CustomTextEditField(
              controller: apellidosController,
              labettxt: 'Apellidos',
              visibility: false,
            ),
            CustomTextEditField(
              controller: dniController,
              labettxt: 'DNI',
              visibility: false,
            ),
            CustomTextEditField(
              controller: numsocioController,
              labettxt: 'Num Socio',
              visibility: false,
            ),
            CustomTextEditField(
              controller: rolController,
              labettxt: 'Rol',
              visibility: false,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        nombre = nombreController.text;
                        apellidos = apellidosController.text;
                        dni = dniController.text;
                        numsocio = numsocioController.text;
                        rol = rolController.text;
                        _registerUser();
                        _clearText();
                        Navigator.pop(context);
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  child: const Text('Añadir'),
                ),
                ElevatedButton(
                  onPressed: _clearText,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  child: const Text('Limpiar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
