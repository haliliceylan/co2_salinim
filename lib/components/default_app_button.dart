import 'package:flutter/material.dart';

class DefaultAppButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;
  const DefaultAppButton({
    Key key,
    this.onTap,
    this.text = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).buttonColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(blurRadius: 6, color: Colors.black38)
            ]
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(this.text, style: Theme.of(context).textTheme.button),
            ],
          )),
    );
  }
}
