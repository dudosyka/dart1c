import 'package:dart1c/classes/Field/field.dart';
import 'package:dart1c/classes/Field/multiple_dropdown_widget.dart';
import 'package:flutter/src/widgets/framework.dart';

class MultipleDropdownField implements Field<List> {
  @override
  String name;
  
  @override
  FieldType fieldType;

  @override
  List value;

  MultipleDropdownField(this.name, this.value, this.fieldType);
  
  @override
  Widget render() {
    return MultipleDropDownWidget(values: value, onChanged: onChanged,);
  }

  @override
  void onChanged(val) {
    print(val.toString());
  }

}