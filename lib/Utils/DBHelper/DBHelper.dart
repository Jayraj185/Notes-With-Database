import 'dart:io';
import 'package:notes/Screens/HomeScreen/Model/HomeModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper
{

  static DBHelper dbHelper = DBHelper._();
  DBHelper._();

  Database? database;
  //Check Database
  Future<Database?> CheckDB()
  async {
    if(database != null)
      {
        return database;
      }
    else
      {
        return await CreateDB();
      }
  }

  //Create Database
  Future<Database> CreateDB()
  async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,"notes.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query = "CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, usertext TEXT, date TEXT, month TEXT, time TEXT)";
        db.execute(query);
      },
    );
  }

  //Insert Data In Database
  void InsertData(HomeModel homeModel) async
  {

    database = await CheckDB();

    database!.insert("notes", {
      'title' : homeModel.title,
      'usertext' : homeModel.description,
      'date' : homeModel.day,
      'month' : homeModel.month,
      'time' : homeModel.time
    });

  }

  //Read Data In Database
  Future<List<HomeModel>> ReadData() async
  {

    database = await CheckDB();
    String ReadQuery = "SELECT * FROM notes";

    List<Map> data = await database!.rawQuery(ReadQuery);
    List<HomeModel> notes = data.map((e) => HomeModel().fromMap(e)).toList();
    return notes;
  }

  //Read Data In Database
  void UpdateData({required HomeModel homeModel, required int id}) async
  {
    database = await CheckDB();
    database!.update(
        "notes",
        {
          'title' : homeModel.title,
          'usertext' : homeModel.description,
          'date' : homeModel.day,
          'month' : homeModel.month,
          'time' : homeModel.time
        },
        where: "id = ?",
        whereArgs: [id]
    );
  }

  //Delete Data In Database
  void DeleteData({required int id}) async
  {
    database = await CheckDB();
    database!.delete('notes',where: "id = ?", whereArgs: [id]);
  }

}