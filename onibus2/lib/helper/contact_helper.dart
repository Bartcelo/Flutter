import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


final String contactTable = "contactTable";
final String idColumn = "idColumn";
final String nomeColumn = "nomeColumn";
final String rgColumn = "rgColumn";
final String poltronaColumn = "poltronaColumn";
final String grupoColumn = "grupoColumn";
final String sextaColumn = "sextaColumn";
final String sabadoColumn = "sabadoColumn";
final String domingoColumn = "domingoColumn";





class ContactHelper {
  static final ContactHelper _instance = ContactHelper.internal();
  factory ContactHelper() => _instance;
  ContactHelper.internal();

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
          "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nomeColumn TEXT,"
              "$rgColumn TEXT, $poltronaColumn TEXT, $grupoColumn TEXT, $sextaColumn Text,$sabadoColumn Text, $domingoColumn Text)");
    }
    );
  }
  Future<Contact> saveContact(Contact contact)async{
    Database dbcontact = await db;
    contact.id = await dbcontact.insert(contactTable, contact.toMap());
    return contact;
  }
  Future<Contact> getContact(int id)async{
    Database dbcontact = await db;
    List<Map> maps = await dbcontact.query(contactTable,
    columns: [idColumn, nomeColumn, rgColumn, poltronaColumn, grupoColumn, sextaColumn, sabadoColumn, domingoColumn],
    where: "$idColumn =?",
    whereArgs: [id]);
    if(maps.length > 0){
      return Contact.fromMap(maps.first);
      }else {
      return null;
    }
  }

  Future<int> deleteContact (int id) async{
    Database dbContact = await db;
    return await dbContact.delete(contactTable,
     where: "$idColumn = ? ",
     whereArgs: [id]);
  }
  Future<int> updateContact(Contact contact) async{
    Database dbContact = await db;
    return await dbContact.update(contactTable,
        contact.toMap(),
        where: "$idColumn = ?",
        whereArgs: [contact.id]);

  }

   Future<List> getAllContact() async{
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<Contact> listContact = List();
    for (Map m  in listMap){
      listContact.add(Contact.fromMap(m));
    }
    return listContact;
  }

  Future <int> getNumber() async{
    Database dbContact = await db;
    return Sqflite.firstIntValue(await dbContact.rawQuery("SELECT COUNT (*)FROM $contactTable"));
  }

  Future close() async{
    Database dbContact = await db;
    dbContact.close();
  }
}

class Contact{


  int id;
  String nome;
  String rg;
  String poltrona;
  String grupo;
  String sexta;
  String sabado;
  String domingo;

  Contact ();

  Contact.fromMap(Map map){
    id = map[idColumn];
    nome = map[nomeColumn];
    rg = map[rgColumn];
    poltrona = map[poltronaColumn];
    grupo = map[grupoColumn];
    sexta = map[sextaColumn];
    sabado = map[sabadoColumn];
    domingo = map[domingoColumn];

    }

  List get length => null;
  Map toMap(){
    Map<String, dynamic >map ={
      nomeColumn: nome,
      rgColumn:rg,
      poltronaColumn: poltrona,
      grupoColumn: grupo,
      sextaColumn: sexta,
      sabadoColumn: sabado,
      domingoColumn: domingo,

    };

    if(id != null){
      map[idColumn]=id;
    }
    return map;
  }

  @override
  String toString() {
    return "Contact(id:$id, nome:$nome, rg:$rg, poltrona:$poltrona, grupo:$grupo, sexta:$sexta, sabado:$sabado, domingo:$domingo )";
  }
}
