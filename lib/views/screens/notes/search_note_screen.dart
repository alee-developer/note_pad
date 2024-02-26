import 'package:flutter/material.dart';
import 'package:note_pad/views/screens/home/home_widgets.dart';
import 'package:note_pad/views/utils/extensions/int_extensions.dart';
import 'package:note_pad/views/utils/extensions/widget_extensions.dart';
import 'package:provider/provider.dart';
import '../../../controllers/notes_controller.dart';
import '../../../controllers/notes_provider.dart';

class SearchNoteScreen extends StatefulWidget {
  const SearchNoteScreen({
    super.key,
  });

  @override
  State<SearchNoteScreen> createState() => _SearchNoteScreenState();
}

class _SearchNoteScreenState extends State<SearchNoteScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<NotesProvider>(builder: (c, snap, w) {
          return _searchCard(TextFormField(
            controller: searchController,
            cursorColor: Colors.black,
            onChanged: (text) {
              snap.searchFromNotes(text);
              if (text.isNotEmpty) {
                snap.checkSearching(true);
              } else {
                snap.checkSearching(false);
              }
            },
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();
                      snap.searchFromNotes(searchController.text);
                    },
                    icon: const Icon(Icons.clear)),
                hintText: "Search notes...",
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                border: InputBorder.none),
          ));
        }),
      ),
      body: Consumer<NotesProvider>(builder: (c, snap, w) {
        return snap.isSearching
            ? searchedItemView(context)
            : mainItemView(context);
      }),
    );
  }

  Widget _searchCard(Widget child) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: child,
    );
  }

  Widget mainItemView(BuildContext context) {
    var view = HomeWidgets(context: context);
    return Consumer<NotesProvider>(builder: (c, snap, w) {
      var data = snap.notes;
      return data.isNotEmpty
          ? ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (c, index) {
                return view
                    .notesItemView(data[index], view.getRandomColor(), index,
                        onDismissed: (d) {
                  setState(() {
                    NotesController().deleteNote(data[index].id ?? 0);
                    data.removeAt(index);
                  });
                });
              },
              separatorBuilder: (c, index) {
                return 5.height;
              },
              itemCount: data.length)
          : view.noNotesView().center();
    });
  }

  searchedItemView(BuildContext context) {
    var view = HomeWidgets(context: context);
    return Consumer<NotesProvider>(builder: (c, snap, w) {
      var data = snap.searchedNotes;
      return data.isNotEmpty
          ? ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (c, index) {
                return view
                    .notesItemView(data[index], view.getRandomColor(), index,
                        onDismissed: (d) {
                  setState(() {
                    NotesController().deleteNote(data[index].id ?? 0);
                    data.removeAt(index);
                  });
                });
              },
              separatorBuilder: (c, index) {
                return 5.height;
              },
              itemCount: data.length)
          : view.noNotesView(item: "assets/images/not_found.png",title: "Not found item!").center();
    });
  }
}
