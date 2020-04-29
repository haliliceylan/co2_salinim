import 'package:flutter/material.dart';

class DefaultFloationActionButton extends StatelessWidget {
  final DefaultFloationActionButtonType type;
  const DefaultFloationActionButton({
    Key key,
    this.type = DefaultFloationActionButtonType.Chart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      height: 77.0,
      width: 77.0,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () => type == DefaultFloationActionButtonType.Chart ? Navigator.popUntil(context, ModalRoute.withName('/')) : Navigator.pushNamed(context, '/ekle'),
          child: type == DefaultFloationActionButtonType.Chart ? Image.asset('assets/chart_button.png') : Icon(Icons.add),
          elevation: 0,
        ),
      ),
    );
  }
}

enum DefaultFloationActionButtonType { Chart, Add }
