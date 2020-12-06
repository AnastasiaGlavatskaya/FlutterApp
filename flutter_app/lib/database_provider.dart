import 'books.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DatabaseProvider {
  static DatabaseProvider _instance = DatabaseProvider._internal();
  factory DatabaseProvider() => _instance;
  DatabaseProvider._internal();
  Database _db;

  Future<void> openBooksDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'books_database');

    _db = await openDatabase(
      path,
      version : 1,
       onCreate : (Database db, int version) => _createDatabase(db),
    );
  }

  Future<void> _createDatabase(Database db) async {
    await db.execute('CREATE TABLE IF NOT EXISTS $table ('
        '$columnId INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$columnTitle TEXT, '
        '$columnAuthor TEXT, '
        '$columnMark TEXT)');
  }

  Future<void> saveTable(Book book) async {
    await _db.insert(
        table,
        book.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Book>> getList() async {
    final List<Map<String, dynamic>> toMaps = await _db.query(table);
    return toMaps.map((book) => Book.fromMap(book)).toList();
  }

  Future<void> update(Book item) async {
    await _db.update(
        table,
        {
          columnTitle : item.title,
          columnAuthor : item.author,
          columnMark : item.mark
        },
      where: '$columnId = ?',
      whereArgs: [item.id],
    );
  }

  Future<void> delete(int id) async {
    await _db.delete(
        table,
        where: '$columnId = ?',
        whereArgs: [id],
    );
  }


}