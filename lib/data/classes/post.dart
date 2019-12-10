import 'package:firebase/firestore.dart';

class Post {
  final DocumentSnapshot snapshot;
  Post(this.snapshot);

  Map<String, dynamic> get _json => snapshot.data();

  String get id => snapshot.id;
  String get title => _json['title'].toString();
  String get image => _json['image'].toString();
}
