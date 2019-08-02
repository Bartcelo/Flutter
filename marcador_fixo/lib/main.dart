import 'package:flutter/material.dart';


void main(){
    runApp(
      MaterialApp(
        home: Home(),
      )
    );
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
        title: Text('Marcador de pontos', style: TextStyle(color: Colors.white),),
    backgroundColor: Colors.red,
    actions: <Widget>[
    IconButton(icon: Icon(Icons.refresh),
    onPressed:(){}
        ),
      ]),
            body: Column(
          children: <Widget>[
            Center(
              child: Card(

                child:
                Column(
                children: <Widget>[
                  AppBar(
                    title: Text('Equipe Um', style: TextStyle(color: Colors.white),),
                    backgroundColor: Colors.red,
                    actions: <Widget>[
                      Icon(Icons.people),
                    ],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Pontos da Rodada',
                        hintText: 'Digite os pontos da Rodada'),

                  ),
                  RaisedButton(),

              ],
            ),
              ),
            )

      ],
      ) ,
    );
  }
}
