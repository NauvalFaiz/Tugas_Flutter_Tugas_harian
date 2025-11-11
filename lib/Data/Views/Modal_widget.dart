import 'package:flutter/material.dart';

class ModalWidget {
  showFullModal(context, Widget isi) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "List Film Tayang",
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              "Tambah/Edit Film",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            automaticallyImplyLeading: false,
            elevation: 0.1,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close, color: Colors.black),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: const Color(0xfff8f8f8), width: 1),
              ),
            ),
            child: isi,
          ),
        );
      },
    );
  }
}
