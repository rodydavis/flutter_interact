import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interact/data/classes/post.dart';
import 'package:flutter_interact/generated/i18n.dart';
import 'package:get_it/get_it.dart';

import 'details.dart';

class PostsScreen extends StatelessWidget {
  static const String routeName = '/posts';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream:
              GetIt.instance.get<Firestore>().collection('posts').onSnapshot,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final _data = snapshot.data.docs;
            if (_data.isEmpty) {
              return Center(
                child: Text(I18n.of(context).postsPostsEmpty),
              );
            }
            return ListView.builder(
              itemCount: _data.length,
              itemBuilder: (_, index) {
                final _item = Post(_data[index]);
                return ListTile(
                  title: Text(_item.title),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      PostDetailsScreen.getRoute(_item.id),
                    );
                  },
                );
              },
            );
          }),
    );
  }
}
