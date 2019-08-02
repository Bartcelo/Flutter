import 'dart:async';
import 'package:arranjo_onibus/helper/contact_helper.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import '../tab_sexta.dart';



class OnibusBloc implements BlocBase{

  TabSexta tabSexta;
  List<Contact> dia;



  final StreamController<bool> _sextaController = StreamController <bool>();
  Stream get outsexta => _sextaController.stream;

  final StreamController<bool>  _checkSexta   = StreamController<bool>();
  Sink get checkSexta =>_checkSexta.sink;


  SextaBloc(){
    tabSexta = TabSexta();
  }




  @override
  void dispose() {
    _sextaController.close();
    _checkSexta.close();
  }


}
