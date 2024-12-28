import 'package:flutter/foundation.dart';
import '../models/note.dart';
import '../services/storage_service.dart';

class NotesProvider with ChangeNotifier {
  final StorageService _storage;
  List<Note> _notes = [];

  NotesProvider(this._storage) {
    _loadNotes();
  }

  List<Note> get notes => List.unmodifiable(_notes);

  Future<void> _loadNotes() async {
    _notes = await _storage.getNotes();
    notifyListeners();
  }

  Future<void> addNote(String title, String content) async {
    final note = Note(title: title, content: content);
    _notes.add(note);
    await _storage.saveNotes(_notes);
    notifyListeners();
  }

  Future<void> updateNote(String id, String title, String content) async {
    final index = _notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      _notes[index].title = title;
      _notes[index].content = content;
      _notes[index].modifiedAt = DateTime.now();
      await _storage.saveNotes(_notes);
      notifyListeners();
    }
  }

  Future<void> deleteNote(String id) async {
    _notes.removeWhere((note) => note.id == id);
    await _storage.saveNotes(_notes);
    notifyListeners();
  }
}