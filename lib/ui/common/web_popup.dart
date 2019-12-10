import 'package:flutter/material.dart';

class WebPopup extends StatelessWidget {
  final Widget child;

  const WebPopup({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, dimens) {
        if (dimens.maxHeight > 600 && dimens.maxWidth > 600) {
          return AlertDialog(
            content: SizedBox(
              width: 500.0,
              height: 500.0,
              child: Center(child: child),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(child: child),
        );
      },
    );
  }
}
