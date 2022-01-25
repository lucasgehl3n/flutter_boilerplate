import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'generic_dao.dart';

Future<Database> createDatabase<T>(Dao dao) async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'bytebank4.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(dao.tableSql);
  }, version: 1, onDowngrade: onDatabaseDowngradeDelete);
}
