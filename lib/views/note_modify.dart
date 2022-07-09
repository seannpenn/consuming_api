import 'package:consume_api/models/api_response.dart';
import 'package:consume_api/models/note_for_listing.dart';
import 'package:consume_api/service/note_service.dart';
import 'package:consume_api/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NoteModify extends StatefulWidget {
  final String noteID;

  const NoteModify({Key? key, this.noteID = '', NoteForListing? data})
      : super(key: key);

  @override
  State<NoteModify> createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteID != '';
  final NoteService service = locator<NoteService>();
  NoteForListing? data;
  bool _isLoading = false;
  String errorMessage = '';
  final FocusNode _titleFN = FocusNode();
  final FocusNode _contentFN = FocusNode();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _contentController = TextEditingController();

  _fetchNote() async {
    await service.getNote(widget.noteID).then((response) {
      setState(() {
        _isLoading = false;
        data = response.data;
        _titleController.text = data!.noteTitle;
        _contentController.text = data!.noteContent;
      });

      if (response.error) {
        errorMessage = response.errorMessage;
      }
      // print(data!.noteID);
    });
  }

  @override
  void initState() {
    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      _fetchNote();
    }
    // _titleController.text = data!.noteTitle;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.noteID.isEmpty
                ? 'Create note'
                : 'Edit note ${widget.noteID}')),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 4 / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        onFieldSubmitted: (String text) {},
                        focusNode: _titleFN,
                        controller: _titleController,
                        decoration: const InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            hintText: 'Note title'),
                      ),
                      TextFormField(
                        onFieldSubmitted: (String text) {},
                        focusNode: _contentFN,
                        controller: _contentController,
                        decoration: const InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            hintText: 'Note content'),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final updateNote = NoteForListing(
                                noteTitle:
                                    _titleController.text == data?.noteTitle
                                        ? data!.noteTitle
                                        : _titleController.text,
                                noteContent:
                                    _contentController.text == data?.noteContent
                                        ? data!.noteContent
                                        : _contentController.text);
                            final newNote = NoteForListing(
                                noteTitle: _titleController.text,
                                noteContent: _contentController.text);

                            if (isEditing) {
                              final updateResult = await service.updateNote(
                                  widget.noteID, updateNote);
                              final errorCreate = updateResult.error
                                  ? updateResult.errorMessage
                                  : 'Your note was updated.';
                              if (updateNote.noteTitle == data?.noteTitle &&
                                  updateNote.noteContent == data?.noteContent) {
                                print(updateResult.data);

                                dialogBox('Your note has no changes.',
                                    updateResult.data);
                              } else {
                                dialogBox(errorCreate, updateResult.data);
                              }
                            } else {
                              final result = await service.createNote(newNote);
                              print(result.data);
                              final errorCreate = result.error
                                  ? result.errorMessage
                                  : 'Your note was created.';

                              dialogBox(errorCreate, result.data);
                            }

                            //   Navigator.of(context).pop();
                          },
                          child: const Text('Submit'),
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }

  dialogBox(String message, result) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Done'),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ]);
        }).then((data) {
      if (result) {
        Navigator.of(context).pop();
      }
    });
  }
}
