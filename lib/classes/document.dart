import 'package:dart1c/classes/DataField/data_field.dart';
import 'package:dart1c/classes/Database/database.dart';
import 'package:dart1c/classes/Field/field.dart';
import 'package:flutter/cupertino.dart';

class Document {
  String name = "";
  List<Field> fields = [];

  static Future<Document?> factory(String name) async {
    Database database = Database();
    Document entity = Document();
    entity.name = name;
    return entity;
  }

  static Future<Document?> createDocument(
    String name,
    List<DataField> fields,
  ) async {
    fields.add(DataField(
      name: 'createdAt',
      dataFieldType: DataFieldType.timestamp,
      linkTo: DataRelation(),
    ));
    fields.add(DataField(
      name: 'updatedAt',
      dataFieldType: DataFieldType.timestamp,
      linkTo: DataRelation(),
    ));
    Database database = Database();
    String creationQuery = "";
    String relationsQuery = "";
    for (var field in fields) {
      List<String> fieldQuery = field.create(name);
      creationQuery += "${fieldQuery[0]},";
      relationsQuery += fieldQuery[1];
    }
    creationQuery = creationQuery.substring(0, creationQuery.length - 1);
    database.createDocumentTable(name, creationQuery, relationsQuery);

    return Document.factory(name);
  }

  List<Widget> getChildren() {
    List<Widget> widgets = [];
    for (var field in fields) {
      widgets.add(field.render());
    }
    return widgets;
  }

  Widget renderForm() {
    return Form(
        child: Column(
      children: getChildren(),
    ));
  }
}
