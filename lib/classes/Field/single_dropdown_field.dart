import 'package:dart1c/classes/Field/field.dart';
import 'package:dart1c/classes/Field/single_dropdown_widget.dart';
import 'package:flutter/src/widgets/framework.dart';

class SingleDropdownField implements Field<List<String>> {
  @override
  String name;
  
  @override
  FieldType fieldType;

  @override
  List<String> value;

  SingleDropdownField(this.name, this.value, this.fieldType);

  @override
  Widget render() {
    return SingleDropDownWidget(values: value, onChangedCallback: onChanged,);
  }

  @override
  void onChanged(val) {
    print(val.toString());
  }
  
}