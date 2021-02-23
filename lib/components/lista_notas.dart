import 'package:bloco_de_notas/Model/nota.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:bloco_de_notas/components/open_note.dart';

class ListNote extends StatefulWidget {
  List<Note> notes;

  ListNote(this.notes);
  @override
  _ListNoteState createState() => _ListNoteState(notes);
}

class _ListNoteState extends State<ListNote> {
  List<Note> notes;
  _ListNoteState(this.notes);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final availableHeight = mediaQuery.size.height;

    final availableWidth = mediaQuery.size.width;

    _removeNotes(String id) {
      setState(() {
        notes.removeWhere((tr) => tr.id == id);
      });
    }

    showAlertDialog1(
      BuildContext context,
      String labelTitulo,
      String labelMensagem,
      int index,
    ) {
      // configura o button
      Widget okButton = FlatButton(
        child: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {
          _removeNotes(notes[index].id);
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

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: GridView.builder(
          padding: EdgeInsets.only(left: 32, right: 32),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 32, mainAxisSpacing: 32),
          itemCount: notes.length,
          itemBuilder: (ctx, index) {
            return GestureDetector(
                child: OpenContainer(
                  transitionDuration: Duration(milliseconds: 700),
                  closedElevation: 10,
                  closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  closedBuilder: (context, _) => Column(
                    children: [
                      Container(
                        alignment: AlignmentDirectional.topCenter,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              topLeft: Radius.circular(12)),
                          child: Image.file(
                            notes[index].image,
                            width: 300,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Spacer(),
                      Center(
                        child: Text(
                          notes[index].title,
                          style: TextStyle(
                            fontFamily: 'Caveat',
                            color: Color(0xFFCFA9FF),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  openBuilder: (context, _) => OpenNote(
                    notes[index],
                  ),
                ),
                onLongPress: () {
                  showAlertDialog1(
                    context,
                    'Excluir',
                    'Tem certeza que deseja excluir o item?',
                    index,
                  );
                });
          }),
    );
  }
}
