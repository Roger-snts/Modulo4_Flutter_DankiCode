import 'package:flutter/material.dart';
import 'package:modulo4_flutter_dankicode/pages/page_drawer.dart';

class Loja extends StatefulWidget {
  const Loja({Key? key}) : super(key: key);

  @override
  State<Loja> createState() => _LojaState();
}

class _LojaState extends State<Loja> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loja"),
        centerTitle: true,
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
      ),
      drawer: pageDrawer(context),
      body: Column(children: []),
    );
  }
}
