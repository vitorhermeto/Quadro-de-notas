import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bloco_de_notas/Model/nota.dart';

class NotePage extends StatefulWidget {
  Function addNote;
  List<Note> notes;
  File image;

  NotePage(this.image, this.notes, this.addNote);

  @override
  _NotePageState createState() => _NotePageState(image, notes, addNote);
}

class _NotePageState extends State<NotePage> {
  Function addNote;
  String titulo;
  String anotacao;
  File image;
  List<Note> notes;
  _NotePageState(this.image, this.notes, this.addNote);

  showAlertDialog1(
    BuildContext context,
    String labelTitulo,
    String labelMensagem,
  ) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK", style: TextStyle(fontFamily: 'Caveat', color: Color(0xFF9DF6E6), fontSize: 20),),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text(
        labelTitulo,
        style: TextStyle(
          fontFamily: 'Caveat',
        ),
      ),
      content: Text(
        labelMensagem,
        style: TextStyle(
          fontFamily: 'Caveat',
        ),
      ),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final PreferredSizeWidget appBar = AppBar(
      title: Text(
        'Anotação',
        style: TextStyle(
            fontFamily: 'Caveat',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: Color(0xFF9DF6E6),
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final availableWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: appBar,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        overflow: Overflow.visible,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(170)),
            child: Image.file(
              image,
              height: 300,
              width: availableWidth,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        autocorrect: true,
                        maxLength: 11,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Titulo",
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        onChanged: (t) {
                          setState(() {
                            titulo = t;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        autocorrect: true,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Anotação",
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        onChanged: (t) {
                          setState(() {
                            anotacao = t;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 50,
              ),
              FlatButton(
                child: Container(
                  width: 234.39,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFF9DF6E6),
                  ),
                  child: Center(
                    child: Text(
                      'Prosseguir',
                      style: TextStyle(
                          fontFamily: 'Caveat',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                onPressed: () {
                  if (titulo != null &&
                      titulo != "" &&
                      anotacao != null &&
                      anotacao != "") {
                    addNote(image, titulo, anotacao);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else {
                    showAlertDialog1(
                      context,
                      "Erro",
                      "Preencha ambos os campos para continuar",
                    );
                  }
                },
              ),
              Spacer()
            ],
          ),
        ],
      ),
    );
  }
}
