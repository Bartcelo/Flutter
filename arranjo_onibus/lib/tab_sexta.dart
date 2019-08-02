import 'package:flutter/material.dart';

import 'helper/contact_helper.dart';

class TabSexta extends StatefulWidget {
  @override
  _TabSextaState createState() => _TabSextaState();
}

class _TabSextaState extends State<TabSexta> {
  ContactHelper helper = ContactHelper();
  List<Contact> contacts = List();

  bool _sexta = false;

  @override
  void initState() {
    super.initState();
    helper.getAllContact().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return _contactCard(context, index);
          }),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    final _formKey = GlobalKey<FormState>();

    return GestureDetector(
      child: Card(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppBar(
                leading: Icon(Icons.person),
                title: Text(contacts[index].nome ?? ""),
                actions: <Widget>[
                  IconButton(icon: Icon(Icons.card_travel), onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Nome Completo',
                                      labelText: 'NOME'
                                    ),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(

                                      hintText: 'Apenas Números',
                                      labelText: 'RG',
                                    ),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(

                                      hintText: 'Apenas Números',
                                      labelText: 'POLTRONA',
                                    ),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(

                                      hintText: 'Apenas Números',
                                      labelText: 'GRUPO',
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('Sex'),
                                      Checkbox(value: _sexta,
                                          onChanged: (bool resp) {
                                            setState(() {
                                              _sexta = resp;
                                            });
                                          }
                                      ),
                                      Text('Sab'),
                                      Checkbox(value: _sexta,
                                          onChanged: (bool resp) {
                                            setState(() {
                                              _sexta = resp;
                                            });
                                          }
                                      ),
                                      Text('Dom'),
                                      Checkbox(value: _sexta,
                                          onChanged: (bool resp) {
                                            setState(() {
                                              _sexta = resp;
                                            });
                                          }
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: RaisedButton(
                                      child: Text("SALVAR"),
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  })
                ],
              ),
              Row(
                children: <Widget>[
                  Text("RG"),
                  Text(
                    contacts[index].rg ?? "",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),

              Row(
                children: <Widget>[
                  Text("Poltrona"),
                  Text(
                    contacts[index].poltrona ?? "",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Grupo"),
                  Text(
                    contacts[index].grupo ?? "",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),

                ],
              )



            ],
          ),
        ),
      ),
    );
  }
}
