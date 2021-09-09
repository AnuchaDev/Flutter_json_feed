import 'package:flutter/material.dart';
import 'package:json_feed/Services/AuthService.dart';
import 'package:validators/validators.dart';

import 'Models/User.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  User user = User();
  AuthService authService = AuthService();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            children: [
              _buildForm(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Card(
      margin: EdgeInsets.only(top: 80.0, left: 30.0, right: 30.0),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _logo(),
              SizedBox(height: 22.0),
              _buildUsernameInput(),
              SizedBox(height: 22.0),
              _buildPasswordInput(),
              SizedBox(height: 30.0),
              _buildSubmitButton(),
              _buildForgotPassword(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Image(
      image: AssetImage('assets/header_main.png'),
      fit: BoxFit.cover,
    );
  }

  Widget _buildUsernameInput() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'example@gmail.com',
        labelText: 'Username',
        icon: Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: _validateEmail,
      onSaved: (String value) {
        user.Username = value;
      },
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(passwordFocusNode);
      },
    );
  }

  Widget _buildPasswordInput() => TextFormField(
    focusNode: passwordFocusNode,
        decoration: InputDecoration(
          labelText: 'Password',
          icon: Icon(Icons.lock),
        ),
        obscureText: true,
        validator: _validatePassword,
        onSaved: (String value) {
          user.Password = value;
        },
      );

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return 'The email is Empty';
    }
    if (!isEmail(value)) {
      return 'The Email must be a valid email';
    }
    return null;
  }

  void _submit() {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();
      authService.login(user: user).then((result) {
        if (result) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          _showAlertDialog();
        }
      });
    }
  }

  void _showAlertDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Username or Password is incorrect.'),
            content: Text('Please Try Again.'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'The password must ba at least 8 characters';
    }
    return null;
  }

  Widget _buildSubmitButton() => Container(
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          color: Colors.blue,
          onPressed: _submit,
          child: Text('Login'.toUpperCase(),
              style: TextStyle(color: Colors.white)),
        ),
      );

  Widget _buildForgotPassword() => Container(
        child: FlatButton(
          splashColor: Colors.blue.shade500,
          onPressed: () {},
          child:
              Text('Forgot password?', style: TextStyle(color: Colors.black54)),
        ),
      );
}
