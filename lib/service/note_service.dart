import 'package:consume_api/models/note_for_listing.dart';

class NoteService{
  List<NoteForListing> getNotesList(){
    return [
      NoteForListing(
        noteID: "1",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitle: "Note 1"),
    NoteForListing(
        noteID: "2",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitle: "Note 2"),
    NoteForListing(
        noteID: "3",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitle: "Note 3"),
    NoteForListing(
        noteID: "3",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitle: "Note 3"),
    NoteForListing(
        noteID: "3",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitle: "Note 3"),
    NoteForListing(
        noteID: "3",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitle: "Note 3")
    ];
  }
}