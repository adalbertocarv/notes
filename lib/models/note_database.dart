import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:notes/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier{
  static late Isar isar;

  // I N I C I A L I Z A R  -  D A T A B A S E
  static Future<void> initialize() async {
    final dir = await getApplicationCacheDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  //lista das notas
  final List<Note> currentNotes = [];

  // C R I A R - uma nota e salvar no BD
  Future<void> addNote(String textFromUser) async {

    // criar uma nova nota objeto
    final newNote = Note()..text = textFromUser;

    // salvar para a base de dados
    await isar.writeTxn(
            () => isar.notes.put(newNote)
    );
    // reler da base de dados
    fetchNotes();
    notifyListeners(); // Trigger UI update after adding a new note
  }
  // L E R - notas do BD
  Future<void> fetchNotes() async {
    List<Note> fetchNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    notifyListeners();

  }
  //U P A R - uma nota do BD
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  // D E L E T A R - uma nota do BD
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}