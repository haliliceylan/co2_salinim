import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String title;
  final String assetUrl;
  final String routeName;
  const DefaultButton({
    Key key,
    this.title = "",
    this.assetUrl,
    this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, this.routeName),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 25),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white, boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)]),
        child: Row(
          children: <Widget>[
            SizedBox(
              child: Image.asset(
                this.assetUrl,
                fit: BoxFit.fill,
              ),
              width: 50,
              height: 50,
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            Container(
              child: Icon(Icons.add, size: 25),
              padding: EdgeInsets.all(1),
            )
          ],
        ),
      ),
    );
  }
}
