import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:onibus2/helper/contact_helper.dart';
import 'package:onibus2/layout/pdf.dart';
import 'contac_page.dart';
import 'pdf.dart';




class TelaPoltrona extends StatefulWidget {
  @override
  _TelaPoltronaState createState() => _TelaPoltronaState();
}

class _TelaPoltronaState extends State<TelaPoltrona> {
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
          "Escolha sua Poltrona",
          style: TextStyle(color: Colors.black),
        )
      ), 
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            // Create a grid with 2 columns in portrait mode, or 3 columns in
            // landscape mode.
            crossAxisCount: orientation == Orientation.portrait ? 4 : 4,
            // Generate 100 widgets that display their index in the List.
            children: List.generate( 49, (index) {
              return Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.green,
                     border:Border.all(color: Colors.black,width: 2),
                     borderRadius: BorderRadius.all(Radius.circular(10))
                  
                  ),
                  child: Center(
                    child: Text(
                      '$index',
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                ),
              );
            }),
          );
        },
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

void _getAllContact() {
    helper.getAllContact().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }


 

}
