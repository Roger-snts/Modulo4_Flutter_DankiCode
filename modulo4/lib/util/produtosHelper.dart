
import 'package:sqflite/sqflite.dart';
import '../model/produtos.dart';

// Definir a classe Helper
class ProdutosHelper {
  // Nessa classe criaremos o banco de dados e todas as funções do mesmo, começando com a definição das variáveis

  String nomeDataBase    = "Produtos";

  String colunaID        = "prod_id";
  String colunaNome      = "prod_nome";
  String colunaDescricao = "prod_descricao";
  String colunaPreco     = "prod_preco";

  // Após isso definimos os atributos
  // Essa parte cria uma instância Única da classe. Serve para trabalhar com SingleTon, que é um padrão de projetos
  // criado para que não seja possível iniciar a mesma classe várias vezes. Por isso esse código abaixo que cria uma
  // instância da classe
  ProdutosHelper._iniciarbanco();
  static final ProdutosHelper instanciarBanco = ProdutosHelper._iniciarbanco();

  // Esse código garante que o banco seja inicializado
  // Agora, é preciso declarar uma comparação para verificar se o banco de dados foi inicializado
  // Agora cria a regra da função que inicializa o banco caso ele ainda não tenha sido inicializado
  static Database? _dataBase;
  Future<Database> get dataBase async => _dataBase ?? await _inicializarBanco();

  // Após a criação da variável do Database, alocaremos ele a um local no celular através deste método que também o inicia. A função deve ser do tipo Future<Database>
  Future<Database> _inicializarBanco() async {
    // Pegar o caminho principal do Android ou IOS para armazenar o banco de dados]
    final diretorio = getDatabasesPath();
    final caminho = "${diretorio}dbprodutos.db";

    // Com o caminho definido é possível inicializar o banco de dados através do comando OpenDataBase()

    // O comando OpenDataBase() que requer 3 coisas, sendo elas respectivamente o Caminho, o número da Versão e em seguida o comando para Criar o Banco
    // Por fim, retorna-se o banco de dados já criado e inicializado
    return await openDatabase(caminho, version: 1, onCreate: _criarBanco);
  }

  // O método para criar a tabela do banco de dados é esta, sempre possuindo um db e uma version:
  void _criarBanco(Database db, int version) async {
    // Primeiramente cria-se uma String contendo os comandos para a criação da tabela
    String tabela = """
    CREATE TABLE $nomeDataBase(
      $colunaID INTEGER PRIMARY KEY AUTOINCREMENT,
      $colunaNome VARCHAR(60),
      $colunaDescricao TEXT,
      $colunaPreco REAL
    )
    """;
    // Em seguida executa no modo await o banco de dados, acrescentando ao mesmo a tabela
    await db.execute(tabela);
  }

  // CRUD = Create, Read, Update, Delete
  // Agora vem as funções do CRUD no Banco de dados =) eeeeeeeeee.

  // Este método cadastra o produto no banco de dados e retorna um número que indica se o produto foi ou não cadastrado
  Future<int?> cadastrarNoBanco(Produtos produtos) async {
    // Seleciona o banco de dados e em seguida insere o valor nele em forma de Map
    Database db  = await instanciarBanco.dataBase;
    var resposta = await db.insert(nomeDataBase, produtos.paraMap());

    return resposta;
  }

  // Este método busca os cadastros no Database
  Future<List> buscarCadastros() async {
    // Seleciona o banco de dados e em seguida insere o valor nele em forma de Map
    Database db  = await instanciarBanco.dataBase;

    // Cria uma chamada para o banco
    String comando = "select * from $nomeDataBase;";  

    // Busca os valores e armazena numa variável
    List cadastros = await db.rawQuery(comando);

    return cadastros;
  }


  // Este método Exclui os produtos do Banco de Dados
  Future<int> excluirProdutoID(int? id) async {
    // Selecionar o banco de dados
    Database db = await instanciarBanco.dataBase;

    // Seleciona o que exclui, substituindo o id = ? pelo ID informado
    var resultado = await db.delete(nomeDataBase, where: "$colunaID = ?", whereArgs: [id]);

    // Retorna a resposta
    return resultado;
  }

  // Este método Atualiza / Update informações do produto selecionado
  Future<int> alterarDadosProd(Produtos produto) async {
    Database db = await instanciarBanco.dataBase;

    // Esse método atualiza na tabela o produto em formato de Json
    var resultado = await db.update(nomeDataBase, produto.paraMap(), where: "$colunaID = ?", whereArgs: [produto.id]);

    return resultado;
  }
}
