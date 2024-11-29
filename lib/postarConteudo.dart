import 'package:flutter/material.dart';

class PostarConteudo extends StatefulWidget {
  const PostarConteudo({super.key});

  @override
  State<PostarConteudo> createState() => _PostarConteudoState();
}

class _PostarConteudoState extends State<PostarConteudo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.arrow_back_rounded),onPressed: () {
            Navigator.pop(context);
          },),
        ],
        forceMaterialTransparency: true,
      ),
      body: Center(child: Column(children: [
        
      ],),),
    );
  }
}