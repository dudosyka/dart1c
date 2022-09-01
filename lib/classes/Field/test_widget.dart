import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  final String value;
  final Function onChangedCallback;

  const TextWidget({super.key, required this.value, required this.onChangedCallback});

  @override
  State<StatefulWidget> createState() => _TextWidgetState(value, onChangedCallback);
}

class _TextWidgetState extends State<TextWidget> {
  String value;
  Function onChange;

  late TextEditingController _cnt;

  _TextWidgetState(this.value, this.onChange);

  @override
  void initState() {
    super.initState();
    _cnt = TextEditingController();
  }

  @override
  void dispose() {
    _cnt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _cnt,
      onChanged: (String value) {
        onChange(value);
      },
    );
  }

}