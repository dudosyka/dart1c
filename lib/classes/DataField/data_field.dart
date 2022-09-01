import 'package:dart1c/classes/Database/database.dart';

enum DataFieldType {
  string,
  num,
  date,
  enumeration,
  document,
  directory,
  timestamp
}

class DataRelation {
  dynamic document;

  DataRelation({this.document = null});

  bool get isNull => document == null;

  String get name => document.name;
}

class DataField {
  final String name;
  final DataFieldType dataFieldType;
  final bool required;
  DataRelation linkTo;

  DataField({
    required this.name,
    required this.dataFieldType,
    required this.linkTo,
    this.required = false,
  });

  List<String> create(String parent) {
    String creation = "";
    String relations = "";
    switch (dataFieldType) {
      case DataFieldType.string:
        creation += "`$name` TEXT ${required ? "NOT NULL" : ""}";
        break;
      case DataFieldType.num:
        creation += "`$name` INT(11) ${required ? "NOT NULL" : ""}";
        break;
      case DataFieldType.date:
        creation += "`$name` DATE ${required ? "NOT NULL" : ""}";
        break;
      case DataFieldType.enumeration:
        creation += "`$name` INT(11) ${required ? "NOT NULL" : ""}";
        break;
      case DataFieldType.document:
        creation += "`$name` INT(11) ${required ? "NOT NULL" : ""}";
        break;
      case DataFieldType.directory:
        creation += "`$name` INT(11) ${required ? "NOT NULL" : ""}";
        break;
      case DataFieldType.timestamp:
        creation += "`$name` DATETIME NOT NULL";
        break;
    }

    Database database = Database();

    if (!linkTo.isNull) {
      relations +=
          "ADD FOREIGN KEY (`$name`) REFERENCES `document_${linkTo.name}`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;";
      database.query(
          "insert into `documents_structure` (`name`, `document`, `fieldType`, `relateTo`) values ('$name', '$parent', ${dataFieldType.index + 1}, '${linkTo.name}')");
    } else {
      database.query(
          "insert into `documents_structure` (`name`, `document`, `fieldType`, `relateTo`) values ('$name', '$parent', ${dataFieldType.index + 1}, null)");
    }

    return [creation, relations];
  }
}
