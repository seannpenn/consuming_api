import 'package:consume_api/service/note_service.dart';
import 'package:consume_api/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NoteDelete extends StatefulWidget {
  String noteID;
  NoteDelete({Key? key, required this.noteID}) : super(key: key);

  @override
  State<NoteDelete> createState() => _NoteDeleteState();
}

class _NoteDeleteState extends State<NoteDelete> {
  final NoteService service = locator<NoteService>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Warning'),
      content: const Text('Are you sure you want to delete this note?'),
      actions: <Widget>[
        TextButton(
          child: const Text('Yes'),
          onPressed: () {
            deleteNote(widget.noteID);
          },
        ),
        TextButton(
          child: const Text('No'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }

  deleteNote(String id) async {
    final result = await service.deleteNote(id);
    final errorCreate =
        result.error ? result.errorMessage : 'Note successfully deleted.';
    Navigator.of(context).pop(true);
    // successDelete(errorCreate, result);
  }

  // successDelete(String message, result) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //             title: const Text('Done'),
  //             content: Text(message),
  //             actions: <Widget>[
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const Text('OK'),
  //               ),
  //             ]);
  //       }).then((data) {
  //     if (result) {
  //       Navigator.of(context).pop();
  //     }
  //   });
  // }
}
