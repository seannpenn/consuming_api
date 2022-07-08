import 'package:consume_api/models/api_response.dart';
import 'package:consume_api/models/note_for_listing.dart';
import 'package:consume_api/service/note_service.dart';
import 'package:consume_api/service_locators.dart';
import 'package:consume_api/views/note_delete.dart';
import 'package:consume_api/views/note_modify.dart';
import 'package:flutter/material.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final NoteService service = locator<NoteService>();
  List<NoteForListing> notes = [];
  ApiResponse<List<NoteForListing>> ?_apiResponse;
  bool _isLoading = false;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.month}/${dateTime.month}/${dateTime.year}';
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getNotesList();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('List of notes')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const NoteModify(),
            )).then((value){
              _fetchNotes();
            });
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (_isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // if (_apiResponse!.error) {
            //   return Center(child: Text(_apiResponse!.errorMessage));
            // }

            return ListView.separated(
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
                        context: context, builder: (context) => const NoteDelete());
                    print(result);
                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.only(left: 16),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      _apiResponse!.data![index].noteTitle,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Text(formatDateTime(
                        _apiResponse!.data![index].createDateTime)),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NoteModify(
                            noteID: _apiResponse!.data![index].noteID),
                      ));
                    },
                  ),
                );
              },
              itemCount: _apiResponse!.data!.length,
            );
          },
        ));
  }
}