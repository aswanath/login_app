import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_app/homepage.dart';
import 'package:login_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final _userIdController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[400],
      appBar: AppBar(

        backgroundColor: Colors.red,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.red,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                    color: Colors.red[900],
                    fontFamily: 'ArchitectsDaughter',
                    fontSize: 70,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 200,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _userIdController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(35))),
                    border: OutlineInputBorder(),
                    hintText: 'user id',
                    hintStyle: TextStyle(color: Colors.grey)
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 200,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _passwordController,
                    obscureText: true,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(35))),
                      hintText: 'password',
                      border: OutlineInputBorder(),
                        hintStyle: TextStyle(color: Colors.grey)
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  loginCheck(context);
                },
                child: const Text('Login'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  fixedSize: const Size(100, 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }

  void loginCheck(BuildContext context) async {
    final _userid = _userIdController.text;
    final _password = _passwordController.text;
    if (_userid == _password) {
      if (_userid.isNotEmpty || _password.isNotEmpty) {
        final _sharedPrefs = await SharedPreferences.getInstance();
       await _sharedPrefs.setBool(saveDetails, true);
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            margin: EdgeInsets.all(20),
            content: Text('fields cannot be empty')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          margin: EdgeInsets.all(20),
          content: Text('user id and password does not match')));
    }
  }
}
