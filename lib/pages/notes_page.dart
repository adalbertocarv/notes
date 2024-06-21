import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/Components/drawer.dart';
import 'package:notes/Components/note_tile.dart';
import 'package:notes/models/note_database.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';

class NotesPage extends StatefulWidget {
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  // controlar de texto para acessar o que o usuario digita
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    readNotes();
  }

  // criar uma nota
  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: textController,
          ),
          actions: [
            // criar um botão
            MaterialButton(
              onPressed: () {
                // adicionar ao banco
                context.read<NoteDatabase>().addNote(textController.text);

                // limpar controlador
                textController.clear();

                // pop caixa de dialogo
                Navigator.pop(context);
              },
              child: const Text("Criar"),
            )
          ],
        ),
    );
  }

  // ler notas
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }
  // upar uma nota
  void updateNote(Note note) {
    //pre-fill the current note text
    textController.text = note.text;
    showDialog(
      context: context,
      builder:(context) => AlertDialog(
        title: Text("Update Note"),
        content: TextField(controller: textController),
        actions: [
          // update button
          MaterialButton(onPressed: (){
            // update note in db
            context
                .read<NoteDatabase>()
                .updateNote(note.id, textController.text);
            //clear controller
            textController.clear();//pop dialog box
            Navigator.pop(context);
          },
            child: const Text("Atualizar"),
          )
        ],
      ),
    );
  }

  // deletar uma nota
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    // nota banco de dados
    final noteDatabase = context.watch<NoteDatabase>();

    // current notes
    List<Note> currentNotes = noteDatabase.currentNotes;
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.inversePrimary,),
      ),
      drawer: const Mydrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'Notes',
              style: GoogleFonts.dmSerifText(
              fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
            ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                // get individual note
                final note = currentNotes[index];
            
                // list tile UI
                return NoteTile(
                  text: note.text,
                  onEditPressed: () => updateNote(note),
                  onDeletePressed: () => deleteNote(note.id),
                );
              },
            ),
          ),
        ],
      ),
    );

  }
}