import 'package:app_crud1/pages/formulario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List products = [];

  @override
  void initState(){
    super.initState();
    productGet();
  }

  productGet() async {
    //var url = Uri.parse('http://localhost:8000/api/products');
    //var url = Uri.parse('https://8826-131-0-196-208.ngrok-free.app/api/products');

    String? apiUrl = dotenv.env['API_BACK'];
    if (apiUrl == null || apiUrl.isEmpty) {
      //print('Error: API_BACK no está configurado.');
      return;
    }

    //var url = Uri.parse(dotenv.env['API_BACK']!+'/products');
    var url = Uri.parse('$apiUrl/products');

    var response = await http.get(url);
    if(response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      //print(jsonResponse);
      setState(() {
        products = jsonResponse;
      });
    }else{
      print('Request failed with status :  ${response.statusCode}');
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: const Text('Products - GCS', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: productGet, 
            child: const Text('Refresh', style: TextStyle(color: Colors.blue),),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal))
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(products[index]['name'].toString()),
                  subtitle: Text(products[index]['price'].toString()),
                );
              }),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.grey[300],
        onPressed: (){
          // Redireccionar a form para ingreso de datos...
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => const Formulario()),
          );
        },
        child: const Icon(Icons.add),
      ),

      backgroundColor: Colors.grey[250],
    );
  }
}