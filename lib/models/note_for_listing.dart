class NoteForListing {
  String noteID;
  String noteTitle;
  String noteContent;
  late DateTime createDateTime;
  late DateTime latestEditDateTime;

  NoteForListing(
      {this.noteID = '',
      this.noteTitle = '',
      this.noteContent = '',
      DateTime? createDateTime,
      DateTime? latestEditDateTime}) {
    createDateTime == null
        ? this.createDateTime = DateTime.now()
        : this.createDateTime = createDateTime;
    latestEditDateTime == null
        ? this.latestEditDateTime = DateTime.now()
        : this.latestEditDateTime = latestEditDateTime;
  }

  factory NoteForListing.fromJson(Map<String, dynamic> item) {
    return NoteForListing(
        noteID: item['noteID'],
        noteTitle: item['noteTitle'],
        noteContent: item['noteContent'] ?? '',
        createDateTime: item["createDateTime"] == null
            ? null
            : DateTime.parse(item['createDateTime']),
        latestEditDateTime: item["latestEditDateTime"] == null
            ? null
            : DateTime.parse(item['latestEditDateTime']));
  }

  Map<String, dynamic> get json => {
        'noteID': noteID,
        'noteTitle': noteTitle,
        'noteContent': noteContent,
        'createDateTime': createDateTime.toString(),
        'latestEditDateTime': latestEditDateTime.toString(),
      };

  Map<String, dynamic> toJson() {
    // return {
    //   "noteID": noteID,
    //   "noteTitle": noteTitle,
    //   "noteContent": noteContent,
    //   // "createDateTime": createDateTime ,
    //   // "latestEditDateTime": latestEditDateTime
    // };
    return json;
  }
}
