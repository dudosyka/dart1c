import 'package:dart1c/classes/Field/field.dart';
import 'package:dart1c/classes/Field/test_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextField implements Field<String> {
  @override
  FieldType fieldType;

  @override
  String name;

  @override
  String value;

  TextField(this.name, this.value, this.fieldType);

  @override
  Widget render() {
    return Column(children: [
      Text(
        name,
        textAlign: TextAlign.left,
      ),
      TextWidget(value: value, onChangedCallback: onChanged),
    ]);
  }

  @override
  void onChanged(val) {
    print(val.toString());
  }
}
