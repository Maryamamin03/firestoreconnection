
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AllNotesScreen extends StatelessWidget {
  const AllNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final CollectionReference notesCollection =
    FirebaseFirestore.instance.collection('notes');

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: notesCollection.where('uid', isEqualTo: uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading notes'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final notes = snapshot.data!.docs;

          if (notes.isEmpty) {
            return const Center(child: Text('No notes yet'));
          }

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              final noteId = note.id;
              final data = note.data() as Map<String, dynamic>;

              final title = data.containsKey('title') ? data['title'] as String : 'Untitled';
              final desc = data.containsKey('desc') ? data['desc'] as String : '';

              return ListTile(
                title: Text(title),
                subtitle: Text(desc),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        _showEditDialog(context, notesCollection, noteId, title, desc);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await notesCollection.doc(noteId).delete();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Note deleted')),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addNote');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditDialog(BuildContext context, CollectionReference notesCollection, String docId, String currentTitle, String currentDesc) {
    final titleController = TextEditingController(text: currentTitle);
    final descController = TextEditingController(text: currentDesc);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () async {
              await notesCollection.doc(docId).update({
                'title': titleController.text,
                'desc': descController.text,
                'time': Timestamp.now(),
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Note updated')),
              );
            },
          ),
        ],
      ),
    );
  }
}
