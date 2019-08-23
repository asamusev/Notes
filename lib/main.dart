import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class Notes {
String text;
String title;
String index;
int id;
Notes({this.text = '', this.title = '', this.index, this.id = -1});
}

List <Notes> allNotes = [
  
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NoteList()
    );
  }
}

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:allNotes.length == 0?Center(child: Text("Notes Empety", style: TextStyle(fontSize: 60),),) : ListView.builder(
        itemCount: allNotes.length,
        itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(allNotes[index].title),
            leading: (Icon(Icons.add_box)),
            onTap: (){
            Navigator.push(
              context, MaterialPageRoute(
                builder: (BuildContext context)=> NotePage(note: allNotes[index])
                )
                );
              },
          );
        }
    ),
    floatingActionButton: FloatingActionButton(
        child: Icon(Icons.note_add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NotePage(
                        note: Notes(),
                      ))).then((note){
                        setState(() {
                          allNotes.add(note);
                        });
                      });
        }
      )
   );
}
}




class NotePage extends StatefulWidget {
  Notes note;
  NotePage({this.note});
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  TextEditingController title;
  TextEditingController  note;

@override
  void initState() {
    title = TextEditingController(text: widget.note.title);
    note = TextEditingController(text: widget.note.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Title',prefixIcon: Icon(Icons.title)),
              controller: title,
          ),
           TextField(
            decoration: InputDecoration(labelText: 'Note',prefixIcon: Icon(Icons.note)),
              controller: note,
          ),
        FlatButton(child: Text('Save',style: TextStyle(fontSize: 30,backgroundColor: Colors.blue)), onPressed: () {
        int id = widget.note.id;
        print(id);
          if (id == -1) {
            allNotes.add(
        Notes(title: title.text, text: note.text, id: allNotes.length));
          } else {
           setState(() {
           allNotes.removeAt(id);
           allNotes.insert(id, Notes(
             title: title.text,
             text: note.text,
             id: id));  
           });
          }
           Navigator.pop(context, NoteList() );
          }
        ),
        
        FlatButton(child: Icon(Icons.delete), onPressed: () {
          setState(() {
          int id = widget.note.id;
          if (id == id) {
          allNotes.removeAt(id);
          }
          });
          Navigator.pop(context, NoteList() );
        },)
        ]
        )
        );
    }
  }