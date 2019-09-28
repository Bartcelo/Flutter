import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


final String poltronaTable = "poltronaColumn";
final String idColumn = "idColumn";
final String numeroColumn = "numeroColumn";
final String statusColumn = "statusColumn";
final String onibusColumn = "onibusColumn";
final String preferencialColumn = "preferencialColumn";

class PoltronaHelper{
 static final PoltronaHelper _instance =  PoltronaHelper.internal();
 factory PoltronaHelper() => _instance;
 PoltronaHelper.internal();
 
 Database _db;
 
 Future <Database> get db async{
   _db != null ? _db : _db = await initDb();
 }
    
    Future<Database> initDb() async{
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, "poltrona.db");
      return await openDatabase(path, version: 1, onCreate: (Database db, int newVersion)async{
        await db.execute(
          "CREATE TABLE $poltronaTable($idColumn INTEGER PRIMARY KEY,"
          " $numeroColumn INTEGER, $statusColumn INTEGER,"
          " $onibusColumn INTEGER, $preferencialColumn INTEGER)"
        );
      });

    }

    Future<Poltrona> savePoltrona(Poltrona poltrona)async{
      Database dbPoltrona =  await db;
      poltrona.id  = await dbPoltrona.insert(poltronaTable, poltrona.toMap());
      return poltrona;
    }

    Future<Poltrona> getPoltrona(int id) async{
      Database dbPoltrona = await db;
      List<Map> maps = await dbPoltrona.query(poltronaTable,
      columns: [idColumn,numeroColumn, statusColumn,onibusColumn,preferencialColumn],
      where: "$idColumn = ?",
      whereArgs: [id]);
      maps.length > 0 ? Poltrona.fromMap(maps.first) : null;
    }
    
    Future<int> deletPoltrona(int id)async{
      Database dbPoltrona = await db;
      return await dbPoltrona.delete(poltronaTable, where: "$idColumn = ?" ,whereArgs: [id]);
    }

    Future<int> updatPoltrona(Poltrona poltrona) async{
      Database dbPoltrona = await db;
      return await dbPoltrona.update(poltronaTable,
        poltrona.toMap(),
        where: "$idColumn = ?",
        whereArgs: [poltrona.id]);
    }

    Future<List> getAllPoltrona() async{
      Database dbPoltrona = await db;
      List listMap =  await dbPoltrona.rawQuery("SECT * FROM $poltronaTable");
      List<Poltrona> listPoltrona = List();
      for (Map pol in listMap){
        listPoltrona.add(Poltrona.fromMap(pol));
      }
      return listPoltrona;
    }
      
    Future<int> getContaPoltrona() async{
      Database dbPoltrona = await db;
      return Sqflite.firstIntValue(await dbPoltrona.rawQuery("SELECT COUNT (*)FROM $poltronaTable"));
    }

    Future closeDb()async{
      Database dbPoltrona = await db;
      dbPoltrona.close();
    }
}


class Poltrona{
 int id;
 int numero;
 int status;
 int onibus;
 int preferencial;

 Poltrona();
 Poltrona.fromMap(Map map){
   id           = map[idColumn];
   numero       = map[numeroColumn];
   status       = map[statusColumn];
   onibus       = map[onibusColumn];
   preferencial = map[preferencialColumn];
 }
List get length => null;

Map toMap(){
  Map<String, dynamic> map ={
    numeroColumn       : numero,
    statusColumn      : status,
    onibusColumn      : onibus,
    preferencialColumn: preferencial
  };
  if (id != null){
  map[idColumn]=id;
   }return map;

}
@override
  String toString() {
    return "Poltrona(id:$id, numero:$numero, status:$status, onibus:$onibus, preferencial:$preferencial)";
  }

}
