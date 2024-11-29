// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sticky_widgets/flutter_sticky_widgets.dart';
import 'package:http/http.dart' as http;
String codigo="";
class TelaInicial extends StatefulWidget {
   
  TelaInicial(codigo,{super.key});

  

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  int paginaAtual=0;
  var dadosApi;

  Future<void> _verifica() async{
    print(codigo);
    var url = Uri.parse('http://localhost:8080/shared/usuario/buscar/existe/codigo/$codigo');
    http.Response response;
    response = await http.get(url);
    dadosApi = response.body;
    if(response.statusCode==200)
    {
       Map<String,dynamic> dadosFormatados= jsonDecode(dadosApi);
       var existe = dadosFormatados['numero'];
       if(existe==0)
       {
        Navigator.pop(context);
       }
       else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Acesso bem Sucedido!')));
       }

    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro a Consultar a API')));
                  
    }
  }
  Future<void> _verificaCadastro() async{
    var url = Uri.parse('http://localhost:8080/shared/usuario/buscar/codigo/$codigo');
    http.Response response;
    response = await http.get(url);
    dadosApi = response.body;
    if((response.statusCode>=200)&&(response.statusCode<=299))
    {
       Map<String,dynamic> dadosFormatados= jsonDecode(dadosApi);
       var isCadastrado = dadosFormatados['isCadastrado'];
       if(isCadastrado==0)
       {
        Navigator.pushNamed(context, '/terminaCadastro');
       }
       else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Perfil Cadastrado 100%')));
       }

    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro a Consultar a API')));
                  
    }
  }


  /*Widget post()
{
  return Card(child: Padding(padding: EdgeInsets.all(10), child: 
  Column(children: [
    Row(children: [
      CircleAvatar(radius: 20, backgroundImage: NetworkImage(profilePicUrl), backgroundColor: Colors.transparent,),
      SizedBox(width: 10,),
      Column(children: [
        Text("SoftDev Cafe", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
        Text("Subscribe to the channel :)")
      ], mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,)
    ],),
    SizedBox(height: 5,),
    Image.network(imageUrl),
    SizedBox(height: 5,),
    Padding(child: Row(children: [
      IconButton(padding: EdgeInsets.fromLTRB(0, 0, 5, 0), constraints: BoxConstraints(),
        onPressed: () {
        setState(() {
          liked = !liked;
          if(liked)
          {
            likes += 1;
          }
          else
          {
            likes -= 1;
          }
        });
      }, icon: liked == true ? Icon(Icons.favorite, color: Colors.red,) : Icon(Icons.favorite_border)),
      IconButton(padding: EdgeInsets.fromLTRB(0, 0, 5, 0), constraints: BoxConstraints(),
        onPressed: () {
        
      }, icon: Icon(Icons.comment_outlined)),
      IconButton(padding: EdgeInsets.fromLTRB(0, 0, 5, 0), constraints: BoxConstraints(),
        onPressed: () {
        
      }, icon: Icon(Icons.bookmark_outline)),
    ]), padding: EdgeInsets.all(5),),
    Padding(child: Row(children: [
      Text(likes.toString() + " likes"),
    ]), padding: EdgeInsets.all(5),),
  ],),),);
}*/

  @override
  void initState() {
    _verifica();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        
        destinations: <Widget>[
        NavigationDestination(icon: Icon(Icons.home), label: ""),
        NavigationDestination(icon: Icon(Icons.settings), label: ''),
        NavigationDestination(icon: Icon(Icons.star), label: ''),
        NavigationDestination(icon: Icon(Icons.person_2), label: ''),
        NavigationDestination(icon: Icon(Icons.add), label: '')
      ],
      onDestinationSelected: (int index) {
       setState(() {
          paginaAtual=index;
       });
       if(paginaAtual==1)
       {
        Navigator.popAndPushNamed(context, '/configuracoes');
       }
       else if(paginaAtual==2)
       {
        Navigator.popAndPushNamed(context, '/postarExtra');
       }
       else if(paginaAtual==3)
       {
        Navigator.popAndPushNamed(context, '/perfil');
       }
       else if(paginaAtual==4)
       {
        Navigator.popAndPushNamed(context, '/postarConteudo');
       }
      },
      indicatorColor: Colors.green[100],
      selectedIndex: paginaAtual,
      ),
      body: Center(child: Column(children: [
        Text('Bem vindo ao aplicativo!'),
        ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text('Sair'))
        
       
      ],),)
    );
  }
}