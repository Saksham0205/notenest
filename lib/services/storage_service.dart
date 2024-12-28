import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';

class StorageService {
  static const String _key = 'notes';
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  Future<List<Note>> getNotes() async {
    final String? notesJson = _prefs.getString(_key);
    if (notesJson == null) return [];

    final List<dynamic> notesList = json.decode(notesJson);
    return notesList.map((json) => Note.fromJson(json)).toList();
  }

  Future<void> saveNotes(List<Note> notes) async {
    final String notesJson = json.encode(
      notes.map((note) => note.toJson()).toList(),
    );
    await _prefs.setString(_key, notesJson);
  }
}