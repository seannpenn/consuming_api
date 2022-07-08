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
  final NoteService service = locator<NoteService>();
 NoteForListing? data;
  bool _isLoading = false;
  String errorMessage = '';
  final FocusNode _messageFN = FocusNode();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _contentController = TextEditingController();

  _fetchNote() async {
    await service.getNote(widget.noteID)
    .then((response){
          setState(() {
            _isLoading = false;
            data = response.data;
            _titleController.text = data!.noteTitle;
            _contentController.text = data!.noteContent;
          });

          if(response.error){
            errorMessage = response.errorMessage;
          }
          // print(data!.noteID);
        });
  }

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    _fetchNote();
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
        body: _isLoading? const Center(child: CircularProgressIndicator()) :Padding(
          padding: const EdgeInsets.all(8.0),
          child: AspectRatio(
            aspectRatio: 4 / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Text(data.noteID),
                Text(data!.noteContent),
                // Text(data!.noteID),
                TextFormField(
                  onFieldSubmitted: (String text) {},
                  focusNode: _messageFN,
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
                  focusNode: _messageFN,
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Submit'),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  
}
