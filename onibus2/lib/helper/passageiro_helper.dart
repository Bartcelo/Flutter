import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String passageiroTable = "passageiroColumn";
final String idColumn         = "idPassageiroColumn";
final String nomeColumn       = "nomePassageiroColumn";
final String grupoColumn      = "grupoColumn";
final String rgColumn         = "rgColumn";

class PassageiroHelper{

  static final PassageiroHelper _instance = PassageiroHelper.internal();
  factory PassageiroHelper() => _instance;
  PassageiroHelper.internal();


  Database _db;

  Future<Database> get db async{
    if( _db != null){
      return _db;
    }else {
      _db = await initDb();
      return _db;
    }
    }
    Future <Database> initDb() async{
    final databasesPath = await getDatabasesPath();
    final path =join(databasesPath, "contacts1.db");
    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async{
      await db.execute(
          "CREATE TABLE $passageiroTable($idColumn INTEGER PRIMARY KEY, $nomeColumn TEXT, $grupoColumn TEXT, $rgColumn TEXT)");
    }
    ); 
  }


  Future<Passageiro> savePassageiro(Passageiro passageiro) async{
    Database dbPassageiro = await db;
    passageiro.id = await dbPassageiro.insert(passageiroTable, passageiro.toMap());
    return passageiro;
  }
  Future <Passageiro> getPassageiro(int id) async{
    Database dbPassageiro = await db;
    List<Map> maps = await dbPassageiro.query(passageiroTable, columns: [idColumn, nomeColumn, grupoColumn,rgColumn],
    where: "$idColumn = ?",
    whereArgs: [id]);
    if(maps.length > 0 ){
      return Passageiro.fromMap(maps.first);
    }else{
      return null;
    }
  }
  Future<int> deletePassageiro(int id) async{
    Database dbPassageiro = await db;
    return dbPassageiro.delete(passageiroTable,where: "$idColumn = ?" , whereArgs: [id]);

  }  
  Future<int> updatPassageiro(Passageiro passageiro) async{
    Database dbPassageiro = await db;
    return await dbPassageiro.update(passageiroTable,
     passageiro.toMap(), 
     where: "$idColumn = ?",
     whereArgs: [passageiro.id]);
  }
  Future<List> getAllPassageiro()async{
    Database dbPassageiro = await db;
    List listMap = await dbPassageiro.rawQuery("SELECT * FROM $passageiroTable");
    List<Passageiro> listPassageiro = List();
    for (Map m in listMap){
      listPassageiro.add(Passageiro.fromMap(m));
      return listPassageiro;
    }
  }  
  Future<int> getNumberPassageiro() async{
    Database dbPassageiro = await db;
    return Sqflite.firstIntValue(await dbPassageiro.rawQuery("SELECT COUNT (*)FROM $passageiroTable"));
    }
  
  
  Future close() async{
    Database dbPassageiro = await db;
    return dbPassageiro.close();
  }
}


class Passageiro{
int id;
String nome;
int grupo;
int rg;

Passageiro();
Passageiro.fromMap(Map map){
  id = map[idColumn];
  nome = map[nomeColumn];
  grupo = map[grupoColumn];
  rg = map[rgColumn];
}

List get length => null;
Map toMap(){
  Map <String, dynamic> map ={
    nomeColumn : nome,
    grupoColumn: grupo,
    rgColumn   : rg
  };
  if(id != null){
    map[idColumn] = id;
  }return map;

  @override
  String toString(){
    return "Passageiro(id:$id, nome:$nome, grupo:$grupo, rg:$rg)";
  }

}
}