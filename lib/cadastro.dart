import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  var dadosApi;
  Uuid uuid = Uuid();

  Future<void> _cadastro() async {
    String email = _emailController.text;
    String senha = _senhaController.text;
    String codigo = uuid.v6();
    var url = Uri.parse('http://localhost:8080/shared/usuario/cadastrar');
    http.Response response;
    response = await http.post(url,headers: {"Content-Type": "application/json"},body: jsonEncode({
      "codigo": codigo,
      "email": email,
      "senha": senha,
      "isCadastrado":0
    }));
    if(response.statusCode==201)
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cadastrado com Sucesso!')));
      Navigator.pop(context);
    }
    else{
      
      
    }
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.green[200],
      body: SafeArea(child: LayoutBuilder(builder: (context,constraints){
        return SingleChildScrollView(padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(child: Column(
          children: [
            SizedBox(
              height: constraints.maxHeight*0.1
            ),
            Image(image: AssetImage('assets/images/Shar.Ed_logo.png'),height: constraints.maxHeight*0.2,),
            SizedBox(
              height: constraints.maxHeight*0.05
            ),
            Text('Cadastro', style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),),
            SizedBox(height: constraints.maxHeight*0.05,),
            Form(child: Column(children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.black54),
                  filled: true,
                  fillColor: Colors.green[50],
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide.none,
                  )
                ),
              ),
              SizedBox(height: constraints.maxHeight*0.05),
              TextFormField(
                controller: _senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Senha',
                  hintStyle: TextStyle(color: Colors.black54),
                  filled: true,
                  fillColor: Colors.green[50],
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide.none,
                  )
                ),
              ),
              SizedBox(height: constraints.maxHeight*0.1),
              ElevatedButton(onPressed: ()  {
                setState(() {
                  _emailController=this._emailController;
                  _senhaController=this._senhaController;
                  
                });
                _cadastro();
              }, child: Text('Cadastrar')),
              SizedBox(height: constraints.maxHeight*0.1,),
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text('Já tem uma conta?')),
              SizedBox(height: constraints.maxHeight*0.2,),
            ],))
          ],
        ),));
      })),
   );
  }
}