import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  final String userId;
  DatabaseProvider(this.userId);

  static Database _database;

  Future<String> databasePath() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "data", '$userId.db');
    return path;
  }

  Future<Database> get database async {
    if (_database != null && _database.path == await databasePath())
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(await databasePath(), version: 1,
        onOpen: (Database db) async {
      await db.execute("CREATE TABLE IF NOT EXISTS Student ("
          "id TEXT UNIQUE,"
          "name TEXT,"
          "parents TEXT," // list
          "schoolId TEXT,"
          "schoolCity TEXT,"
          "schoolName TEXT,"
          "birth TEXT," // DateTime
          "yearId TEXT,"
          "address TEXT,"
          "groupId TEXT"
          ")");
      await db.execute("CREATE TABLE IF NOT EXISTS Lessons ("
          "uid TEXT UNIQUE,"
          "id TEXT,"
          "statusId TEXT,"
          "statusDescription TEXT,"
          "statusName TEXT,"
          "typeId TEXT,"
          "typeDescription TEXT,"
          "typeName TEXT,"
          "lessonIndex INTEGER,"
          "lessonYearIndex INTEGER,"
          "teacher TEXT,"
          "substituteTeacher TEXT,"
          "date TEXT," // DateTime
          "start TEXT," // DateTime
          "end TEXT," // DateTime
          "description TEXT,"
          "room TEXT,"
          "groupName TEXT,"
          "name TEXT,"
          "subjectId TEXT" // Subject id
          ")");
      await db.execute("CREATE TABLE IF NOT EXISTS Subjects ("
          "id TEXT UNIQUE,"
          "name TEXT,"
          "nickname TEXT," // customization
          "categoryId TEXT,"
          "categoryDescription TEXT,"
          "categoryName TEXT"
          ")");
      await db.execute("CREATE TABLE IF NOT EXISTS Events ("
          "id TEXT UNIQUE,"
          "title TEXT,"
          "start TEXT," // DateTime
          "end TEXT," // DateTime
          "content TEXT"
          ")");
      await db.execute("CREATE TABLE IF NOT EXISTS Exams ("
          "id TEXT UNIQUE,"
          "date TEXT," // DateTime
          "writeDate TEXT," // DateTime
          "teacher TEXT,"
          "modeId TEXT,"
          "modeName TEXT,"
          "modeDescription TEXT,"
          "description TEXT,"
          "groupName TEXT,"
          "subjectIndex INTEGER,"
          "subjectName TEXT"
          ")");
      await db.execute("CREATE TABLE IF NOT EXISTS Absences ("
          "id TEXT UNIQUE,"
          "date TEXT,"
          "delay INTEGER,"
          "submitDate TEXT," // DateTime
          "teacher TEXT,"
          "justificationId TEXT,"
          "justificationDescription TEXT,"
          "justificationName TEXT,"
          "typeId TEXT,"
          "typeDescription TEXT,"
          "typeName TEXT,"
          "modeId TEXT,"
          "modeDescription TEXT,"
          "modeName TEXT,"
          "subjectId TEXT,"
          "lessonStart TEXT," // DateTime
          "lessonEnd TEXT," // DateTime
          "lessonIndex INTEGER,"
          "groupName TEXT"
          ")");
      await db.execute("CREATE TABLE IF NOT EXISTS Evaluations ("
          "id TEXT UNIQUE,"
          "evalValue INTEGER,"
          "evalValueName TEXT,"
          "evalValueShortName TEXT,"
          "evalValueWeight INTEGER,"
          "date TEXT," // DateTime
          "teacher TEXT,"
          "description TEXT,"
          "typeId TEXT,"
          "typeDescription TEXT,"
          "typeName TEXT,"
          "groupId TEXT,"
          "subjectId TEXT,"
          "evalTypeId TEXT,"
          "evalTypeDescription TEXT,"
          "evalTypeName TEXT,"
          "modeId TEXT,"
          "modeDescription TEXT,"
          "modeName TEXT,"
          "writeDate TEXT," // DateTime
          "seenDate TEXT," // DateTime
          "form TEXT"
          ")");
      await db.execute("CREATE TABLE IF NOT EXISTS Notes ("
          "id TEXT UNIQUE,"
          "title TEXT,"
          "date TEXT," // DateTime
          "createDate TEXT," // DateTime
          "teacher TEXT,"
          "seenDate TEXT," // DateTime
          "groupId TEXT,"
          "content TEXT,"
          "typeId TEXT,"
          "typeDescription TEXT,"
          "typeName TEXT"
          ")");
      await db.execute("CREATE TABLE IF NOT EXISTS Homeworks ("
          "id TEXT UNIQUE,"
          "date TEXT," // DateTime
          "lessonDate TEXT," // DateTime
          "deadline TEXT," // DateTime
          "teacher TEXT,"
          "content TEXT,"
          "subjectName TEXT,"
          "groupName TEXT,"
          "attachments TEXT," // list
          "byTeacher TEXT," // boolean
          "homeworkEnabled TEXT," // boolean
          "isSolved TEXT" // boolean
          ")");
    });
  }
}
