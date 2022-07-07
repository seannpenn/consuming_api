import 'package:consume_api/models/note_for_listing.dart';
import 'package:consume_api/views/note_delete.dart';
import 'package:consume_api/views/note_modify.dart';
import 'package:flutter/material.dart';

class NoteList extends StatelessWidget {
  NoteList({Key? key}) : super(key: key);

  final notes = [
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

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.month}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('List of notes')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NoteModify(),
            ));
          },
          child: const Icon(Icons.add),
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            height: 3,
            color: Colors.black,
            thickness: 1,
          ),
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {},
              confirmDismiss: (direction) async {
                final result = await showDialog(
                    context: context, builder: (context) => NoteDelete());
                print(result);
                return result;
              },
              background: Container(
              color: Colors.red,
              padding: const EdgeInsets.only(left: 16),
              child: const Align(alignment: Alignment.centerLeft,child: Icon(Icons.delete, color: Colors.white),),
            ),
              child: ListTile(
                title: Text(
                  notes[index].noteTitle,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                subtitle: Text(formatDateTime(notes[index].createDateTime)),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        NoteModify(noteID: notes[index].noteID),
                  ));
                },
              ),
            );
          },
          itemCount: notes.length,
        ));
  }
}
