import 'package:app_ajav/constraints.dart/textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_ajav/paginas/addPage.dart';
import 'package:app_ajav/paginas/EditPage.dart';
import 'package:flutter/material.dart';

class Listarsocios extends StatefulWidget {
  const Listarsocios({Key? key}) : super(key: key);

  @override
  State<Listarsocios> createState() => _ListarsociosState();
}

class _ListarsociosState extends State<Listarsocios>{
// Getting Student all Records
  final Stream<QuerySnapshot> sociosRecords =
      FirebaseFirestore.instance.collection('Socios').snapshots();
  // For Deleting Users
  CollectionReference delUser =
      FirebaseFirestore.instance.collection('Socios');
  Future<void> _delete(id) {
    return delUser
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((_) => print('Something Error In Deleted User'));

}

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: sociosRecords,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something Wrong in HomePage');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // Storing Data
          final List firebaseData = [];
          snapshot.data?.docs.map((DocumentSnapshot documentSnapshot) {
            Map store = documentSnapshot.data() as Map<String, dynamic>;
            firebaseData.add(store);
            store['id'] = documentSnapshot.id;
          }).toList();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 90, 2, 31),
              title: const Text('Gestion Datos'),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 255, 150, 64)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddPage(),
                        ),
                      );
                    },
                    child: const Text('Add'),
                  ),
                )
              ],
            ),
            body: Container(
              margin: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Center(
                  child: Table(
                    border: TableBorder.all(),
                    columnWidths: const <int, TableColumnWidth>{
                      1: FixedColumnWidth(150),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      TableRow(
                        children: [
                          TableCell(
                            child: Center(
                              child: Container(
                                color: Colors.orangeAccent,
                                child: Center(
                                  child: Text(
                                    'Nombre',
                                    style: txt,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Container(
                                color: Colors.orangeAccent,
                                child: Center(
                                  child: Text(
                                    'Num Socio',
                                    style: txt,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Container(
                                color: Colors.orangeAccent,
                                child: Center(
                                  child: Text(
                                    'Action',
                                    style: txt,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      for (var i = 0; i < firebaseData.length; i++) ...[
                        TableRow(
                          children: [
                            TableCell(
                              child: SizedBox(
                                child: Center(
                                  child: Text(
                                    firebaseData[i]['nombre'],
                                    style: txt2,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: SizedBox(
                                child: Center(
                                  child: Text(
                                    firebaseData[i]['numsocio'],
                                    style: txt2,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditPage(
                                            docID: firebaseData[i]['id'],
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _delete(firebaseData[i]['id']);
                                      //print(firebaseData);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ], //this is loop
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
