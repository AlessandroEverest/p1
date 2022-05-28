import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:p1/models/contato.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;

  String contatoTable = 'contato';
  String colId = 'id';
  String colNome = 'nome';
  String colEmail = 'email';
  String colImagem = 'imagem';

  DatabaseHelper._createInstance();
  static Database _database;

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_databaseHelper == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'contatos.db';

    var contatosDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return contatosDatabase;
  }

  //criar  banco de dados
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $contatoTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$colNome TEXT, '
        '$colEmail TEXT, $colImagem TEXT)');
  }

  //Inserir contato do meu banco de dados
  Future<int> insertContato(Contato contato) async {
    Database db = await this.database;
    var resultado = await db.insert(contatoTable, contato.toMap());
    return resultado;
  }

  //Pesquisar o Contato do banco de dados
  Future<List<Contato>> getContato(int id) async {
    Database db = await this.database;

    var resultado = await this.database;

    List<Map> maps = await db.query(contatoTable,
        columns: [colId, colNome, colEmail, colImagem],
        where: "$colId = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return null;
    } else {
      return null;
    }
  }

  Future<List<Contato>> getContatos() async {
    Database db = await this.database;

    var resultado = await db.query(contatoTable);

    List<Contato> lista = resultado.isNotEmpty
        ? resultado.map((c) => Contato.fromMap(c)).toList()
        : [];
    return lista;
  }

  //atualizar objeto do banco de dados
  Future<int> updateContato(Contato contato) async {
    var db = await this.database;

    var resultado = await db.update(contatoTable, contato.toMap(),
        where: '$colId = ?', whereArgs: [contato.id]);
    return resultado;
  }

//Apagar objeto do banco de dados
  Future<int> deleteContato(int id) async {
    var db = await this.database;

    int resultado =
        await db.delete(contatoTable, where: "$colId = ?", whereArgs: [id]);

    return resultado;
  }

//Consulta o número de objetos contato
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $contatoTable');

    int resultado = Sqflite.firstIntValue(x);
    return resultado;
  }

  Future close() async {
    Database db = await this.database;
    db.close();
  }
}
