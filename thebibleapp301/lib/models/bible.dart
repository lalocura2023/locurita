class BibleVerse {
  String book;
  int chapter;
  int verse;
  String text;
  int id;
  bool isFavorite;
  int color;
  String annotation;

  BibleVerse({
    this.book,
    this.chapter,
    this.text,
    this.verse,
    this.id,
    this.isFavorite,
    this.color,
    this.annotation
  });

  Map<String, dynamic> toMap() => {
        'BOOK': book,
        'CHAPTER': chapter,
        'TEXT': text,
        'VERSE': verse,
        'ROWID': id,
        'FAVORITE': isFavorite ? 1 : 0,
        'COLOR': color,
        'ANNOTATION': annotation
      };
}

class BibleChapter {
  String book;
  int chapter;

  BibleChapter({
    this.book,
    this.chapter,
  });
}
