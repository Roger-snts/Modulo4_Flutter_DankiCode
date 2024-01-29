import 'package:flutter/material.dart';

class Noticias extends StatefulWidget {
  const Noticias({Key? key}) : super(key: key);

  @override
  State<Noticias> createState() => _NoticiasState();
}

class _NoticiasState extends State<Noticias> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.network(
            "https://img.freepik.com/vetores-gratis/ilustracao-de-elementos-de-comunicacao_24877-57105.jpg?w=826&t=st=1705425472~exp=1705426072~hmac=9b72e5737b6b77e76c434466ff239a2af26980c36ecde31741e6e512141396a5",
          ),
        ),
        Text("As últimas notícias do dia")
      ],
    );
  }
}
