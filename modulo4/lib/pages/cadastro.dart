import 'package:flutter/material.dart';
import 'package:modulo4_flutter_dankicode/pages/page_drawer.dart';
import 'package:modulo4_flutter_dankicode/util/produtosHelper.dart';
import '../model/produtos.dart';

class Cadastro extends StatefulWidget {
  @override
  State<Cadastro> createState() => _CadastroState();

  final Produtos? prod;

  Cadastro({this.prod});
}

class _CadastroState extends State<Cadastro> {
  String titulo = "Novo cadastro";
  String textoBotao = "Salvar pedido";
  int? idproduto;
  TextEditingController nome = TextEditingController();
  TextEditingController descricao = TextEditingController();
  TextEditingController preco = TextEditingController();

  void cadastrarProduto({Produtos? p}) async {
    int? resultado;
    if (p == null){
      setState(() async {
        resultado = await ProdutosHelper.instanciarBanco.cadastrarNoBanco(
        Produtos(
          nome: nome.text,
          descricao: descricao.text,
          preco: double.parse(preco.text.replaceAll(",", "."))));
        print("Salvou " + resultado.toString() + " no sistema");
      });
      nome.clear();
      descricao.clear();
      preco.clear();
    }
    else {
      p.id = idproduto;
      p.nome = nome.text;
      p.descricao = descricao.text;
      p.preco = double.parse(preco.text);
      resultado = await ProdutosHelper.instanciarBanco.alterarDadosProd(p);
      print("Alterado com sucesso! $resultado");
      setState(() {
        Navigator.pop(context);
      });
    };
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    if (widget.prod != null){
      titulo = "Editando pedido";
      textoBotao = "Salvar alterações";
      nome.text = widget.prod!.nome;
      descricao.text = widget.prod!.descricao;
      preco.text = widget.prod!.preco.toString();
      idproduto = widget.prod!.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        centerTitle: true,
        backgroundColor: Colors.black,
        titleTextStyle: const TextStyle(fontSize: 20, color: Colors.white),
      ),
      drawer: pageDrawer(context),
      body: SingleChildScrollView(
        child: Form(
          key: null,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    controller: nome,
                    autocorrect: true,
                    autofocus: true,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(fontSize: 18),
                    validator: (value) {
                      if (value.toString() == "") {
                        return "Preencha este campo";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(label: Text("Nome")),
                  ),
                  TextFormField(
                    controller: descricao,
                    autocorrect: true,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    maxLines: 3,
                    validator: (value) {
                      if (value.toString() == "") {
                        return "Preencha este campo";
                      } else {
                        return null;
                      }
                    },
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                        label: Text("Descrição"), alignLabelWithHint: true),
                  ),
                  TextFormField(
                    controller: preco,
                    autocorrect: true,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 18),
                    validator: (value) {
                      if (value.toString() == "") {
                        return "Preencha este campo";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(label: Text("Preço R\$")),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(color: Colors.white),
                          backgroundColor: Colors.black87),
                      onPressed: () async {
                        cadastrarProduto(p: widget.prod);
                      },
                      child: Text(textoBotao),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
