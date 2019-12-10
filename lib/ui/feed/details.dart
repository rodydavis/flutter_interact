import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interact/data/classes/post.dart';
import 'package:get_it/get_it.dart';

class PostDetailsScreen extends StatelessWidget {
  final String postId;
  static String getRoute(String val) => '/posts/$val';

  const PostDetailsScreen({
    Key key,
    @required this.postId,
  }) : super(key: key);
  DocumentReference get postDoc =>
      GetIt.instance.get<Firestore>().collection("posts").doc(postId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: postDoc.onSnapshot,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final _post = Post(snapshot.data);
            return Container(
              child: Text(_post.title),
            );
          }),
    );
  }
}
