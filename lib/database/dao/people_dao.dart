import 'package:first_block_app/models/people.dart';

import 'generic_dao.dart';

class ConstPeopleDao {
  static const String tableName = 'contacts';
  static const String id = 'id';
  static const String name = 'name';

  static const tableSQL = 'CREATE TABLE $tableName('
      '$id INTEGER PRIMARY KEY, '
      '$name TEXT'
      ' ) ';
}

class PeopleDao extends GenericDao {
  PeopleDao()
      : super(ConstPeopleDao.tableSQL, ConstPeopleDao.tableName,
            ConstPeopleDao.id);

  Future<int> saveModel(People model) async {
    var modelMap = _toMap(model);
    return await super.save(model.id, modelMap);
  }

  Future<List<People>> findRegisters() async {
    var registers = await super.findAll();
    return _toList(registers);
  }

  Map<String, dynamic> _toMap(People people) {
    final Map<String, dynamic> peopleMap = {};
    peopleMap[ConstPeopleDao.name] = people.name;
    return peopleMap;
  }

  List<People> _toList(List<Map<String, dynamic>> result) {
    final List<People> model = [];
    for (Map<String, dynamic> map in result) {
      final People contact = People(
        map[ConstPeopleDao.id],
        map[ConstPeopleDao.name],
      );
      model.add(contact);
    }
    return model;
  }
}
