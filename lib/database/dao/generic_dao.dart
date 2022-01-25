import 'package:first_block_app/database/dao/app_database.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

abstract class Dao {
  Dao(this.tableSql, this.tableName, this.id);
  String tableSql = "";
  String tableName;
  String id;
}

class GenericDao extends Dao {
  GenericDao(tableSql, tableName, id) : super(tableSql, tableName, id);

  @protected
  Future<int> save<T>(int id, Map<String, dynamic> modelMap) async {
    final Database db = await createDatabase(this);

    if (id == 0) {
      return db.insert(super.tableName, modelMap);
    }

    var idString = super.id;
    return db.update(
      tableName,
      modelMap,
      where: '$idString = ?',
      whereArgs: [id],
    );
  }

  @protected
  Future<List<Map<String, dynamic>>> findAll() async {
    final Database db = await createDatabase(this);
    final List<Map<String, dynamic>> result = await db.query(tableName);
    return result;
  }
}
