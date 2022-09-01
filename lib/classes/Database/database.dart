import 'package:mysql1/mysql1.dart';

class Database {
  final ConnectionSettings settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'dudosyka',
    password: '123',
    db: 'dart1c_database',
  );

  Future<dynamic> get _connection async {
    return await MySqlConnection.connect(settings);
  }

  Future<dynamic> query(query) async {
    print(query);
    return await (await _connection).query(query);
  }

  void createDocumentTable(name, fields, relations) async {
    String queryString =
        'CREATE TABLE `dart1c_database`.`document_$name` (`id` INT(11) NOT NULL AUTO_INCREMENT, $fields , PRIMARY KEY (`id`)) ENGINE = InnoDB;';
    await query(queryString);
    query("ALTER TABLE `document_$name` $relations");
  }

  Future<dynamic> getDocumentStructure(String name) {
    return query(
        'select * from `documents_structure` where `document` = "$name"');
  }

  Future<List<String>> getDropdownByDocument(String name) async {
    dynamic data = await query('select `title` from `document_$name`');
    List<String> res = [];

    for (var item in data) {
      res.add(item['title']);
    }

    return res;
  }
}
