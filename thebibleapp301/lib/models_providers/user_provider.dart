import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thebibleapp/environments.dart';

import '../models/bible.dart';
import '../models_services/bible_service.dart';

class UserProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future initState() async {
    fetchBibleBooks();
    getBibleBookVersesFavorites();
  }

  List<String> _biblebooks = [];
  List<String> get bibleBooks => _biblebooks;

  List<BibleChapter> _bibleChapters = [];
  List<BibleChapter> get bibleChapters => _bibleChapters;

  List<BibleVerse> _bibleVerses = [];
  List<BibleVerse> get bibleVerses => _bibleVerses;

  List<BibleVerse> _bibleVersesFavorites = [];
  List<BibleVerse> get bibleVersesFavorites => _bibleVersesFavorites;

  Future fetchBibleBooks() async {
    _biblebooks = await BibleService.getBibleBooks();
    notifyListeners();
  }

  Future getBibleBookChapters({String book}) async {
    _bibleChapters = await BibleService.getBibleBookChapters(book: book);
    notifyListeners();
  }

  Future getBibleBookVerses({String book, int chapter}) async {
    _bibleVerses = await BibleService.getBibleBookVerses(book: book, chapter: chapter);
    notifyListeners();
  }

  Future getBibleBookVersesFavorites() async {
    _bibleVersesFavorites = await BibleService.getBibleBookVersesFavorites();
    notifyListeners();
  }

  Future toggleFavoriteVerse({BibleVerse bibleVerse}) async {
    await BibleService.toggleFavoriteVerse(bibleVerse: bibleVerse);
    getBibleBookVersesFavorites();
    notifyListeners();
  }

  Future changeFavoriteVerse({BibleVerse bibleVerse, String annotation, Color color}) async {
    await BibleService.changeFavoriteVerse(bibleVerse: bibleVerse, annotation: annotation, color: color);
    getBibleBookVersesFavorites();
    notifyListeners();
  }
}
