import 'package:flutter/material.dart';
import 'package:shared/cadastro.dart';
import 'package:shared/login.dart';
import 'package:shared/postarConteudo.dart';
import 'package:shared/telaInicial.dart';
import 'package:shared/terminaCadastro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shar.Ed Mobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => LoginPage(),
        '/inicial':(context)=>TelaInicial(""),
        '/cadastrar':(context)=>TelaCadastro(),
        '/postarConteudo':(context)=>PostarConteudo(),
        '/terminaCadastro':(context)=>Terminacadastro(),
        
      },
    );
  }
}
