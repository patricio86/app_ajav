import 'package:app_ajav/constraints.dart/textstyle.dart';
import 'package:app_ajav/paginas/actualizarPass.dart';
import 'package:app_ajav/paginas/listarsocios.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class Perfil extends StatefulWidget {
  final String nombre;
  final String apellidos;
  final String numsocio;
  final String rol;
  const Perfil(this.nombre, this.apellidos, this.numsocio, this.rol, {Key? key}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 94, 18, 12),
);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Color.fromARGB(255, 188, 189, 184),
      ),
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
      image: DecorationImage(
        image: const AssetImage('assets/logoperfil.png'),
        alignment: Alignment.bottomRight
          ),
          ),
          margin: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(110.0),
                  child: Image.asset('assets/logo.png'),
                ),
                Table(
                  columnWidths: const <int, TableColumnWidth>{
                    1: FixedColumnWidth(150),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                            child: Text(
                              'Nombre',
                              style: txt,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              'Apellidos',
                              style: txt,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              'Nº Socio',
                              style: txt,
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(children: [
                      TableCell(
                        child: SizedBox(
                          child: Center(
                            child: Text(
                              widget.nombre,
                              style: txt2,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: SizedBox(
                          child: Center(
                            child: Text(
                              widget.apellidos,
                              style: txt2,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: SizedBox(
                          child: Center(
                            child: Text(
                              widget.numsocio,
                              style: txt3,
                            ),
                          ),
                        ),
                      ),
                    ])
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: SizedBox(
                    width: 250,
                    height: 75,
                    child: SfBarcodeGenerator(
                      value: widget.numsocio,
                      textStyle: TextStyle(fontFamily: 'Times',
                        fontSize: 16, fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 149, 236, 98)),
                      symbology: Codabar(),
                      showValue: true,
                      barColor: Color.fromARGB(209, 129, 20, 3),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                             child: Builder(
                               builder: (context) {
                                 return TextButton(
                                             onPressed: () { 
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ActualizarPass()));
                                              },
                                             child: const Text('Cambiar contraseña'),
                                           );
                               }
                             ),
                           ),
                ),

                if(widget.rol == 'administrador')
                Builder(builder: (context) {
                  return ElevatedButton(
                      style: raisedButtonStyle,
                      child: const Text("Acceder a Admin"),
                      onPressed: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Listarsocios()))
                          });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

 
}
