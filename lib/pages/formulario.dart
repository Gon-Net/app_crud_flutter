import 'package:flutter/material.dart';

class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  saveProduct(){
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Form Add Products'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name : '
              ),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: 'Price : '
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount : '
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: saveProduct(), 
              child: const Text('Save')
            )
          ],
        ),
      ),
    );
  }
}