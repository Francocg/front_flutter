import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_flutter/model.dart';
import 'package:http/http.dart' as http;

class EditarPage extends StatefulWidget {
  EditarPage({Key? key}) : super(key: key);

  @override
  _EditarPageState createState() => _EditarPageState();
}

class _EditarPageState extends State<EditarPage> {

  String titulo = '';
  String descripcion = '';
  List<PostModel> postmodel = [];

  //Modificar

  Future<http.Response> updatePost(PostModel posts, int id) async {
    final url = Uri.parse('https://app-front-flutter.herokuapp.com/update/${id}');

    final response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(posts.toJson()));
    
    if (response.statusCode == 200) {
        print(response.body);
    } else {
      print(response.body);
      print('A network error occurred');
    }

    this.postmodel.add(posts);
    return response;

  }
  
  @override
  Widget build(BuildContext context) {
    //RECIBIENDO EL PARAMETRO ENVIADO
    final Map<String, dynamic> postmodelobject = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text("ACTUALIZAR"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        children: [
          _titulo(postmodelobject['titulo']),
          Divider(
            color: Colors.lightBlue,
            thickness: 0.5,
          ),
          _descripcion(postmodelobject['descripcion']),
          Divider(
            color: Colors.lightBlue,
            thickness: 0.5,
          ),
          FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () async{
              
              print("EN EL ONPRESED !");
              print(this.titulo);
              print(this.descripcion);

              final postObjeto = new PostModel(titulo: this.titulo, descripcion: this.descripcion);
              final dataEnviar = await updatePost(postObjeto,postmodelobject['idpost']);
              print(dataEnviar);
              Navigator.pushNamed(context, '/home');
            }
          )
        ],
      ),
    );
  }
  Widget _titulo(String titulo) {
   
    return TextFormField(
      initialValue: titulo,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          labelText: 'Titulo',
         
      ),

      onChanged: (value){
          setState(() {
            this.titulo = value;
          });
      },
    );
  }

  Widget _descripcion(String descripcion) {
    return TextFormField(
      initialValue: descripcion,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          labelText: 'Descripción',
          ),
      onChanged: (value){
          setState(() {
            this.descripcion = value;
          });
      },
    );
  }

}