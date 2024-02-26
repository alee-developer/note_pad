import 'package:flutter/material.dart';
import 'package:note_pad/controllers/notes_controller.dart';
import 'package:note_pad/controllers/notes_provider.dart';
import 'package:note_pad/models/notes_model.dart';
import 'package:note_pad/views/screens/notes/notes_widgets.dart';
import 'package:note_pad/views/utils/extensions/context_extensions.dart';
import 'package:note_pad/views/utils/extensions/date_extensions.dart';
import 'package:note_pad/views/utils/extensions/text_style_extensions.dart';
import 'package:note_pad/views/utils/extensions/widget_extensions.dart';
import 'package:provider/provider.dart';

class NotesDetailsScreen extends StatefulWidget {
  final NotesModel notesModel;
  final int index;

  const NotesDetailsScreen({super.key, required this.notesModel, required this.index});

  @override
  State<NotesDetailsScreen> createState() => _NotesDetailsScreenState();
}

class _NotesDetailsScreenState extends State<NotesDetailsScreen> {
  bool onlyRead = false;
  bool enabled = true;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String hasChanged = "";

  @override
  void initState() {
    super.initState();
    titleController =
        TextEditingController(text: widget.notesModel.title ?? "");
    descController =
        TextEditingController(text: widget.notesModel.description ?? "");
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    var view = NotesWidgets(context: context);
    return Scaffold(
      appBar: view.notesAbbBarView(
          onBackPressed: () {
            if (hasChanged != "") {
              showChangeDialog();
            } else {
              context.onBackPressed;
            }
          },
          onPressed: () {
            setState(() {
              onlyRead = !onlyRead;
              enabled = !enabled;
            });
          },
          onlyRead: onlyRead),
      body: ListView(
        children: [
          view.textFieldView(titleController, "Title",
              isTitle: true, enabled: enabled, onChanged: (text) {
                hasChanged = text;
              }),
          view.textFieldView(descController, "Type something...",
              enabled: enabled, onChanged: (text) {
                hasChanged = text;
              })
        ],
      ).paddingSymmetric(horizontal: 10),
    );
  }

  showChangeDialog() {
    showDialog(
        barrierDismissible: false,
        context: context, builder: (c,) {
      return AlertDialog(
        content: const Text("Do you want to discard the changes?"),
        actions: [
          ElevatedButton(
              style: _buttonBack(Colors.red),
              onPressed: () {
                context.onBackPressed;
              },
              child: Text("Discard", style: const TextStyle().whiteTextStyle,)),
          ElevatedButton(
              style: _buttonBack(Colors.green),
              onPressed: () {
                var date = DateTime
                    .now()
                    .fullDateAndTime;
                var newData = NotesModel(
                    title: titleController.text,
                    description: descController.text,
                    createdAt: date,
                    updatedAt: date);
                var updateData = NotesModel(
                    id: widget.notesModel.id,
                    title: titleController.text,
                    description: descController.text,
                    createdAt: widget.notesModel.createdAt,
                    updatedAt: date);
                if (widget.notesModel.title != null ||
                    widget.notesModel.description != null) {
                  // NotesController().updateNote(updateData);
                  Provider.of<NotesProvider>(context, listen: false)
                      .updateLocalNotes(widget.index,updateData);
                  context.onBackPressed;
                  context.onBackPressed;
                } else {
                  NotesController().addNewNote(newData);
                  Provider.of<NotesProvider>(context, listen: false)
                      .addLocalNotes(newData);
                  context.onBackPressed;
                  context.onBackPressed;
                }
              }, child: Text("Save", style: const TextStyle().whiteTextStyle)),
        ],
      );
    });
  }

  _buttonBack(Color bgColor) {
    return ElevatedButton.styleFrom(backgroundColor: bgColor);
  }
}
