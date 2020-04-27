import 'package:flutter/material.dart';

class DefaultDropDownButton extends StatefulWidget {
  final String hintText;
  final List<String> items;
  const DefaultDropDownButton({
    Key key,
    this.hintText,
    this.items,
  }) : super(key: key);

  @override
  _DefaultDropDownButtonState createState() => _DefaultDropDownButtonState();
}

class _DefaultDropDownButtonState extends State<DefaultDropDownButton> {
  String dropdownValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
        decoration: ShapeDecoration(
          shape: OutlineInputBorder(),
        ),
        child: DropdownButton<String>(
          value: dropdownValue,
          isExpanded: true,
          elevation: 16,
          hint: Text(widget.hintText),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
