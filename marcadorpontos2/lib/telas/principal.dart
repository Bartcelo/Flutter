import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
// ignore: uri_does_not_exist
import 'package:path_provider/path_provider.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController equipered = TextEditingController();
  TextEditingController equipeblack = TextEditingController();
  TextEditingController totalRed = TextEditingController();
  TextEditingController totalBlack = TextEditingController();

  TextEditingController nomedaequipe = TextEditingController();
  TextEditingController nomedaequipedois = TextEditingController();

  String nomeequipe = 'Nome da equipe';

  final todos = <String>[];
  final _controller = TextEditingController();

  void nomeEquipe() {
    showDialog(
        context: context,
        child: SimpleDialog(
          title: Text('Digite o nome da equipe'),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Nome da equipe',
                  hintText: 'Digite o nome da equipe'),
              controller: nomedaequipe,
            ),
            RaisedButton(
              child: Text('ok'),
              onPressed: () {
                setState(() {

                  // ignore: missing_identifier
                  nomeequipe = _controller.text;
                  Navigator.of(context).pop(true);
                });
              },
            )
          ],
        ));
  }





  List _todolist = [];

  int _add = 1;

  void _adicionar (delta){
    setState(() {
      _add += delta;
    });
  }

  void _limpar (){
    setState(() {
       _add = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marcador de pontos', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
          onPressed:(){
            _limpar();
          }
          ,)
        ],
      ),
      floatingActionButton: 
      FloatingActionButton(onPressed: (){
        _adicionar(1);
      }, backgroundColor: Colors.red,
        child: Icon(Icons.add),),

      body: Column(

        children: <Widget>[

          Expanded(
            child:
          ListView.builder(
            padding: EdgeInsets.only(top: 10.0),
            itemCount: _add,
            itemBuilder:(context,index){
              _controller;
              //_controller.add(TextEditingController());
              final nome =  index + 1;
              return Center(
                child: Card(
                  child: Container(
                    padding: new EdgeInsets.all(05.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        AppBar(

                          backgroundColor: Colors.redAccent[100],
                          flexibleSpace: FlatButton(
                            child: Text('$nomeequipe '+'$nome', style: TextStyle(color: Colors.white, fontSize: 15.0),),
                            onPressed: nomeEquipe,
                          ),
                          actions: <Widget>[Icon(Icons.people)],
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: 'Pontos da Rodada',
                                hintText: 'Digite os pontos da Rodada'),
                            controller: equipered,
                          ),
                        ),
                        Container(
                          child: RaisedButton(
                            onPressed: (){},
                            child: Text(
                              "Somar",
                              //style: TextStyle(color: Colors.white),
                            ),
                            //color: Colors.black,
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(border: OutlineInputBorder()),

                          style: TextStyle(color: Colors.white),
                          controller: totalRed,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },

          ),
          )
        ],
      ),
    );
  }


  Future<File> _getFile() async{
   // final   directory = await getApplicationDocumentsDirectory();
   // return  File ("${directory.path}/data.jason");
  }

  Future<File> _saveData() async{
    String data = json.encode(_todolist);

    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String>_readData () async{
    try{
      final file = await _getFile();
      return file.readAsString();

    }
    catch(e){
      return null;
    }
  }

}


