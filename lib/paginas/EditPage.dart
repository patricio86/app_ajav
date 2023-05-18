import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  const EditPage({
    Key? key,
    required this.docID,
  }) : super(key: key);
  final String docID;
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  //form key
  final _formkey = GlobalKey<FormState>();
  //Update User
  CollectionReference updateUser =
      FirebaseFirestore.instance.collection('Socios');
  Future<void> _updateUser(id, nombre, apellidos, dni, numsocio, rol) {
    return updateUser
        .doc(id)
        .update({
          'nombre': nombre,
          'apellidos': apellidos,
          'dni': dni,
          'numsocio': numsocio,
          'rol': rol,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('Socios')
            .doc(widget.docID)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Something Wrong in HomePage');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //Getting Data From FireStore
          var data = snapshot.data?.data();
          var nombre = data!['nombre'];
          var apellidos = data['apellidos'];
          var dni = data['dni'];
          var numsocio = data['numsocio'];
          var rol = data['rol'];
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 90, 2, 31),
              title: const Text('Actualizar'),
            ),
            body: Form(
              key: _formkey,
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      initialValue: nombre,
                      onChanged: (value) {
                        nombre = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Nombre',
                        labelStyle: TextStyle(fontSize: 18),
                        errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please Fill Nombre';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      initialValue: apellidos,
                      onChanged: (value) {
                        apellidos = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Apellidos',
                        labelStyle: TextStyle(fontSize: 18),
                        errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please Fill Apellidos';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      initialValue: dni,
                      onChanged: (value) {
                        dni = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'DNI',
                        labelStyle: TextStyle(fontSize: 18),
                        errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please Fill DNI';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      initialValue: numsocio,
                      onChanged: (value) {
                        numsocio = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Num Socio',
                        labelStyle: TextStyle(fontSize: 18),
                        errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please Fill Num Socio';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      initialValue: rol,
                      onChanged: (value) {
                        numsocio = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Rol',
                        labelStyle: TextStyle(fontSize: 18),
                        errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please Fill Rol';
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color.fromARGB(255, 71, 6, 2)),
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              _updateUser(widget.docID, nombre, apellidos, dni, numsocio,rol);
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: const Text('Actualizar'),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}