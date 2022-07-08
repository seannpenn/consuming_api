class NoteForListing {
  String noteID;
  String noteTitle;
  String noteContent;
  DateTime createDateTime;
  DateTime latestEditDateTime;

  NoteForListing(
      {this.noteID = '',
      this.noteTitle = '',
      this.noteContent = '',
      required this.createDateTime,
      required this.latestEditDateTime});

  factory NoteForListing.fromJson(Map<String, dynamic> item) {
    return NoteForListing(
        noteID: item['noteID'],
        noteTitle: item['noteTitle'],
        noteContent: item['noteContent']?? '',
        createDateTime: DateTime.parse(item['createDateTime']),
        latestEditDateTime: DateTime.parse(item['createDateTime']));
  }
}
