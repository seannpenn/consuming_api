import 'package:consume_api/service/note_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocators() {
  locator.registerSingleton<NoteService>(NoteService());
  // locator.registerSingleton<AuthController>(AuthController());
}