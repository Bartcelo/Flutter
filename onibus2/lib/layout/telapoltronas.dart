import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:onibus2/helper/contact_helper.dart';


class TelaPoltrona extends StatefulWidget {
  @override
  _TelaPoltronaState createState() => _TelaPoltronaState();
}

class _TelaPoltronaState extends State<TelaPoltrona> {
  ContactHelper helper = ContactHelper();
  List <Contact> contacts =  [];
  List <Poltronas> poltrona = []; 



 

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
       
      body:      
      OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            // Create a grid with 4 columns in portrait mode, or 4 columns in
            // landscape mode.
            crossAxisCount: orientation == Orientation.portrait ? 4 : 4,
            // Generate 49 widgets that display their index in the List.
            children: List.generate( 48, (index) {
              index = index +1;     
            // -------------------------------  Mudando a cor da poltrona  
            return Center(
                child: Stack(
                  alignment: Alignment.topCenter,
                                  children:<Widget>[ 
                Container(                  
                  width: 80,
                  height: 80,
                 decoration: BoxDecoration(
                      color:Colors.green[300],
                       border:Border.all(color: Colors.black,width: 2),
                       borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                    
                    ),
                ),                    
                Container(
                  
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color:Colors.green[100],
                       border:Border.all(color: Colors.black,width: 2),
                      // borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                    
                    ),
                    child: Center(
                      child: Text(
                        '$index',
                        style: Theme.of(context).textTheme.headline,
                      ),
                    ),
                  ),]
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

   _getPoltronas() {
    helper.getPoltronas().then((list) {
      setState(() {
        poltrona = list;
      });
    });
  }
 }
