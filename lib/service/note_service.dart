import 'package:consume_api/models/api_response.dart';
import 'package:consume_api/models/note_for_listing.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NoteService {
  static const api = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app/notes';
  static const headers = {"apiKey": '9d641f4a-f1f9-46c0-98db-6c632127d114'};

  Future<ApiResponse<List<NoteForListing>>> getNotesList() async {
    final notes = <NoteForListing>[];
    final response = await http.get(Uri.parse(api), headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        
        for (var item in jsonResponse) {
          final note = NoteForListing(
              noteID: item['noteID'],
              noteTitle: item['noteTitle'],
              createDateTime: DateTime.parse(item['createDateTime']),
              latestEditDateTime: item['latestEditDateTime'] ?? DateTime.parse(item['createDateTime']));
              // print(note);
          notes.add(note);
        }
        return ApiResponse<List<NoteForListing>>(data: notes);
      }
      return ApiResponse<List<NoteForListing>>(data: notes, error: true, errorMessage: 'An error occured');
  }
  // Future <ApiResponse> deleteNote(id){

  // }
}
