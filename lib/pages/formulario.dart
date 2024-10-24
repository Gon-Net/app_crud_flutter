import 'package:flutter/material.dart';

class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Form Add Products'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue
      ),
      body: Column(
        children: [
          const Text('Form'),
          ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            child: const Text('Return'),
          )
        ],
      ),
    );
  }
}