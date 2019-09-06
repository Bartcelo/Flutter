import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


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
    "CREATE TABLE"
  );
});
}






}