import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<Map<String, dynamic>> _notesItems = [
    {
      'title': 'Project Kick-off',
      'user': 'Alice',
      'timestamp': DateTime.now().subtract(const Duration(days: 2, hours: 3)),
      'bulletPoints': [
        'Finalize project scope and deliverables.',
        'Assign roles and responsibilities to team members.',
        'Set up communication channels (Slack, etc.).',
      ],
    },
    {
      'title': 'Q3 Marketing Plan',
      'user': 'Bob',
      'timestamp': DateTime.now().subtract(const Duration(days: 1, hours: 5)),
      'bulletPoints': [
        'Review competitor analysis.',
        'Brainstorm campaign ideas.',
        'Allocate budget for social media ads.',
      ],
    },
  ];

  void _addNewNote() {
    setState(() {
      final now = DateTime.now();
      final newNote = {
        'title': 'New Note - ${DateFormat('dd MMM').format(now)}',
        'user': 'Current User',
        'timestamp': now,
        'bulletPoints': ['Add your first point here...'],
      };
      _notesItems.insert(0, newNote);
      _showEditNoteSheet(_notesItems.length - 1); 
    });
  }

  void _updateNote(int index, Map<String, dynamic> updatedNote) {
    setState(() {
      _notesItems[index] = updatedNote;
    });
  }

  void _deleteNote(int index) {
    setState(() {
      _notesItems.removeAt(index);
    });
  }

  void _showEditNoteSheet(int index) {
    final note = _notesItems[index];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: NoteEditSheet(
            note: note,
            onUpdateNote: (updatedNote) {
              _updateNote(index, updatedNote);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        titleTextStyle: TextStyle(
          color: Colors.grey[800],
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _notesItems.length,
        itemBuilder: (context, index) {
          final item = _notesItems[index];
          return _buildNoteCard(
            title: item['title'],
            user: item['user'],
            timestamp: item['timestamp'],
            bulletPoints: List<String>.from(item['bulletPoints']),
            onDelete: () => _deleteNote(index),
            onTap: () => _showEditNoteSheet(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNewNote,
        backgroundColor: const Color(0xFF00796B),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Note',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
      ),
    );
  }

  Widget _buildNoteCard({
    required String title,
    required String user,
    required DateTime timestamp,
    required List<String> bulletPoints,
    required VoidCallback onDelete,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                    onPressed: onDelete,
                    tooltip: 'Delete Note',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.person_outline, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    user,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.access_time, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat('dd MMM yyyy, hh:mm a').format(timestamp),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const Divider(height: 24),
              ...bulletPoints.map((point) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 5.0, right: 8.0),
                          child: Icon(Icons.circle,
                              size: 8, color: Color(0xFF00796B)),
                        ),
                        Expanded(
                          child: Text(
                            point,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class NoteEditSheet extends StatefulWidget {
  final Map<String, dynamic> note;
  final Function(Map<String, dynamic>) onUpdateNote;

  const NoteEditSheet({
    super.key,
    required this.note,
    required this.onUpdateNote,
  });

  @override
  State<NoteEditSheet> createState() => _NoteEditSheetState();
}

class _NoteEditSheetState extends State<NoteEditSheet> {
  late TextEditingController _titleController;
  late List<TextEditingController> _bulletPointControllers;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note['title']);
    _bulletPointControllers = (
      widget.note['bulletPoints'] as List<String>)
        .map((point) => TextEditingController(text: point))
        .toList();
  }

  void _addBulletPoint() {
    setState(() {
      _bulletPointControllers.add(TextEditingController());
    });
  }

  void _saveNote() {
    final updatedNote = {
      ...widget.note,
      'title': _titleController.text,
      'bulletPoints': _bulletPointControllers
          .map((controller) => controller.text)
          .where((text) => text.isNotEmpty)
          .toList(),
      'timestamp': DateTime.now(), // Update timestamp on edit
    };
    widget.onUpdateNote(updatedNote);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ..._bulletPointControllers.asMap().entries.map((entry) {
            int idx = entry.key;
            TextEditingController controller = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        labelText: 'Point ${idx + 1}',
                        border: const OutlineInputBorder(),
                      ),
                      maxLines: null, // Allow multiline input
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent),
                    onPressed: () {
                      setState(() {
                        _bulletPointControllers.removeAt(idx);
                      });
                    },
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.add, color: Color(0xFF00796B)),
                label: const Text('Add Point', style: TextStyle(color: Color(0xFF00796B))),
                onPressed: _addBulletPoint,
              ),
              ElevatedButton.icon(
                onPressed: _saveNote,
                icon: const Icon(Icons.save, color: Colors.white),
                label: const Text('Save', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00796B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
