import 'package:flutter/material.dart';
import 'package:bloco_de_notas/Model/nota.dart';

class OpenNote extends StatefulWidget {
  final Note note;
  OpenNote(this.note);
  @override
  _OpenNoteState createState() => _OpenNoteState(note);
}

class _OpenNoteState extends State<OpenNote> {
  Note note;
  _OpenNoteState(this.note);

  @override
  Widget build(BuildContext context) {
    

    final mediaQuery = MediaQuery.of(context);

    final availableHeight = mediaQuery.size.height;

    final availableWidth = mediaQuery.size.width;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF9DF6E6),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF9DF6E6),
        child: Icon(
          Icons.arrow_back,
          size: 36,
        ),
        heroTag: "back",
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(170)),
            child: Image.file(
              note.image,
              height: availableHeight / 1.5,
              width: availableWidth,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: TextStyle(
                    fontFamily: 'Caveat',
                    fontSize: 36,
                    color: Color(0xFFCFA9FF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  height: 16,
                ),
                SingleChildScrollView(
                  child: Text(
                    note.body,
                    style: TextStyle(
                      fontFamily: 'Caveat',
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
