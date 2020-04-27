import 'package:flutter/material.dart';

class DefaultBottomAppNavigationBar extends StatelessWidget {
  const DefaultBottomAppNavigationBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Theme.of(context).primaryColor,
        child: Container(
          height: 40,
        ));
  }
}