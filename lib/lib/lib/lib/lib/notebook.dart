import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotebookPage extends StatefulWidget {
  @override
  State<NotebookPage> createState() => _NotebookPageState();
}

class _NotebookPageState extends State<NotebookPage> {
  int page = 1;
  final text = TextEditingController();

  void load() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('pages')
        .doc(page.toString())
        .get();

    text.text = doc.exists ? doc['content'] : '';
  }

  void save() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('pages')
        .doc(page.toString())
        .set({'content': text.text});
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page $page")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: TextField(
          controller: text,
          maxLines: null,
          decoration: const InputDecoration(border: InputBorder.none),
          onChanged: (_) => save(),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: page > 1
                ? () {
                    save();
                    setState(() => page--);
                    load();
                  }
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: page < 1500
                ? () {
                    save();
                    setState(() => page++);
                    load();
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
