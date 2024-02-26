import 'package:note_pad/models/notes_model.dart';
import 'package:note_pad/views/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

mixin class NotesController {
  Database? _database;
  final NOTES_TABLE_NAME = "notes";
  final NOTES_ID = 'id';
  final NOTES_TITLE = 'title';
  final NOTES_DESC = 'description';
  final NOTES_CREATED_AT = 'createdAt';
  final NOTES_UPDATED_AT = 'updatedAt';

  Future<Database?> get getDatabase async {
    if (_database != null) return _database;
    _database = await _createDB();
    return _database;
  }

  Future<Database> _createDB() async {
    var path = await getDatabasesPath();
    var dbName = path + DATABASE_NAME;
    return await openDatabase(dbName,
        onCreate: _createTables, version: DATABASE_VERSION);
  }

  _createTables(Database db, int version) async {
    await db.execute(
        """CREATE TABLE $NOTES_TABLE_NAME ($NOTES_ID INTEGER PRIMARY KEY, $NOTES_TITLE TEXT, $NOTES_DESC TEXT, $NOTES_CREATED_AT TEXT, $NOTES_UPDATED_AT TEXT)""");
  }

  Future<int?> addNewNote(NotesModel data) async {
    var db = await getDatabase;
    return await db?.insert(NOTES_TABLE_NAME, data.toJson());
  }

  Future<int?> updateNote(NotesModel data) async {
    var db = await getDatabase;
    return db?.update(NOTES_TABLE_NAME, data.toJson(),
        where: 'id = ?', whereArgs: [data.id]);
  }

  Future<List<NotesModel>?> getAllNotes() async {
    var db = await getDatabase;
    var data = await db?.query(NOTES_TABLE_NAME);
    return data?.map((e) => NotesModel.fromJson(e)).toList();
  }

  Future<int?> deleteNote(int id) async {
    var db = await getDatabase;
    return await db?.delete(NOTES_TABLE_NAME, where: "id =?", whereArgs: [id]);
  }
}
