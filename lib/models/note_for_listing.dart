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
      DateTime? createDateTime,
      DateTime? latestEditDateTime}): createDateTime = createDateTime ?? DateTime.now(), latestEditDateTime = latestEditDateTime?? DateTime.now();

  factory NoteForListing.fromJson(Map<String, dynamic> item) {
    return NoteForListing(
        noteID: item['noteID'],
        noteTitle: item['noteTitle'],
        noteContent: item['noteContent']?? '',
        createDateTime: DateTime.parse(item['createDateTime']),
        latestEditDateTime: DateTime.parse(item['createDateTime']));
  }

  Map<String, dynamic> toJson(){
    return{
      "noteTitle": noteTitle,
      "noteContent": noteContent,
    };
  }
}
