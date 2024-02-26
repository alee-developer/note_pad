import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_pad/models/notes_model.dart';
import 'package:note_pad/views/screens/notes/notes_details_screen.dart';
import 'package:note_pad/views/screens/notes/search_note_screen.dart';
import 'package:note_pad/views/utils/colors.dart';
import 'package:note_pad/views/utils/constants.dart';
import 'package:note_pad/views/utils/extensions/context_extensions.dart';
import 'package:note_pad/views/utils/extensions/int_extensions.dart';
import 'package:note_pad/views/utils/extensions/widget_extensions.dart';

class HomeWidgets {
  BuildContext context;

  HomeWidgets({required this.context});

  AppBar homeAppBarView() => AppBar(
        title: const Text(NOTES),
        actions: [
          _itemCardView(IconButton(
              onPressed: () {
                const SearchNoteScreen().pushWithWidget(context: context);
              },
              icon: const Icon(CupertinoIcons.search))),
          10.width
        ],
      );

  Widget _itemCardView(Widget child) => Card(
        elevation: 5,
        color: kPrimaryLightColor,
        child: child,
      );

  Widget noNotesView(
      {String item = "assets/images/no_note.png",
      String title = NO_NOTES_MESSAGE}) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            item,
            width: context.fullWidth / 1.5,
          ),
          5.height,
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          )
        ],
      ),
    );
  }

  Widget notesItemView(NotesModel data, Color itemColor, int index,
      {void Function(DismissDirection)? onDismissed}) {
    return Dismissible(
        background: const Icon(Icons.delete),
        onDismissed: onDismissed,
        key: UniqueKey(),
        child: ListTile(
          onTap: () {
            NotesDetailsScreen(
              notesModel: data,
              index: index,
            ).pushWithWidget(context: context);
          },
          trailing: SizedBox(
            width: 100,
            height: context.fullHeight,
            child: Text(data.createdAt?.split(" ").last ?? "")
                .align(alignment: Alignment.bottomRight),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          title: Text(
            data.title ?? "NA",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          tileColor: itemColor,
          subtitle: Text(
            data.description ?? "NA",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ));
  }

  List<Color> usedColors = [];
  Random random = Random();

  Color getRandomColor() {
    if (usedColors.length == appColors.length) {
      usedColors.clear();
    }
    Color color;
    do {
      color = appColors[random.nextInt(appColors.length)];
    } while (usedColors.contains(color));

    usedColors.add(color);
    return color;
  }

  Widget floatingButtonView({void Function()? onPressed}) =>
      FloatingActionButton(
        onPressed: onPressed,
        child: const Icon(Icons.add),
      );
}
