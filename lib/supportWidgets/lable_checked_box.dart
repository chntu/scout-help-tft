import 'package:facecheck_tft/constants.dart';
import 'package:flutter/material.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    this.label,
    this.value,
    this.onChanged,
  });

  final String label;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Checkbox(
            value: value,
            onChanged: (bool newValue) {
              onChanged(newValue);
            },
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: kFontSize,
            ),
          ),
        ],
      ),
    );
  }
}
