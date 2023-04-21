import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';
import '../models/bible.dart';

class BibleService {
  static Future<List<String>> getBibleBooks() async {
    Database db = await DatabaseHelper.database;

    List<Map<String, dynamic>> query = await db.rawQuery('SELECT * FROM BOOKS');

    List<String> result = [];

    query.forEach((element) {
      result.add(element['BOOKNAME']);
    });

    return result;
  }

  static Future<List<BibleChapter>> getBibleBookChapters({String book}) async {
    Database db = await DatabaseHelper.database;
    var query = await db.rawQuery("SELECT DISTINCT CHAPTER FROM BIBLE WHERE BOOK = '$book'");
    List<BibleChapter> bibleChapters = [];

    query.forEach((element) {
      bibleChapters.add(BibleChapter(book: book, chapter: element['CHAPTER']));
    });

    return bibleChapters;
  }

  static Future<List<BibleVerse>> getBibleBookVerses({String book, int chapter}) async {
    Database db = await DatabaseHelper.database;
    var query = await db.rawQuery("SELECT * FROM BIBLE WHERE BOOK = '$book' AND CHAPTER = '$chapter'");
    List<BibleVerse> bibleVerses = [];
    query.forEach((element) {
      bibleVerses.add(BibleVerse(
        book: book,
        chapter: element['CHAPTER'],
        text: element['TEXT'],
        verse: element['VERSE'],
        id: element['ROWID'],
        isFavorite: element['FAVORITE'] == 1 ? true : false,
        color: element['COLOR'],
        annotation: element['ANNOTATION'],
      ));
    });

    return bibleVerses;
  }

  static Future<List<BibleVerse>> getBibleBookVersesFavorites() async {
    Database db = await DatabaseHelper.database;
    var query = await db.rawQuery("SELECT * FROM BIBLE WHERE FAVORITE = 1");
    List<BibleVerse> bibleVerses = [];
    query.forEach((element) {
      bibleVerses.add(BibleVerse(
        book: element['BOOK'],
        chapter: element['CHAPTER'],
        text: element['TEXT'],
        verse: element['VERSE'],
        id: element['ROWID'],
        isFavorite: element['FAVORITE'] == 1 ? true : false,
        color: element['COLOR'],
        annotation: element['ANNOTATION'],
      ));
    });

    return bibleVerses;
  }

  static toggleFavoriteVerse({BibleVerse bibleVerse}) async {
    if (bibleVerse.isFavorite) {
      bibleVerse.color = 0;
      bibleVerse.annotation = null;
    }
    bibleVerse.isFavorite = !bibleVerse.isFavorite;
    Database db = await DatabaseHelper.database;
    try {
      var res = await db.update('BIBLE', bibleVerse.toMap(), where: "ROWID = ?", whereArgs: [bibleVerse.id]);
      print(res);
    } catch (e) {
      print(e);
    }
    return;
  }

  static changeFavoriteVerse({BibleVerse bibleVerse, String annotation, Color color}) async {
    bibleVerse.annotation = annotation;
    bibleVerse.color = color.value;
    Database db = await DatabaseHelper.database;
    try {
      var res = await db.update('BIBLE', bibleVerse.toMap(), where: "ROWID = ?", whereArgs: [bibleVerse.id]);
      print(res);
    } catch (e) {
      print(e);
    }
    return;
  }
}

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) _databaseHelper = DatabaseHelper._createInstance();
    return _databaseHelper;
  }

  static Future<Database> get database async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '/holybible2.db';

    if (FileSystemEntity.typeSync(path) != FileSystemEntityType.notFound) {
      _database = await openDatabase(path, version: 1, onOpen: (db) {});
    } else {
      _database = await initializeDatabase();
    }
    return _database;
  }

  static Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = directory.path + '/holybible2.db';

    ByteData data = await rootBundle.load("assets/databases/holybible2.db");
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes);

    var database = await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {},
    );
    return database;
  }
}
