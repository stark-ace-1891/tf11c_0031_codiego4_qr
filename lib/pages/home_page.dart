import 'package:flutter/material.dart';
import 'package:tf11c_0031_codiego4_qr/pages/scanner_page.dart';
import 'package:tf11c_0031_codiego4_qr/data/data.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(Data().qrList);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ScannerPage()));
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
      body: ListView.builder(
        itemCount: Data().qrList.length,
        itemBuilder: (BuildContext context, int index) {
          Map qrData = Data().qrList[index];

          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black.withOpacity(0.1),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        qrData["description"],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "12/06/2023",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.qr_code,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
