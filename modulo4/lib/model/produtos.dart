
class Produtos {
  int? id;
  String nome = "";
  String descricao = "";
  double preco = 0;

  Produtos({this.id, required this.nome, required this.descricao, required this.preco});

  factory Produtos.paraMap(Map<String, dynamic> map) => Produtos(id: map['prod_id'], nome: map['prod_nome'], descricao: map['prod_descricao'], preco: map['prod_preco']);


  Map<String, dynamic> paraMap() {
    var dados = <String, dynamic>{};
    dados['prod_id']        = id;
    dados['prod_nome']      = nome;
    dados['prod_descricao'] = descricao;
    dados['prod_preco']     = preco;

    return dados;
  }

  Produtos.paraModel(Map<String, dynamic> dados) {
    id        = dados['prod_id'];
    nome      = dados['prod_nome'];
    descricao = dados['prod_descricao'];
    preco     = dados['prod_preco'];
  }
}
