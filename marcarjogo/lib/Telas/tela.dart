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

  void _novojogo (){
    equipered.text = '';
    equipeblack.text = '';
    totalRed.text = '';
    totalBlack.text = '';
}

  void _somarRed(){

    totalRed.text = null;

    setState(() {

       double um = double.parse(equipered.text);
       double dois = double.parse(totalRed.text);

       double soma = um + dois;

       totalRed.text = "$soma";

    });
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
                    color: Colors.red,
                    child: Container(
                      padding: new EdgeInsets.all(05.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Equipe Red",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          Divider(),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(border: OutlineInputBorder()),
                            style: TextStyle(color: Colors.white),
                            controller: equipered,
                          ),
                          Divider(),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: RaisedButton(
                                    onPressed: _somarRed,
                                    child: Text(
                                      "Somar",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          TextField(
                            enabled: false,
                              style: TextStyle(color: Colors.white),
                              controller:totalRed,

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
                    color: Colors.black,
                    child: Container(
                      padding: new EdgeInsets.all(05.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Equipe Black",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          Divider(),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(border: OutlineInputBorder()),
                            style: TextStyle(color: Colors.white),
                            controller: equipeblack,
                          ),
                          Divider(),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: RaisedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Somar",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          TextField(
                            enabled: false,
                            controller:totalBlack,

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
