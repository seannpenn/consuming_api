import 'package:consume_api/models/api_response.dart';
import 'package:consume_api/models/note_for_listing.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NoteService {
  static const api = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app/notes';
  static const headers = {
    "apiKey": '0a3ac4e6-fac1-44cc-bdae-6c68c08d9eec',
    'Content-Type': 'application/json'
  };

  Future<ApiResponse<List<NoteForListing>>> getNotesList() async {
    final notes = <NoteForListing>[];
    final response = await http.get(Uri.parse(api), headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);

      for (var item in jsonResponse) {
        notes.add(NoteForListing.fromJson(item));
      }
      return ApiResponse<List<NoteForListing>>(data: notes);
    }
    return ApiResponse<List<NoteForListing>>(
        data: notes, error: true, errorMessage: 'An error occured');
  }

  Future<ApiResponse<NoteForListing>> getNote(String id) async {
    final response = await http.get(Uri.parse('$api/$id'), headers: headers);
    final jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      return ApiResponse<NoteForListing>(
          data: NoteForListing.fromJson(jsonResponse));
    }
    return ApiResponse<NoteForListing>(
        data: NoteForListing.fromJson(jsonResponse),
        error: true,
        errorMessage: 'An error occured');
  }

  Future<ApiResponse<bool>> createNote(NoteForListing item) async {
    final response = await http.post(Uri.parse(api),
        headers: headers, body: convert.jsonEncode(item.toJson()));
    // final jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 201) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(
        data: true, error: true, errorMessage: 'An error occured');
  }

  Future<ApiResponse<bool>> updateNote(String id, NoteForListing item) async {
    final response = await http.put(Uri.parse('$api/$id'),
        headers: headers, body: convert.jsonEncode(item.toJson()));
    // final jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 204) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(
        data: true, error: true, errorMessage: 'An error occured');
  }
  Future<ApiResponse<bool>> deleteNote(String id) async {
    final response = await http.delete(Uri.parse('$api/$id'),
        headers: headers,);
    if (response.statusCode == 204) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(
        data: true, error: true, errorMessage: 'An error occured');
  }
}
