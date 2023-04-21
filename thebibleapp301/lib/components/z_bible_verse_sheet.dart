import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thebibleapp/models/bible.dart';
import 'package:thebibleapp/models_providers/user_provider.dart';

import '../environments.dart';

class BibleVerseSheet {
  static Future<void> buildShowDialog(BuildContext context, UserProvider userProvider, BibleVerse verse) async {
    String _annotation = verse.annotation;
    Color _color = verse.color != 0 ? Color(verse.color) : null;
    var saveTextButton = TextButton(onPressed: () {
      userProvider.changeFavoriteVerse(bibleVerse: verse, annotation: _annotation, color: _color);
      Navigator.pop(context, true);
    }, child: Text("Save"));
    var annotationTextFormField = TextFormField(
      initialValue: verse.annotation,
      onChanged: (value) {
        _annotation = value;
      },
      maxLines: 2,
      decoration: new InputDecoration(hintText: "Annotation"),
    );
    var colorButtons = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (Color favorite_color in Environment.FAVORITE_COLORS)
        /* Expanded(
                  child: */ ElevatedButton(
          onPressed: () { _color = favorite_color;},
          child: Text(""),
          style: ElevatedButton.styleFrom(
            primary: favorite_color,
            shadowColor: Colors.transparent,
            shape: CircleBorder(side: BorderSide(
                width: 3,
                color: _color?.value == favorite_color.value ? Colors.white60 : Colors.black38
            )
            ),                            ),
        )
        //)
      ],
    );
    var verseStyleBuilder = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        annotationTextFormField,
        SizedBox(height: 10),
        colorButtons
      ],
    );


    /*
    return showDialog<void>(context: context, builder: (BuildContext context) {
      return AlertDialog(
              content: verseStyleBuilder,
              actions: [
                saveTextButton
              ],
            );
    });
    */
    Get.bottomSheet(Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: annotationTextFormField,
            ),
          ),
          GestureDetector(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: colorButtons
            ),
          ),
          Divider(height: 0),
          GestureDetector(
            child: saveTextButton,
          ),
          if (Platform.isIOS) SizedBox(height: 10)
        ],
      ),
    ));
  }
}