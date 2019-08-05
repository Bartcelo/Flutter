import 'package:flutter/material.dart';
import 'package:onibus2/helper/contact_helper.dart';

class PaginaContato extends StatefulWidget {
  final Contact contact;

  PaginaContato({this.contact});

  @override
  _PaginaContatoState createState() => _PaginaContatoState();
}

class _PaginaContatoState extends State<PaginaContato> {
  bool _dom = true;

  Contact _editContact;
  bool _userEdited = false;

  final _nomecontroller = TextEditingController();
  final _rgcontroller = TextEditingController();
  final _poltronacontroller = TextEditingController();
  final _grupocontroller = TextEditingController();
  final _sextacontroller = TextEditingController();
  final _sabadocontroller = TextEditingController();
  final _domingocontroller = TextEditingController();
  final _focusNome = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.contact == null) {
      _editContact = Contact();
    } else {
      _editContact = Contact.fromMap(widget.contact.toMap());

      _nomecontroller.text = _editContact.nome;
      _rgcontroller.text = _editContact.rg;
      _poltronacontroller.text = _editContact.poltrona;
      _grupocontroller.text = _editContact.grupo;
      _sextacontroller.text = _editContact.sexta;
      _sabadocontroller.text = _editContact.sabado;
      _domingocontroller.text = _editContact.domingo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[100],
          leading: Icon(Icons.directions_bus),
          title: Text(
            _editContact.nome ?? 'Novo Contato',
            style: TextStyle(color: Colors.black),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.greenAccent[100],
          onPressed: () {
            if (_editContact.nome != null && _editContact.nome.isNotEmpty) {
              Navigator.pop(context, _editContact);
            } else {
              FocusScope.of(context).requestFocus(_focusNome);
            }
          },
          child: Icon(Icons.save, color: Colors.white),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                focusNode: _focusNome,
                controller: _nomecontroller,
                decoration: InputDecoration(labelText: "Nome"),
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    _editContact.nome = text;
                  });
                },
              ),
              TextField(
                controller: _rgcontroller,
                decoration: InputDecoration(labelText: "RG"),
                onChanged: (text) {
                  _userEdited = true;
                  _editContact.rg = text;
                },
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _poltronacontroller,
                decoration: InputDecoration(labelText: "Poltrona"),
                onChanged: (text) {
                  if (int.parse(text) > 46) {
                    _maxPoltronas();
                    _poltronacontroller.text = "";
                  }
                  _userEdited = true;
                  _editContact.poltrona = text;
                },
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _grupocontroller,
                decoration: InputDecoration(labelText: "Grupo"),
                onChanged: (text) {
                  if (int.parse(text) > 6) {
                    _maxGrupo();
                    _grupocontroller.text = "";
                  }
                  _userEdited = true;
                  _editContact.grupo = text;
                },
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _sextacontroller,
                decoration: InputDecoration(labelText: "Sexta"),
                onChanged: (text) {
                  _userEdited = true;
                  _editContact.sexta = text;
                },
              ),
              TextField(
                controller: _sabadocontroller,
                decoration: InputDecoration(labelText: "Sabado"),
                onChanged: (text) {
                  _userEdited = true;
                  _editContact.sabado = text;
                },
              ),
              TextField(
                controller: _domingocontroller,
                decoration: InputDecoration(labelText: "Domingo"),
                onChanged: (text) {
                  _userEdited = true;
                  _editContact.domingo = text;
                },
              ),
              new Checkbox(
                onChanged: (bool resp) {
                  setState(() {
                    _dom = resp;
                  });
                },
                value: _dom,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Descartar Alterações?'),
              content: Text('Se sair as alterações serão perdidas'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text('Sim'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  void _maxPoltronas() {
    showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("O número maximo de poltronas é  46"),
          actions: <Widget>[
            new FlatButton(
                onPressed: () => Navigator.pop(context), child: new Text('Ok'))
          ],
        ));
  }

  void _maxGrupo() {
    showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("O número maximo de grupos é 6"),
          actions: <Widget>[
            new FlatButton(
                onPressed: () => Navigator.pop(context), child: new Text('Ok'))
          ],
        ));
  }

}
