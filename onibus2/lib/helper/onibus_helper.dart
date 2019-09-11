import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


final String onibusTable      = "onibusTable";
final String idColumn         = "idColumn";
final String poltronaColumn   = "poltronaColumn";
final String capacidadeColumn = "capacidadeColumn";
final String capitaoColumn    = "capitaoColumn";


class OnibusHelper{
static final OnibusHelper _instance =OnibusHelper.internal();
factory OnibusHelper()=>_instance;
  OnibusHelper.internal();

Database _db;

Future<Database> get db async{

if (_db != null) {
  return _db;
} else {
_db= await initDb();
}

}

Future <Database> initDb()async{
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, "onibus.db");
return await openDatabase(path, version: 1, onCreate: (Database db, int newVersion)async{
  await db.execute(
    "CREATE TABLE $onibusTable($idColumn INTEGER PRIMARY KEY, $poltronaColumn INTEGER,"
    "$capacidadeColumn INTEGER, $capitaoColumn TEXT)"
  );
});
}

Future<Onibus> saveOnibus(Onibus onibus)async{
  Database dbOnibus =  await db;
  onibus.id = await dbOnibus.insert(onibusTable, onibus.toMap());
  return onibus;
}

Future<Onibus> getOnibus(int id) async{
  Database dbOnibus =  await db;
  List<Map> maps= await dbOnibus.query(onibusTable,
  columns: [idColumn, poltronaColumn, capacidadeColumn, capitaoColumn],
  where: "$idColumn = ?",
  whereArgs: [id]);

  maps.length > 0 ? Onibus.fromMap(maps.first): null; 
}
Future<int> deleteOnibus(int id) async{
    Database dbOnibus =  await db;
    return await dbOnibus.delete(onibusTable, where: "$idColumn = ?" ,whereArgs: [id]);
}
Future<int> updateOnibus(Onibus onibus) async{
  Database dbOnibus = await db;
  return await dbOnibus.update(onibusTable, 
    onibus.toMap(),
    where: "$idColumn = ?",
    whereArgs: [onibus.id]);
}
Future<List> getAllOnibus () async{
  Database dbOnibus =await db;
  List listMap = await dbOnibus.rawQuery("SELECT * FROM $onibusTable");
  List <Onibus> listOnibus = List();
  for (Map bus in listMap){
    listOnibus.add(Onibus.fromMap(bus));
  }
  return listOnibus;
}
Future<int> getContaOnibus() async{
  Database dbOnibus = await db;
  return Sqflite.firstIntValue(await dbOnibus.rawQuery("SELECT COUNT (*) FROM $onibusTable"));
}
Future closeDb() async{
  Database dbOnibus = await db;
  dbOnibus.close();
}

}
class Onibus{
int id;
int poltrona;
int capacidade;
String capitao;

Onibus();

Onibus.fromMap(Map map){

id         = map[idColumn];
poltrona   = map[poltronaColumn];
capacidade = map[capacidadeColumn];
capitao    = map[capacidadeColumn];
}
List get lengt => null;

Map toMap(){
Map<String, dynamic> map ={
poltronaColumn:   poltrona,
capacidadeColumn: capacidade,
capitao:          capitaoColumn
};
if (id != null){
  map[idColumn]=id;
}return map;

}
@override
  String toString() {
    return "Onibus(id:$id, poltrona:$poltrona, capacidade:$capacidade, capitao:$capitao)";
  }

}

