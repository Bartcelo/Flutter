import 'package:arranjo_onibus/tab_domingo.dart';
import 'package:arranjo_onibus/tab_sabado.dart';
import 'package:arranjo_onibus/tab_sexta.dart';
import 'package:flutter/material.dart';

import 'helper/contact_helper.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ContactHelper helper = ContactHelper();

  @override
  void initState() {
    super.initState();

     /*Contact c = Contact();
    c.nome ="Raiane Fairusia Krumenauer Gonzaga";
    c.rg = "002806707";
    c.poltrona ="26";
    c.grupo = "5";
    c.dia = "sexta";

    helper.saveContact(c);*/
    helper.getAllContact().then((list) {
      print(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blueGrey),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: null,
            ),
            title: Text('Arranjo de Onibus'),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.directions_bus),
                  child: Text('Sexta'),
                ),
                Tab(
                  icon: Icon(Icons.directions_bus),
                  child: Text("Sabado"),
                ),
                Tab(
                  icon: Icon(Icons.directions_bus),
                  child: Text("Domingo"),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white30,
            onPressed: () {},
            child: Icon(Icons.add, color: Colors.white),
          ),
          body: TabBarView(
            children: [
              new Card(
                color: Colors.white30,
                child: TabSexta(),
              ),
              new Card(
                color: Colors.white30,
                child: TabSabado(),
              ),
              new Card(
                color: Colors.white30,
                child: TabDomingo(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





















