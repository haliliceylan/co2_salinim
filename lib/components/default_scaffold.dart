import 'package:co2_salinim/components/default_back_button.dart';
import 'package:co2_salinim/components/default_bottom_app_navigaton_bar.dart';
import 'package:co2_salinim/components/default_floating_action_button.dart';
import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  final Widget child;
  final String title;
  final DefaultFloationActionButtonType buttonType;
  const DefaultScaffold({
    Key key,
    this.child,
    this.buttonType = DefaultFloationActionButtonType.Chart,
    this.title = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.title), leading: DefaultBackButton()),
      body: child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: DefaultFloationActionButton(type: buttonType),
      bottomNavigationBar: DefaultBottomAppNavigationBar(),
    );
  }
}