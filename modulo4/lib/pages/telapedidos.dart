

import 'package:flutter/material.dart';
import 'package:modulo4_flutter_dankicode/model/produtos.dart';
import 'package:modulo4_flutter_dankicode/util/produtosHelper.dart';

class TelaPedidos extends StatefulWidget {
  const TelaPedidos({super.key});

  @override
  State<TelaPedidos> createState() => _TelaPedidosState();
}

class _TelaPedidosState extends State<TelaPedidos> {

  List<Produtos> listadeProdutos = [];

  ProdutosHelper db = ProdutosHelper.instanciarBanco;

  void cadastros() async {

    List produtosCadastrados = await db.buscarCadastros();

    List<Produtos> listaTemporaria = [];

    for (var item in produtosCadastrados){
      Produtos objeto = Produtos.paraModel(item);
      listaTemporaria.add(objeto);
    }

    setState(() {
      listadeProdutos = listaTemporaria;
      print("Produto: " + listadeProdutos.last.nome);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cadastros();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedidos"),
        centerTitle: true,
        backgroundColor: Colors.black,
        titleTextStyle: const TextStyle(fontSize: 20, color: Colors.white),
      ),
      body: Column(
        children: [Expanded(child: ListView.builder(itemCount: listadeProdutos.length, itemBuilder: ((context, index){
          final Produtos prod = listadeProdutos[index];
          return Card(
            child: ListTile(
              title: Text(prod.nome),
              subtitle: Text(prod.descricao),
              leading: Text(prod.preco.toString()),
            ),
          );
        })))],
      ),
    );
  }
}