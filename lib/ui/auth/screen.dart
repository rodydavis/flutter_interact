import 'package:fb_auth/fb_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _createUser = false;
  bool _concealPassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is LoggedInState) {
            Navigator.maybePop(context);
          }
        },
        child: Container(
          child: Form(
            key: _formKey,
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (_, state) => Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      _createUser ? 'Create Account' : 'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _createUser,
                    child: ListTile(
                      title: TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                          labelText: 'Display Name',
                          filled: true,
                          border: InputBorder.none,
                        ),
                        validator: (val) =>
                            val.isNotEmpty ? null : 'Name Required!',
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        border: InputBorder.none,
                      ),
                      validator: (val) =>
                          val.isNotEmpty ? null : 'Email Required!',
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(_concealPassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              if (mounted)
                                setState(() {
                                  _concealPassword = !_concealPassword;
                                });
                            },
                          )),
                      obscureText: _concealPassword,
                      validator: (val) =>
                          val.isNotEmpty ? null : 'Password Required!',
                    ),
                  ),
                  if (_createUser) ...[
                    _buildSignupButton(context),
                  ] else ...[
                    _buildLoginButton(context),
                  ],
                  if (_createUser) ...[
                    ListTile(
                      title: Text('Already have an account?'),
                      onTap: () {
                        if (mounted)
                          setState(() {
                            _createUser = false;
                          });
                      },
                    ),
                  ] else ...[
                    ListTile(
                      title: Text('Create a new account?'),
                      onTap: () {
                        if (mounted)
                          setState(() {
                            _createUser = true;
                          });
                      },
                    ),
                  ],
                  if (state is AuthLoadingState) ...[
                    Center(child: CircularProgressIndicator()),
                  ],
                  if (state is AuthErrorState) ...[
                    if (email.text.isNotEmpty) ...[
                      ListTile(
                        title: RaisedButton(
                          child: Text('Reset Password'),
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context).add(
                              ForgotPassword(email.text),
                            );
                          },
                        ),
                      ),
                    ],
                    ListTile(
                      title: Text(state.message),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupButton(BuildContext context) {
    return ListTile(
      title: RaisedButton.icon(
        icon: Icon(Icons.person),
        label: Text('Sign Up'),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            BlocProvider.of<AuthBloc>(context).add(CreateAccount(
              email.text,
              password.text,
              displayName: name.text,
            ));
          }
        },
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ListTile(
      title: RaisedButton.icon(
        icon: Icon(Icons.person),
        label: Text('Login'),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            BlocProvider.of<AuthBloc>(context).add(LoginEvent(
              email.text,
              password.text,
            ));
          }
        },
      ),
    );
  }
}
