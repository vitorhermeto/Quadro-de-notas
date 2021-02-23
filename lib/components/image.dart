import 'package:flutter/material.dart';
import 'dart:io';
import 'anotacao.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bloco_de_notas/Model/nota.dart';

class ImagePage extends StatefulWidget {
  Function addNote;
  List<Note> notes;
  ImagePage(this.notes, this.addNote);
  @override
  _ImagePageState createState() => _ImagePageState(notes, addNote);
}

class _ImagePageState extends State<ImagePage> {
  Function addNote;
  List<Note> notes;
  _ImagePageState(this.notes, this.addNote);

  showAlertDialog1(
    BuildContext context,
    String labelTitulo,
    String labelMensagem,
  ) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(
            fontFamily: 'Caveat', color: Color(0xFF9DF6E6), fontSize: 20),
      ),
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

  File image;

  final picker = ImagePicker();

  void pegarImagemGaleria() async {
    final tempImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      image = File(tempImage.path);
    });
  }

  void pegarImagemCamera() async {
    final tempImage = await picker.getImage(source: ImageSource.camera);

    setState(() {
      image = File(tempImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inserir Imagem',
          style: TextStyle(
              fontFamily: 'Caveat',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        backgroundColor: Color(0xFF9DF6E6),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Container(
                child: image == null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 160),
                        child: Center(
                          child: Text(
                            'Escolha uma Imagem!',
                            style: TextStyle(
                              fontFamily: 'Caveat',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.file(
                            image,
                          ),
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    backgroundColor: Color(0xFF9DF6E6),
                    onPressed: pegarImagemGaleria,
                    tooltip: 'Pegar imagem da galeria',
                    child: Icon(Icons.image),
                    heroTag: "galeria",
                  ),
                  FloatingActionButton(
                      backgroundColor: Color(0xFF9DF6E6),
                      onPressed: pegarImagemCamera,
                      tooltip: 'Pegar imagem da camera',
                      child: Icon(Icons.camera_alt),
                      heroTag: "camera"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48),
              child: FlatButton(
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
                  if (image != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotePage(image, notes, addNote),
                      ),
                    );
                  } else {
                    showAlertDialog1(
                      context,
                      "Erro",
                      "Insira uma imagem para continuar",
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
