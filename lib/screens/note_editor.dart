import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';
import '../models/note.dart';
import '../widgets/editor_text_filed.dart';

class NoteEditor extends StatefulWidget {
  final Note? note;

  const NoteEditor({super.key, this.note});

  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty && content.isEmpty) {
      Navigator.pop(context);
      return;
    }

    if (widget.note == null) {
      context.read<NotesProvider>().addNote(title, content);
    } else {
      context.read<NotesProvider>().updateNote(widget.note!.id, title, content);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
        actions: [
          if (widget.note != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<NotesProvider>().deleteNote(widget.note!.id);
                Navigator.pop(context);
              },
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            EditorTextField(
              controller: _titleController,
              hintText: 'Title',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: 20.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: EditorTextField(
                controller: _contentController,
                hintText: 'Start writing...',
                maxLines: null,
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveNote,
        child: const Icon(Icons.save),
      ),
    );
  }
}