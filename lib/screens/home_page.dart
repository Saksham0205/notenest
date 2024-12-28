import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';
import '../widgets/note_card.dart';
import 'note_editor.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) {
          final notes = notesProvider.notes;
          return notes.isEmpty
              ? Center(
            child: Text(
              'No notes yet\nTap + to create one',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return NoteCard(note: notes[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteEditor(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}