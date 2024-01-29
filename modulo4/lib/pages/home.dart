import 'package:flutter/material.dart';
import 'package:modulo4_flutter_dankicode/pages/page_drawer.dart';
import 'package:modulo4_flutter_dankicode/pages/tabs/noticias.dart';
import 'package:modulo4_flutter_dankicode/pages/tabs/pedidos.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Página principal"),
          centerTitle: true,
          backgroundColor: Colors.black,
          titleTextStyle: const TextStyle(fontSize: 20, color: Colors.white),
          bottom: const TabBar(tabs: [
            Tab(
              text: "Notícias",
            ),
            Tab(
              text: "Meus pedidos",
            )
          ]),
        ),
        drawer: pageDrawer(context),
        body: const TabBarView(children: [Noticias(), Pedidos()]),
      ),
    );
  }
}
