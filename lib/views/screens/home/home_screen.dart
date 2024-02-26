import 'package:flutter/material.dart';
import 'package:note_pad/controllers/notes_controller.dart';
import 'package:note_pad/controllers/notes_provider.dart';
import 'package:note_pad/models/notes_model.dart';
import 'package:note_pad/views/screens/home/home_widgets.dart';
import 'package:note_pad/views/screens/notes/notes_details_screen.dart';
import 'package:note_pad/views/utils/extensions/int_extensions.dart';
import 'package:note_pad/views/utils/extensions/widget_extensions.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    if(!mounted) return;
    Provider.of<NotesProvider>(context,listen: false).getLocalNotes();
  }

  @override
  Widget build(BuildContext context) {
    var view = HomeWidgets(context: context);
    return Scaffold(
      floatingActionButton: view.floatingButtonView(onPressed: () {
        NotesDetailsScreen(
          index: 0,
          notesModel: NotesModel(),
        ).pushWithWidget(context: context);
      }),
      appBar: view.homeAppBarView(),
      body: Consumer<NotesProvider>(
          builder: (c, snap,w) {
            var data = snap.notes;
            return data.isNotEmpty
                ? ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemBuilder: (c, index) {
                      return view.notesItemView(
                          data[index], view.getRandomColor(), index,onDismissed: (d) {
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
          }),
    );
  }
}
