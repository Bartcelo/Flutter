import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController equipered = TextEditingController();
  TextEditingController equipeblack = TextEditingController();
  TextEditingController totalRed = TextEditingController();
  TextEditingController totalBlack = TextEditingController();

  TextEditingController nomedaequipe = TextEditingController();
  TextEditingController nomedaequipedois = TextEditingController();

  String nomeequipe = 'Nome da Equipe Um';
  String nomeequipedois = 'Nome da Equipe Dois';

  void _novojogo() {
    setState(() {

      equipered.text = '';
      equipeblack.text = '';
      //totalRed.text = 0 as String;
      totalBlack.text = '';
      nomeequipe = 'Nome da Equipe Um';
      nomeequipedois = 'Nome da Equipe Dois';

    });

  }

//  o metodo abaixo faz a soma dos valores da equipe  vermelha
  // nesse metodo preciso somar o valor que foi feito nessa rodada com o da proxima.




  void _somarRed() {

    int um = totalRed.value as int ;
    int dois = int.parse(equipered.text);

  int soma = um + dois;

  totalRed.text = '$soma';

  }
// ----------------------------------------------------------------------------------

  void nomeEquipe() {
    showDialog(
        context: context,
        child: SimpleDialog(
          title: Text('Digite o nome da equipe'),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Nome da equipw',
                  hintText: 'Digite o nome da equipe'),
              controller: nomedaequipe,
            ),
            RaisedButton(
              child: Text('ok'),
              onPressed: () {
                setState(() {
                  nomeequipe = nomedaequipe.text;
                  Navigator.of(context).pop(true);
                });
              },
            )
          ],
        ));
  }


  void nomeEquipedois() {
    showDialog(
        context: context,
        child: SimpleDialog(
          title: Text('Digite o nome da equipe'),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Nome da equipw',
                  hintText: 'Digite o nome da equipe'),
              controller: nomedaequipedois,
            ),
            RaisedButton(
              child: Text('ok'),
              onPressed: () {
                setState(() {
                  nomeequipedois = nomedaequipedois.text;
                  Navigator.of(context).pop(true);
                });
              },
            )
          ],
        ));
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pontos",
              style: TextStyle(color: Colors.white, fontSize: 20.0)),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(05.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: Card(

                    color: Colors.blueAccent,
                    child: Container(
                      padding: new EdgeInsets.all(05.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          AppBar(
                            backgroundColor: Colors.red,
                            flexibleSpace: FlatButton(
                              child: Text(nomeequipe),
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
                              onPressed: _somarRed,
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
                ),
                Center(
                  child: Card(
                    child: Container(
                      padding: new EdgeInsets.all(05.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: RaisedButton(
                                    onPressed: _novojogo,
                                    child: Text(
                                      "Novo Jogo",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Card(
                    color: Colors.blueAccent,
                    child: Container(
                      padding: new EdgeInsets.all(05.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          AppBar(
                            flexibleSpace: FlatButton(
                              child: Text(nomeequipedois),
                              onPressed: nomeEquipedois,
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
                              controller: equipeblack,
                            ),
                          ),
                          Container(
                            child: RaisedButton(
                              onPressed: _somarRed,
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
                            controller: totalBlack,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
