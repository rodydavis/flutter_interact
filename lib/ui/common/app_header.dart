import 'package:fb_auth/fb_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interact/generated/i18n.dart';
import 'package:flutter_interact/ui/auth/screen.dart';
import 'package:flutter_interact/ui/common/web_popup.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final _user = state is LoggedInState ? state.user : null;
        final _hasImage = _user?.photoUrl != null && _user.photoUrl.isNotEmpty;
        return Material(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Center(
                  child: Text(
                    I18n.of(context).title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                _user == null
                    ? RaisedButton(
                        child: Text('Login'),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => WebPopup(child: LoginScreen()),
                          );
                        },
                      )
                    : InkWell(
                        onTap: () {
                          BlocProvider.of<AuthBloc>(context).add(
                            LogoutEvent(_user),
                          );
                        },
                        child: Center(
                          child: Row(
                            children: <Widget>[
                              Text(_user?.displayName ?? 'Guest'),
                              Container(width: 10.0),
                              CircleAvatar(
                                child: _hasImage ? null : Icon(Icons.person),
                                backgroundImage: _hasImage
                                    ? NetworkImage(_user.photoUrl)
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
