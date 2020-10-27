import 'package:penproject/src/Models/User.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'package:path/path.dart';

class UserDatabase {
  UserDatabase._();

  static final UserDatabase db = UserDatabase._();

  static Database _database;

  Future<String> databasePath() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'users.db');
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
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Users ("
          "id TEXT,"
          "name TEXT,"
          "username TEXT,"
          "password TEXT,"
          "instituteCode TEXT,"
          "lastlogin TEXT,"
          "loggedin TEXT" // false - logged out, true - logged in
          ")");
      await db.execute("CREATE TABLE UserCustomizations ("
          "id TEXT,"
          "image TEXT,"
          "nickname TEXT"
          ")");
    });
  }

  Future<bool> login({User user, String name, String userid}) async {
    final db = await database;
    String now = DateTime.now().toUtc().toIso8601String();
    String loggedin = true.toString();
    await db.insert(
        "Users",
        {
          "id": userid,
          "name": name,
          "username": user.username,
          "password": user.password,
          "instituteCode": user.instituteCode,
          "lastlogin": now,
          "loggedin": loggedin,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);

    return true;
  }

  Future<User> getUserbyId(String id) async {
    var db = await database;
    User user;

    var res = await db.query("Users", where: "id = ?", whereArgs: [id]);
    if (res.isNotEmpty) {
      var first = res.first;
      user = User(
          id: first["id"],
          username: first["username"],
          password: first["password"],
          instituteCode: first["instituteCode"],
          loggedIn: bool.fromEnvironment(first["loggedin"]),
          lastLogin: DateTime.parse(first["lastlogin"]));
    }
    return (user != null) ? user : null;
  }

  Future<User> getUserbyLastLoggedIn() async {
    var db = await database;
    User user;

    var res = await db.query("Users",
        where: "loggedin = ?",
        whereArgs: [true.toString()],
        orderBy: "date(lastlogin) DESC");
    if (res.isNotEmpty) {
      var first = res.first;
      user = User(
          id: first["id"],
          username: first["username"],
          password: first["password"],
          instituteCode: first["instituteCode"],
          loggedIn: bool.fromEnvironment(first["loggedin"]),
          lastLogin: DateTime.parse(first["lastlogin"]));
    }
    return (user != null) ? user : null;
  }

  Future<List<User>> getUsers() async {
    var db = await database;
    List<User> users = [];

    var res = await db.query("Users");
    if (res.isNotEmpty) {
      res.forEach((e) {
        users.add(User(
            id: e["id"],
            username: e["username"],
            password: e["password"],
            instituteCode: e["instituteCode"],
            loggedIn: bool.fromEnvironment(e["loggedin"]),
            lastLogin: DateTime.parse(e["lastlogin"])));
      });
    }
    return users;
  }

  Future<bool> signout(String id) async {
    var db = await database;
    var res = await db.query("Users", where: "id = ?", whereArgs: [id]);
    var first = res.first;
    await db.update(
        "Users",
        {
          "id": id,
          "name": first["name"],
          "username": first["username"],
          "password": first["password"],
          "instituteCode": first["instituteCode"],
          "lastlogin": first["lastlogin"],
          "loggedin": false.toString(),
        },
        where: "id = ?",
        whereArgs: [id]);
    return true;
  }

  Future<bool> deleteUser(String id) async {
    var db = await database;
    await db.delete("Users", where: "id = ?", whereArgs: [id]);
    return true;
  }
}
