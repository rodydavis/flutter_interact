import 'package:flutter/material.dart';
import 'package:flutter_interact/generated/i18n.dart';
import 'package:flutter_interact/ui/feed/screen.dart';

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
          // if (dimens.maxWidth >= 1280) {
          //   return _buildDesktop(context);
          // }
          // if (dimens.maxWidth >= 720) {
          //   return _buildTablet(context);
          // }
          return _buildMobile(context);
        },
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Container();
  }

  Widget _buildTablet(BuildContext context) {
    return Container();
  }

  Widget _buildMobile(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          PostsScreen(),
          Container(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (val) {
          if (mounted) setState(() => _currentIndex = val);
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text(I18n.of(context).postsTitle),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            title: Text('QA'),
          ),
        ],
      ),
    );
  }
}
