import 'package:flutter/material.dart';
import 'package:flutter_interact/generated/i18n.dart';
import 'package:flutter_interact/ui/feed/screen.dart';

const kDrawerWidth = 320.0;
const kTabletBreakpoint = 720.0;
const kDesktopBeakpoint = 1200.0;

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: LayoutBuilder(
        builder: (_, dimens) {
          // if (dimens.maxWidth >= kDesktopBeakpoint) {
          //   return _buildDesktop(context);
          // }
          if (dimens.maxWidth >= kTabletBreakpoint) {
            return _buildTablet(context);
          }
          return _buildMobile(context);
        },
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Container();
  }

  Widget _buildTablet(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: kDrawerWidth,
            child: Drawer(
              child: ListView(
                children: <Widget>[
                  MenuTile(
                    index: 0,
                    icon: Icon(Icons.list),
                    title: I18n.of(context).postsTitle,
                    onTap: _changeTab,
                    selected: _currentIndex == 0,
                  ),
                  MenuTile(
                    index: 1,
                    icon: Icon(Icons.help),
                    title: I18n.of(context).qaTitle,
                    onTap: _changeTab,
                    selected: _currentIndex == 1,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _buildStack(),
          )
        ],
      ),
    );
  }

  Widget _buildStack() {
    return IndexedStack(
      index: _currentIndex,
      children: <Widget>[
        PostsScreen(),
        Scaffold(),
      ],
    );
  }

  void _changeTab(int val) {
    if (mounted) setState(() => _currentIndex = val);
  }

  Widget _buildMobile(BuildContext context) {
    return Scaffold(
      body: _buildStack(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _changeTab,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text(I18n.of(context).postsTitle),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            title: Text(I18n.of(context).qaTitle),
          ),
        ],
      ),
    );
  }
}

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
