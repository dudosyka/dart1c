import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

class MultipleDropDownWidget extends StatefulWidget {
  final List<dynamic> values;
  final Function onChanged;

  const MultipleDropDownWidget({Key? key, required this.values, required this.onChanged}) : super(key: key);

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
  State<StatefulWidget> createState() => _MultipleDropDownWidgetState(values, valuesAsValueModelList(), onChanged);

}

class _MultipleDropDownWidgetState extends State<MultipleDropDownWidget> {
  List<DropDownValueModel> valueModelList;
  List<dynamic> values;
  Function onChanged;

  late MultiValueDropDownController _cnt;

  _MultipleDropDownWidgetState(this.values, this.valueModelList, this.onChanged);

  void initState() {
    _cnt = MultiValueDropDownController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropDownTextField.multiSelection(
      dropDownList: valueModelList,
      multiController: _cnt,
      onChanged: (val) {
        onChanged(val);
      },
    );
  }
}