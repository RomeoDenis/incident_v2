import 'dart:async';
import 'dart:io';

import 'package:objectdb/objectdb.dart';
import 'package:path_provider/path_provider.dart' as path;

class InitWelcome {
// declare db object
  ObjectDB db;
  static InitWelcome _formDb;
  static ObjectDB _database;
  InitWelcome._createInstance();
  factory InitWelcome() {
    if (_formDb == null) {
      _formDb = InitWelcome._createInstance();
    }
    return _formDb;
  }
  Future<ObjectDB> get database async {
    if (_database == null) {
      _database = await inititalizeDatabase();
    }
    return _database;
  }

  Future<ObjectDB> inititalizeDatabase() async {
    // get document directory using path_provider plugin
    Directory appDocDir = await path.getApplicationDocumentsDirectory();

    String dbFilePath = [appDocDir.path, 'init.db'].join('/');

    // delete old database file if exists
    // File dbFile = File(dbFilePath);

    // // check if database already exists
    // var isNew = !await dbFile.exists();
    // if (!isNew) dbFile.deleteSync();
    // //initialize and open database
    db = ObjectDB(dbFilePath);
    return await db.open();
  }

// fetch init
  Future checkdata() async {
    ObjectDB dbs = await this.database;
    var result = await dbs.find({});
    return result;
  }

// store form
  Future<ObjectId> storeForm(doc) async {
    ObjectDB db = await this.database;

    var result = await db.insert(doc);
    return result;
  }
}
