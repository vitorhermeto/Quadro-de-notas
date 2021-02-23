import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'components/image.dart';
import 'package:bloco_de_notas/Model/nota.dart';

import 'components/lista_notas.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Note> notes = [];

  addNote(File image, String title, String note) {
    final newNote = Note(
      Random().nextDouble().toString(),
      image,
      title,
      note,
    );

    setState(() {
      notes.add(newNote);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final availableHeight = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: notes.isEmpty
          ? Container(
              height: availableHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage("assets/images/fundo.jpg"),
                ),
              ),
              child: Stack(
                overflow: Overflow.visible,
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    height: availableHeight / 2,
                    decoration: BoxDecoration(
                        color: Color(0xFF9DF6E6),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(200))),
                  ),
                  Positioned(
                      top: availableHeight / 9,
                      child: Text(
                        "Quadro de Notas",
                        style: TextStyle(
                          fontFamily: 'Caveat',
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Positioned(
                    top: availableHeight / 3.5,
                    child: Column(
                      children: [
                        Text(
                          'Clique no botão abaixo',
                          style: TextStyle(
                            fontFamily: 'Caveat',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'para inserir uma nova anotação',
                          style: TextStyle(
                            fontFamily: 'Caveat',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(
              height: availableHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage("assets/images/fundo.jpg"),
                ),
              ),
              child: Stack(
                overflow: Overflow.visible,
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    height: availableHeight / 2,
                    decoration: BoxDecoration(
                        color: Color(0xFF9DF6E6),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(200))),
                  ),
                  Positioned(
                      top: availableHeight / 9,
                      child: Text(
                        "Quadro de Notas",
                        style: TextStyle(
                          fontFamily: 'Caveat',
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 205),
                    child: ListNote(notes),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF9DF6E6),
        child: Icon(
          Icons.note_add,
          size: 36,
        ),
        heroTag: "Note",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImagePage(notes, addNote),
            ),
          );
        },
      ),
    );
  }
}
