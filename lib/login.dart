import 'package:flutter/material.dart';
import 'package:shared/repository/Usuario.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  var dadosApi;
  Usuario user = Usuario();

  Future <void> _login() async {
    String email = _emailController.text;
    var url = Uri.parse('http://localhost:8080/shared/usuario/buscar/email/$email');
    http.Response response;
    response = await http.get(url);
    dadosApi = response.body;
    if((response.statusCode==200)&&(response.body.isNotEmpty))
    {
       Map<String,dynamic> dadosFormatados= jsonDecode(dadosApi);
       user=Usuario.fromJson(dadosFormatados);
       if(_senhaController.text==user.senha)
       {
        Navigator.pushNamed(context, '/inicial',arguments: user.codigo);
       }

       else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email ou senha inválidaaaa')));
       }

    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email ou senha inválida')));
                  
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
            Text('Login', style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),),
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
              SizedBox(height: constraints.maxHeight*0.05),
              TextButton(onPressed: () {
                
              }, child: Text('Esqueceu a Senha?')),
              SizedBox(height: constraints.maxHeight*0.05,),
              ElevatedButton(onPressed: ()  {
                _login();
              }, child: Text('Entrar')),
              SizedBox(height: constraints.maxHeight*0.1,),
              TextButton(onPressed: () {
                //Navigator.pushNamed(context, '/cadastrar');
                Navigator.pushNamed(context, '/cadastrar');
              }, child: Text('Ainda não tem uma conta?'))
            ],))
          ],
        ),));
      })),
    );
  }
}