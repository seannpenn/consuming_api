// import 'package:consume_api/models/note_for_listing.dart';

class ApiResponse <NoteForListing>{
  NoteForListing? data;
  bool error;
  String errorMessage;

  ApiResponse({
    this.data,
    this.error = false,
    this.errorMessage = ''
  });
}