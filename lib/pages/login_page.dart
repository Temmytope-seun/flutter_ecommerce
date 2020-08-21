import 'package:flutter/material.dart';
import '../constants/kFormField.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey  = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isSubmitting, _obscureText = true;
  String _password, _email;

  void _submit(){
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
//      _redirectUser();
      _loginUser();
    }
  }

  void _loginUser() async {
    setState(() {
      _isSubmitting = true;
    });
    http.Response response = await http.post('http://10.0.2.2:1337/auth/local', body: {
      "identifier": _email,
      "password": _password
    });
    final responseData = json.decode(response.body);
    print(responseData);
    if(response.statusCode == 200 ) {
      setState(() {
        _isSubmitting = false;
      });
      _storeUserData(responseData);
      _showSuccessSnack();
      _redirectUser();
      print(responseData);
    } else {
      setState(() {
        _isSubmitting = false;
      });
      var errorMsg = responseData['message'][0]['messages'][0]['message'];
      print(errorMsg);
      _showErrorSnack(errorMsg);
    }

  }
  void _storeUserData(responseData) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> user = responseData['user'];
    user.putIfAbsent('jwt', () => responseData['jwt']);
    prefs.setString('user', json.encode(user));
  }

  void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  void _showSuccessSnack() {
    final snackbar = SnackBar(
      content: Text('Login Successful', style: TextStyle(color: Colors.green),),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
    _formKey.currentState.reset();
  }

  void _showErrorSnack(String errorMsg) {
    final snackbar = SnackBar(
      content: Text(errorMsg, style: TextStyle(color: Colors.red),),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
    throw Exception('Error logging in: $errorMsg');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text('Login', style: Theme.of(context).textTheme.headline5,),

                    kFormField(
                      onSaved: (val) => _email = val,
                      validate: (val) => !val.contains('@') ? 'Invalid email address' : null,
                      obscure: false,
                      label: 'Email address',
                      hint: 'Enter email',
                      icon: Icon(Icons.mail, color: Colors.grey),
                    ),
                    kFormField(
                      onSaved: (val) => _password = val,
                      validate: (val) => val.length < 6 ? 'Password is too short' : null,
                      obscure: _obscureText,
                      suffix: GestureDetector(
                        onTap: (){
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off, color: Colors.grey,),
                      ),
                      label: 'Password',
                      hint: 'Enter password',
                      icon: Icon(Icons.lock, color: Colors.grey),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: <Widget>[
                          _isSubmitting == true ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),) :
                          RaisedButton(
                            child: Text('Submit', style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: Colors.black
                            )),
                            elevation: 8.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            color: Theme.of(context).primaryColor,
                            onPressed: _submit,
                          ),
                          FlatButton(
                            child: Text('New user? Register'),
                            onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}




