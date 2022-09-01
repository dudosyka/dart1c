import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

class SingleDropDownWidget extends StatefulWidget {
  final List<String> values;
  final Function onChangedCallback;

  const SingleDropDownWidget({Key? key, required this.values, required this.onChangedCallback}) : super(key: key);

  List<DropDownValueModel> valuesAsValueModelList() {
    int i = 0;
    List<DropDownValueModel> values = [];
    for (var element in this.values) {
      values.add(DropDownValueModel(name: element, value: i));
      i+=1;
    }
    i = 0;
    return values;
  }

  @override
  State<StatefulWidget> createState() => _SingleDropDownWidgetState(values, valuesAsValueModelList(), onChangedCallback);

}

class _SingleDropDownWidgetState extends State<SingleDropDownWidget> {
  List<dynamic> values;
  List<DropDownValueModel> valueModelList;
  Function onChange;
  late SingleValueDropDownController _cnt;

  _SingleDropDownWidgetState(this.values, this.valueModelList, this.onChange);

  void initState() {
    _cnt = SingleValueDropDownController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      dropDownList: valueModelList,
      singleController: _cnt,
      onChanged: (val) {
        onChange(val);
      },
    );
  }
}