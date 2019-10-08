import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String reservaTable     = "reservaTable";  
final String idColumn         = "idColumn";
final String dataColunm       = "dataColumn";
final String poltronaColumn   = "poltronaColumn";
final String reservaColumn = "ReservaColumn";
 
class ReservaHelper{
  static final ReservaHelper _instance = ReservaHelper.internal();
  factory ReservaHelper() => _instance;
  ReservaHelper.internal();

  Database _db;

  Future<Database> get db async{

    if(_db != null){
      return _db;
    } else{
      _db = await initDb();
      return _db;
      }
  }
  Future <Database> initDb()async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath,"contacts1.db");
    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async{
      await db.execute("CREATE TABLE $reservaTable($idColumn INTEGER PRIMARY KEY, $dataColunm TEXT, $poltronaColumn TEXT, $reservaColumn TEXT)");
    });
  }
  Future<Reserva> saveReserva(Reserva reserva) async{
    Database dbReserva = await db;
    reserva.id = await dbReserva.insert(reservaTable, reserva.toMap());
    return reserva;
  }
  Future <Reserva> getReserva(int id) async{
    Database dbReserva = await db;
    List<Map> maps = await dbReserva.query(reservaTable, columns: [idColumn, dataColunm, poltronaColumn],
    where: "$idColumn = ?",
    whereArgs: [id]);
    if(maps.length > 0 ){
      return Reserva.fromMap(maps.first);
    }else{
      return null;
    }
  }
  Future<int> deleteReserva(int id) async{
    Database dbReserva = await db;
    return dbReserva.delete(reservaTable,where: "$idColumn = ?" , whereArgs: [id]);

  }  
  Future<int> updatReserva(Reserva reserva) async{
    Database dbReserva = await db;
    return await dbReserva.update(reservaTable,
     reserva.toMap(), 
     where: "$idColumn = ?",
     whereArgs: [reserva.id]);
  }
  Future<List> getAllReserva()async{
    Database dbReserva = await db;
    List listMap = await dbReserva.rawQuery("SELECT * FROM $reservaTable");
    List<Reserva> listReserva = List();
    for (Map m in listMap){
      listReserva.add(Reserva.fromMap(m));
      return listReserva;
    }
  }  
  Future<int> getNumberReserva() async{
    Database dbReserva = await db;
    return Sqflite.firstIntValue(await dbReserva.rawQuery("SELECT COUNT (*)FROM $reservaTable"));
    }
  
  
  Future close() async{
    Database dbReserva = await db;
    return dbReserva.close();
  }
}



class Reserva{

int id;
String data;
int poltrona;
String reserva;

Reserva ();
Reserva.fromMap(Map map){
id         = map[idColumn];
data       = map[dataColunm];
poltrona   = map[poltronaColumn];
reserva = map[reservaColumn];
}

List get length => null;
Map toMap(){
  Map<String, dynamic> map={
    dataColunm       : data,
    poltronaColumn   : poltrona,
    reservaColumn : Reserva 
  };
  if(id != null){
    map[idColumn] = id;
  } return map;

@override
  String toString(){
    return "Reserva(id:$id, data:$data, poltrona:$poltrona, reserva:$reserva)";
  }

}
}