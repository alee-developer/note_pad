import 'package:flutter/material.dart';
import 'package:note_pad/controllers/notes_controller.dart';
import 'package:note_pad/models/notes_model.dart';

class NotesProvider with ChangeNotifier, NotesController {
  List<NotesModel> notes = <NotesModel>[];

  getLocalNotes() async {
    notes = await getAllNotes() ?? notes;
    notifyListeners();
  }

  updateLocalNotes(int index, NotesModel data) async {
    notes[index] = data;
    await updateNote(data);
    notifyListeners();
  }

  addLocalNotes(NotesModel data) async {
    notes.add(data);
    await addNewNote(data);
    notifyListeners();
  }

  deleteLocalNotes(NotesModel data) async {
    await deleteNote(data.id ?? 0);
    notes.remove(data);
    notifyListeners();
  }

  List<NotesModel> searchedNotes = <NotesModel>[];

  bool isSearching = false;
  checkSearching(bool searching){
    isSearching = searching;
    notifyListeners();
  }

  searchFromNotes(String searchText) {
    List<NotesModel> searching = <NotesModel>[];
    for (var i in notes) {
      if (i.title?.toLowerCase().contains(searchText.toLowerCase()) == true) {
        searching.add(i);
      }
    }
    searchedNotes = searching;
    notifyListeners();
  }
}
