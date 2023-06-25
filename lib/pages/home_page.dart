import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tf11c_0031_codiego4_qr/models/qr_model.dart';
import 'package:tf11c_0031_codiego4_qr/pages/scanner_page.dart';
import 'package:tf11c_0031_codiego4_qr/data/data.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference qrCollection =
      FirebaseFirestore.instance.collection('qr_collection');

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
      body: FutureBuilder(
        future: qrCollection.get(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            QuerySnapshot collection = snap.data;
            List<QueryDocumentSnapshot> docs = collection.docs;
            // return Text(docs[0].data().toString());
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> data =
                    docs[index].data() as Map<String, dynamic>;
                QrModel model = QrModel.fromJson(data);

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
                              model.datetime.toString(),
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
                        onPressed: () {},
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
