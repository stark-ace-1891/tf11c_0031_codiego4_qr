import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:excel/excel.dart' as excel;
import 'package:path_provider/path_provider.dart';
// import 'package:open_filex/open_filex.dart';
import 'package:tf11c_0031_codiego4_qr/models/qr_model.dart';
import 'package:tf11c_0031_codiego4_qr/pages/scanner_page.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference qrCollection =
      FirebaseFirestore.instance.collection('qr_collection');

  void showDetailQR(QrModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final dateFormat =
            DateFormat('dd/MM/yyyy - HH:mm').format(model.datetime.toDate());
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Detalle QR",
              ),
              const Divider(),
              Row(
                children: [
                  Text(
                    "Descripción: ",
                  ),
                  Expanded(
                    child: Text(model.description),
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  Text(
                    "Fecha: ",
                  ),
                  Expanded(
                    child: Text(
                      dateFormat,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 120,
                width: 120,
                child: QrImageView(
                  data: model.qr,
                  version: QrVersions.auto,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  getDataQR() async {
    QuerySnapshot collection = await qrCollection.get();
    List<QueryDocumentSnapshot> docs = collection.docs;
    List<QrModel> qrList = [];
    // for (var item in docs) {
    //   Map<String, dynamic> data = item.data() as Map<String, dynamic>;
    //   QrModel model = QrModel.fromJson(data);
    //   qrList.add(model);
    // }
    qrList = docs
        .map((e) => QrModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    return qrList;
  }

  exportExcel() async {
    List<QrModel> data = await getDataQR();
    excel.Excel myExcel = excel.Excel.createExcel();
    excel.Sheet? sheet = myExcel.sheets[myExcel.getDefaultSheet()];
    sheet!
        .cell(excel.CellIndex.indexByColumnRow(
          columnIndex: 0,
          rowIndex: 0,
        ))
        .value = "ID";
    sheet!
        .cell(excel.CellIndex.indexByColumnRow(
          columnIndex: 1,
          rowIndex: 0,
        ))
        .value = "Descripcion";
    sheet!
        .cell(excel.CellIndex.indexByColumnRow(
          columnIndex: 2,
          rowIndex: 0,
        ))
        .value = "Fecha";
    sheet!
        .cell(excel.CellIndex.indexByColumnRow(
          columnIndex: 3,
          rowIndex: 0,
        ))
        .value = "QR";

    for (var i = 0; i < data.length; i++) {
      sheet!
          .cell(excel.CellIndex.indexByColumnRow(
            columnIndex: 0,
            rowIndex: i + 1,
          ))
          .value = i + 1;
      sheet!
          .cell(excel.CellIndex.indexByColumnRow(
            columnIndex: 1,
            rowIndex: i + 1,
          ))
          .value = data[i].description;
      sheet!
          .cell(excel.CellIndex.indexByColumnRow(
            columnIndex: 2,
            rowIndex: i + 1,
          ))
          .value = data[i].datetime.toString();
      sheet!
          .cell(excel.CellIndex.indexByColumnRow(
            columnIndex: 3,
            rowIndex: i + 1,
          ))
          .value = data[i].qr;
    }

    Directory directory = await getApplicationDocumentsDirectory();
    List<int>? bytes = myExcel.save();
    File fileExcel = File("${directory.path}/reporteExcel.xlsx");
    fileExcel.createSync(recursive: true);
    fileExcel.writeAsBytesSync(bytes!);
  }

  @override
  Widget build(BuildContext context) {
    qrCollection.get().then((value) {
      print(value.size);
    });

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScannerPage()))
              .then((value) {
            setState(() {});
          });
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.qr_code_scanner),
      ),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "Listado General",
        ),
        actions: [
          IconButton(
            onPressed: () {
              exportExcel();
            },
            icon: Icon(Icons.import_export),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.picture_as_pdf),
          ),
        ],
      ),
      // body: ListView.builder(
      //   itemCount: Data().qrList.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     Map qrData = Data().qrList[index];

      //     return Container(
      //       margin: EdgeInsets.symmetric(
      //         horizontal: 10,
      //         vertical: 14,
      //       ),
      //       decoration: BoxDecoration(
      //         border: Border.all(
      //           width: 1,
      //           color: Colors.black.withOpacity(0.1),
      //         ),
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: Row(
      //         children: [
      //           Expanded(
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   qrData["description"],
      //                   style: TextStyle(
      //                     fontSize: 15,
      //                     fontWeight: FontWeight.normal,
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   height: 4,
      //                 ),
      //                 Text(
      //                   "12/06/2023",
      //                   style: TextStyle(
      //                     color: Colors.black54,
      //                     fontSize: 12,
      //                     fontWeight: FontWeight.normal,
      //                   ),
      //                 ),
      //                 IconButton(
      //                   onPressed: () {},
      //                   icon: Icon(
      //                     Icons.qr_code,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // ),

      ////Datos desde firebase con un future
      // body: FutureBuilder(
      //   future: qrCollection.get(),
      //   builder: (BuildContext context, AsyncSnapshot snap) {
      //     if (snap.hasData) {
      //       QuerySnapshot collection = snap.data;
      //       List<QueryDocumentSnapshot> docs = collection.docs;
      //       return ListView.builder(
      //         itemCount: docs.length,
      //         itemBuilder: (BuildContext context, int index) {
      //           Map<String, dynamic> data =
      //               docs[index].data() as Map<String, dynamic>;
      //           QrModel model = QrModel.fromJson(data);

      //           return Container(
      //             margin: const EdgeInsets.symmetric(
      //                 horizontal: 12.0, vertical: 10),
      //             padding:
      //                 const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      //             decoration: BoxDecoration(
      //               border: Border.all(
      //                 width: 1,
      //                 color: Colors.black.withOpacity(0.1),
      //               ),
      //               borderRadius: BorderRadius.circular(12.0),
      //             ),
      //             child: Row(
      //               children: [
      //                 Expanded(
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Text(
      //                         model.description,
      //                         style: TextStyle(
      //                           fontSize: 15.0,
      //                           fontWeight: FontWeight.normal,
      //                         ),
      //                       ),
      //                       const SizedBox(
      //                         height: 4.0,
      //                       ),
      //                       Text(
      //                         model.datetime.toString(),
      //                         style: TextStyle(
      //                           fontSize: 12.0,
      //                           color: Colors.black54,
      //                           fontWeight: FontWeight.normal,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 IconButton(
      //                   icon: Icon(Icons.qr_code),
      //                   onPressed: () {},
      //                 ),
      //               ],
      //             ),
      //           );
      //         },
      //       );
      //     }
      //     return CircularProgressIndicator();
      //   },
      // ),

      ////Datos desde firebase con un stream
      body: StreamBuilder(
        stream: qrCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            QuerySnapshot collection = snap.data;
            List<QueryDocumentSnapshot> docs = collection.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> data =
                    docs[index].data() as Map<String, dynamic>;
                QrModel model = QrModel.fromJson(data);

                final dateFormat = DateFormat('dd/MM/yyyy - HH:mm')
                    .format(model.datetime.toDate());
                // final dateFormat = DateFormat('d, MMM y - H:m')
                //     .format(model.datetime.toDate());

                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black.withOpacity(0.1),
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.description,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              dateFormat,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.qr_code),
                        onPressed: () {
                          showDetailQR(model);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
