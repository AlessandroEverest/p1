import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:Agenda1/Helpers/database_helper.dart';
import 'package:Agenda1/models/contato.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper db = DatabaseHelper();

  // ignore: deprecated_member_use
  List<Contato> contatos = List<Contato>();

  @override
  void initState() {
    super.initState();

    // Contato c = Contato(1, 'Alex', 'alexjesusbm@gmail.com', 'feio.jpg');
    // db.insertContato(c);
    // Contato c1 = Contato(2, 'Pio', 'pio@gmail.com', 'pio.jpg');
    // db.insertContato(c1);

    db.getContatos().then((lista) {
      print(lista);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agenda"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        actions: <Widget>[],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: 0,
        itemBuilder: (context, index) {},
      ),
    );
  }
}
