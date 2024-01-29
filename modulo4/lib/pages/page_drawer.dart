import 'package:flutter/material.dart';
import 'package:modulo4_flutter_dankicode/pages/telapedidos.dart';
import 'package:modulo4_flutter_dankicode/util/funcoes.dart';
import 'package:modulo4_flutter_dankicode/pages/home.dart';
import 'package:modulo4_flutter_dankicode/pages/loja.dart';

Widget pageDrawer(BuildContext context) {
  return Drawer(
    child: Column(children: [
      Container(
        width: double.infinity,
        height: 200,
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://img.freepik.com/fotos-gratis/modelo-feminino-com-roupas-tradicionais-segurando-um-diamante-e-uma-lanterna_155003-29722.jpg?size=626&ext=jpg&ga=GA1.1.1807532558.1705413625&semt=ais"),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Lord Shen",
                style: TextStyle(color: Colors.white, fontSize: 18)),
            const Text("Trauma | Kung Fu Panda 2",
                style: TextStyle(color: Colors.white))
          ]),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.home),
        title: const Text("Início", style: TextStyle(fontSize: 16)),
        onTap: () => {navegarParaPagina(context, const Home(), fechar: true)},
      ),
      ListTile(
        leading: const Icon(Icons.shop_sharp),
        title: const Text("Loja", style: TextStyle(fontSize: 16)),
        onTap: () => {navegarParaPagina(context, const Loja(), fechar: true)},
      ),
      ListTile(
        leading: const Icon(Icons.shop_sharp),
        title: const Text("Pedidos", style: TextStyle(fontSize: 16)),
        onTap: () => {navegarParaPagina(context, const TelaPedidos(), fechar: true)},
      ),
    ]),
  );
}
