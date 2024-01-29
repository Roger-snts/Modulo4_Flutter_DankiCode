import 'package:flutter/material.dart';

Future<dynamic> navegarParaPagina(BuildContext context, StatefulWidget pagina, {bool? fechar}) {

  if (fechar == true){
      Navigator.pop(context);
  }
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => pagina));
}
