import 'package:dart1c/classes/DataField/data_field.dart';
import 'package:dart1c/classes/Database/database.dart';
import 'package:dart1c/classes/Field/field.dart';
import 'package:dart1c/classes/Field/single_dropdown_field.dart';
import 'package:dart1c/classes/Field/text_field.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';

class Document {
  String name = "";
  List<Field> fields = [];

  static Future<Document> factory(String name) async {
    Database database = Database();
    Document entity = Document();
    entity.name = name;
    dynamic structure = await database.getDocumentStructure(name);
    for (var field in structure) {
      switch (FieldType.values[field['fieldType'] - 1]) {
        case FieldType.textField:
          entity.fields.add(TextField(field['name'], "", FieldType.textField));
          break;
        case FieldType.numField:
          entity.fields.add(TextField(field['name'], "", FieldType.textField));
          break;
        case FieldType.dateField:
          entity.fields.add(TextField(field['name'], "", FieldType.textField));
          break;
        case FieldType.enumerationField:
          entity.fields.add(TextField(field['name'], "", FieldType.textField));
          break;
        case FieldType.documentField:
          entity.fields.add(SingleDropdownField(
            field['name'],
            await database.getDropdownByDocument(field['relateTo']),
            FieldType.documentField,
          ));
          break;
        case FieldType.directoryField:
          entity.fields.add(TextField(field['name'], "", FieldType.textField));
          break;
        case FieldType.dateTimeField:
          entity.fields.add(TextField(field['name'], "", FieldType.textField));
          break;
        case FieldType.dropdown:
          // TODO: Handle this case.
          break;
      }
    }
    return entity;
  }

  static Future<Document> createDocument(
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
