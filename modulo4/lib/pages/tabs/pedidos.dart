
import 'package:flutter/material.dart';
import 'package:modulo4_flutter_dankicode/model/produtos.dart';
import 'package:modulo4_flutter_dankicode/pages/cadastro.dart';
import 'package:modulo4_flutter_dankicode/util/funcoes.dart';
import 'package:modulo4_flutter_dankicode/util/produtosHelper.dart';

class Pedidos extends StatefulWidget {
  const Pedidos({Key? key}) : super(key: key);

  @override
  State<Pedidos> createState() => _PedidosState();
}

class _PedidosState extends State<Pedidos> {

  List<Produtos> listadeProdutos = [];
  
  // Abrindo o Database e buscando os pedidos cadastrados
  ProdutosHelper db = ProdutosHelper.instanciarBanco;

  // Listar os pedidos cadastrados
  void cadastros() async {

    List produtosCadastrados = await db.buscarCadastros();

    List<Produtos> listaTemporaria = [];

    for (var item in produtosCadastrados){
      Produtos objeto = Produtos.paraModel(item);
      listaTemporaria.add(objeto);
    }

    // Atribuindo os valores à lista real
    setState(() {
      listadeProdutos = listaTemporaria;
    });
  }

  // Confirmando exclusão
  void exclusaoProduto(int? id) async {
    await db.excluirProdutoID(id);
    cadastros();
  }

  // Exibindo a notificação de exclusão
  void alertaExclusao(int? id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Alerta"),
          content: const Text("Deseja mesmo excluir o pedido selecionado?"),
          icon: const Icon(Icons.do_not_disturb_alt_sharp, color: Colors.redAccent),
          actions: [
            ElevatedButton(onPressed: (){ exclusaoProduto(id); Navigator.pop(context); }, child: const Text("Sim")),
            ElevatedButton(onPressed: (){ Navigator.pop(context); }, child: const Text("Não"))
          ],
        );
      },
    );
  }

  // Exibe uma notificação de que o produto foi atualizado. Isso também atualiza a página para que o valor antigo mude
  void alertaAlteracao(String nome) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Informe"),
          content: Text("O produto $nome foi alterado com sucesso!"),
          icon: const Icon(Icons.celebration_outlined, color: Colors.greenAccent),
          actions: [
            ElevatedButton(onPressed: (){
              cadastros();
              Navigator.pop(context); 
              }, 
              child: const Text("Confirmar"))
          ],
        );
      },
    );
  }

  // InitState é uma função que força a execução de tudo o que está nela antes de o programa principal compilar
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Gerando a lista de produtos
    cadastros();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
        children: [
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text("Solicitar um item"),
            onTap: () => {navegarParaPagina(context, Cadastro(), fechar: true)},
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(child: ListView.builder(itemCount: listadeProdutos.length, itemBuilder: ((context, index){
          final Produtos prod = listadeProdutos[index];
          return Card(
            child: ListTile(
              title: Text(prod.nome),
              subtitle: Text(prod.descricao),
              leading: Text("R\$${prod.preco.toString().replaceAll(".", ",")}", style: const TextStyle(fontSize: 16),),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(onTap: () async { 
                    String nomeSalvo = prod.nome;
                    await navegarParaPagina(context, Cadastro(prod: prod)); 
                    alertaAlteracao(nomeSalvo);
                    }, 
                    child: const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(Icons.edit),
                  ),
                  ),
                  GestureDetector(onTap: (){
                    alertaExclusao(prod.id);
                  }, child: const Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Icon(Icons.delete),
                  ),),
                ],
              ),
            ),
          );
        })))],
      );
  }
}
