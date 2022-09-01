import 'package:flutter/cupertino.dart';

enum FieldType {
  textField,
  numField,
  dateField,
  enumerationField,
  documentField,
  directoryField,
  dateTimeField,
  dropdown,
}

abstract class Field<T> {
  late String name;
  late T value;
  late FieldType fieldType;

  Field(this.name, this.value, this.fieldType);

  Widget render();

  void onChanged(dynamic val);
}
