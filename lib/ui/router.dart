import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'feed/screen.dart';
import 'feed/details.dart';
import 'home/screen.dart';

class Routes {
  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(handlerFunc: (context, params) {
      print("ROUTE WAS NOT FOUND !!!");
      return RouteNotFound();
    });
    router.define(
      HomeScreen.routeName,
      handler: Handler(handlerFunc: (_, params) => HomeScreen()),
    );
    router.define(
      PostsScreen.routeName,
      handler: Handler(handlerFunc: (_, params) => PostsScreen()),
    );
    router.define(
      '/posts/:id',
      handler: Handler(handlerFunc: (_, params) {
        String id = params["id"]?.first;
        return PostDetailsScreen(postId: id);
      }),
    );
  }
}

class RouteNotFound extends StatelessWidget {
  const RouteNotFound({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: Text('404'),
        ),
      ),
    );
  }
}
