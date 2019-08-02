import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:onibus2/helper/contact_helper.dart';

import 'contac_page.dart';

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  ContactHelper helper = ContactHelper();
  List<Contact> contacts = [];

  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;
  @override
  void initState() {
    super.initState();
    _getAllContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        leading: Icon(Icons.directions_bus),
        title: Text(
          'Arranjo de Ônibus',
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent[100],
        onPressed: () {
          // buildPdf;
          _showContacpage();
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Container(
        child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return contactCard(context, index);
            }),
        decoration: BoxDecoration(gradient: getCustomGradient()),
      ),
    );
  }

  LinearGradient getCustomGradient() {
    // Define a Linear Gradient
    return new LinearGradient(
        colors: [Colors.white, Colors.green[100]],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 2.9],
        tileMode: TileMode.clamp);
  }

  Widget contactCard(BuildContext context, int index) {
    final _formKey = GlobalKey<FormState>();
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
     // background: Container(
       // color: Colors.redAccent,
        //child: Align(
         // alignment: Alignment(1, 0),
          //child: Icon(
           // Icons.people,
            //color: Colors.white,
         // ),
       // ),
     // ),
      direction: DismissDirection.startToEnd,
      child: Container(
        child: Card(
            child: Column(
          children: <Widget>[
            AppBar(
                backgroundColor: Colors.green[50],
                title: Text(
                  contacts[index].nome ?? "",
                  style: TextStyle(color: Colors.black),
                )),
            Container(
                child: Row(
              //
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text('Grupo',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            contacts[index].grupo ?? "",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text('Pol',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            contacts[index].poltrona ?? "",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text('RG',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            contacts[index].rg ?? "",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.green[50],
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            contacts[index].sexta ?? "",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.green[50],
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            contacts[index].sabado ?? "",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.green[50],
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            contacts[index].domingo ?? "",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.mode_edit),
                        onPressed: () {
                          _showContacpage(contact: contacts[index]);
                        },
                      ),
                    )
                  ],
                )
              ],
            ))
          ],
        )),
      ),
      onDismissed: (direction) {
        setState(() {
          //_lastRemoved = Map.from(contacts[index].toMap());
          // _lastRemovedPos = index;

          helper.deleteContact(contacts[index].id);
          contacts.removeAt(index);
        });
      },
    );
  }

  void _showContacpage({Contact contact}) async {
    final recContact = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PaginaContato(
                  contact: contact,
                )));
    if (recContact != null) {
      if (contact != null) {
        await helper.updateContact(recContact);
      } else {
        await helper.saveContact(recContact);
      }
      _getAllContact();
    }
  }

  void _getAllContact() {
    helper.getAllContact().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }
}