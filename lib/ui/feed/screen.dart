import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interact/data/classes/post.dart';
import 'package:flutter_interact/generated/i18n.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';

import 'details.dart';

class PostsScreen extends StatelessWidget {
  static const String routeName = '/posts';
  CollectionReference get postsCollection =>
      GetIt.instance.get<Firestore>().collection('posts');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: postsCollection.onSnapshot,
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
            return LayoutBuilder(
              builder: (_, dimens) => StaggeredGridView.countBuilder(
                crossAxisCount: (dimens.maxWidth / 250.0).floor(),
                itemCount: _data.length,
                itemBuilder: (_, index) {
                  final _item = Post(_data[index]);
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PostDetailsScreen.getRoute(_item.id),
                      );
                    },
                    child: Container(
                      height: 400.0,
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                        elevation: 2.0,
                        child: Image.network(_item.image),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
            );
          }),
    );
  }
}
