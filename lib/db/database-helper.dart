import 'dart:io';
import 'package:morse/models/mensagem.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
class DatabaseHelper {
  static final _databaseName = 'morse.db';
  static final _databaseVersion = 1;

  // make this a singleton class
  DatabaseHelper._createInstance();
  static final DatabaseHelper instance = DatabaseHelper._createInstance();
  static Database _database;

  _initDatabase() async {
    print('Initialized database for aplications');
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future _onCreate(Database db, int version) async {
    // Imovel Fotos table
    await db.execute('''
      Create Table mensagem(
        men_id INTEGER PRIMARY KEY AUTOINCREMENT,
        men_codigo INTEGER,
        men_from INTEGER,
        men_dest INTEGER,
        men_datacriacao TEXT,
        men_datalido TEXT,
        men_dataalterado TEXT,
        men_mensagem TEXT,
        men_enviado BOOLEAN
       ) ''');
  }

  Future<int> insertMensagem(FieldsMensagem fieldsMensagem) async {
    Database db = await instance.database;
    var mensagem = fieldsMensagem.toJson();
    var result = await db.insert('mensagem', mensagem);
    return result;
  }

  Future<List<FieldsMensagem>> getMensagemlist(int limit, int offset) async {
    Database db = await instance.database;
    List<FieldsMensagem> mensagemList = List();
    var imagen = await db.rawQuery(''' SELECT * FROM mensagem order by men_id desc limit ? OFFSET ? ''', [limit, offset]);
    for (Map res in imagen) {
      mensagemList.add(FieldsMensagem.fromJson(res));
    }
    return mensagemList;
  }

  // Future<List<FieldsMensagem>> getLastmessages() async {
  //   Database db = await instance.database;
  //   List<FieldsMensagem> mensagemList = List();
  //   var imagen = await db.rawQuery(''' SELECT * FROM mensagem order by men_id desc limit 1 ''');
  //   for (Map res in imagen) {
  //     mensagemList.add(FieldsMensagem.fromJson(res));
  //   }
  //   return mensagemList;
  // }

  Future<FieldsMensagem> getLastmessages() async {
    Database db = await instance.database;
    var result = await db.rawQuery(''' SELECT * FROM mensagem order by men_id desc limit 1 ''');
    if (result.length > 0) {
      return FieldsMensagem.fromJson(result.first);
    } else {
      FieldsMensagem fieldsMensagem = FieldsMensagem();
      return fieldsMensagem;
    }
  }

  Future<int> deleteallMensagem() async {
    Database db = await this.database;
    int result = await db
        .rawDelete('DELETE FROM mensagem');
    return result;
  }

  // Future<int> deletefotos() async {
  //   Database db = await this.database;
  //   int result = await db
  //       .rawDelete('DELETE FROM imovel_fotos');
  //   return result;
  // }

  // Future<int> updateEnviado(int imgId) async {
  //   print(imgId);
  //   Database db = await this.database;
  //   var result = await db.rawUpdate(
  //       '''update imovel_fotos set img_enviado = 1 where img_id = ? ''',[imgId]);
  //   return result;
  // }

  // Codigo da tabela imobiliaria insert
  // Future<int> insertImobiliariaPublicar(ImobiliariaPublicarFields imobiliariaPublicarFields) async {
  //   Database db = await instance.database;
  //   var imobiliariapub = imobiliariaPublicarFields.toJson();
  //   var result = await db.insert('imobiliarias_publicar', imobiliariapub);
  //   return result;
  // }
  // Future<int> deleteimobiliariaPublicar(int imob_codigo) async {
  //   Database db = await this.database;
  //   int result = await db
  //       .rawDelete('DELETE FROM imobiliarias_publicar where Imobiliaria = ?', [imob_codigo]);
  //   return result;
  // }

  // Future<List<ImobiliariaPublicarFields>> getImobiliariaPublicarist() async {
  //   Database db = await instance.database;
  //   List<ImobiliariaPublicarFields> imobiliariapublicarList = List();
  //   var imobiliariapub = await db.rawQuery(''' SELECT * FROM imobiliarias_publicar ''');

  //   for (Map res in imobiliariapub) {
  //     imobiliariapublicarList.add(ImobiliariaPublicarFields.fromJson(res));
  //   }
  //   return imobiliariapublicarList;
  // }
}