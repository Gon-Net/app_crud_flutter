import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

class Formulario extends StatefulWidget {
  final int? id;
  final String? name;
  final String? price;
  final String? amount;
  const Formulario({
    super.key,
    this.id,
    this.name,
    this.price,
    this.amount,  
  });

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  initState(){
    super.initState();
    if(widget.id != null){
      nameController.text = widget.name!;
      priceController.text = widget.price!;
      amountController.text = widget.amount!;      
    }
  }

  saveProduct(){
    
    var url = Uri.parse(dotenv.env['API_BACK']!+'/products');

    http.post(url, body: {
      'name': nameController.text,
      'price': priceController.text,
      'amount': amountController.text,
    }).then((value){
      print(value.statusCode);
      if(value.statusCode == 201){
        Navigator.pop(context);
      }
    });

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

            widget.id != null ? 
            ElevatedButton(
              onPressed: (){
                var url = Uri.parse(dotenv.env['API_BACK']!+'/products/${widget.id}');
                http.put(url, body: {
                  'name': nameController.text,
                  'price': priceController.text,
                  'amount': amountController.text,
                }).then((value){
                  print(value.statusCode);
                  if(value.statusCode == 200){
                    Navigator.pop(context);
                  }
                });
              }, 
              child: const Text('Update')
            )
            :
            ElevatedButton(              
              child: const Text('Save Product', style: TextStyle(color: Colors.blue)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
                onPressed: saveProduct, 
            )
          ],
        ),
      ),
    );
  }
}