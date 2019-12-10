import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({
    Key key,
    @required this.index,
    @required this.title,
    @required this.icon,
    @required this.onTap,
    this.selected = false,
  }) : super(key: key);

  final int index;
  final String title;
  final Icon icon;
  final ValueChanged<int> onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      leading: icon,
      title: Text(title),
      onTap: () => onTap(index),
    );
  }
}
