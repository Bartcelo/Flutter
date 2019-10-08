import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


final String eventoTable = "eventoTable";
final String idColumn    = "diColumn";
final String nomeColumn  = "nomeColumn";
final String dataColumn ="dataColumn";

class EventoHelper{
  static final EventoHelper _instance = EventoHelper.internal();
  factory EventoHelper() => _instance;
  EventoHelper.internal();

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
    final path =join(databasesPath, "eventos1.db");
    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async{
      await db.execute(
      "CREATE TABLE $eventoTable($idColumn INTEGER PRIMARY KEY, $nomeColumn TEXT, $dataColumn TEXT )");
    }
    );
  }
  Future<Evento> saveEvento(Evento evento)async{
    Database dbEvento = await db;
    evento.id = await dbEvento.insert(eventoTable, evento.toMap());
    return evento;
  }
  Future<Evento> getEvento(int id)async{
    Database dbEvento = await db;
    List<Map> maps = await dbEvento.query(eventoTable,
    columns: [idColumn, nomeColumn, dataColumn],
    where: "$idColumn =?",
    whereArgs: [id]);
    if(maps.length > 0){
      return Evento.fromMap(maps.first);
      }else {
      return null;
    }
  }
  Future<int> deleteEvento (int id) async{
    Database dbEvento = await db;
    return await dbEvento.delete(eventoTable,
     where: "$idColumn = ? ",
     whereArgs: [id]);
  }
  Future<int> updateEvento(Evento evento) async{
    Database dbEvento = await db;
    return await dbEvento.update(eventoTable,
        evento.toMap(),
        where: "$idColumn = ?",
        whereArgs: [evento.id]);
  }
  Future<List> getAllEvento() async{
    Database dbEvento = await db;
    List listMap = await dbEvento.rawQuery("SELECT * FROM $eventoTable");
    List<Evento> listEvento = List();
    for (Map m  in listMap){
      listEvento.add(Evento.fromMap(m));
    }
    return listEvento;
  }
  Future <int> getNumber() async{
    Database dbEvento = await db;
    return Sqflite.firstIntValue(await dbEvento.rawQuery("SELECT COUNT (*)FROM $eventoTable"));
  }
  Future close() async{
    Database dbEvento = await db;
    dbEvento.close();
  }
}

class Evento{

int id;
String nome;
String data;

Evento();

Evento.fromMap(Map map){
  id   = map[idColumn];
  nome = map[nomeColumn];
  data = map[dataColumn];
}

List get length => null;
Map toMap (){
  Map<String, dynamic>map ={
    nomeColumn: nome,
    dataColumn: data
  };
  if(id != null){
      map[idColumn]=id;
    }
    return map;
}
@override
  String toString() {
    return "Eventot(id:$id, nome:$nome, data:$data)";
  }
}


