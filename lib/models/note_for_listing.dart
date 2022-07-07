class NoteForListing{
  String noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime latestEditDateTime;

  NoteForListing({
    this.noteID = '',
    this.noteTitle = '',
    required this.createDateTime,
    required this.latestEditDateTime
  });
}