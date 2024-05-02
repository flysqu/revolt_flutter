import 'package:flutter/material.dart';
import 'homepage.dart';
import 'loginpage.dart';
import 'api_calls/login.dart';
import 'api_calls/fetch_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// Flutter code sample for [Form].
const _storage = FlutterSecureStorage();

void main() => runApp(const FormExampleApp());

class FormExampleApp extends StatelessWidget {
  const FormExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: AuthPage(),
      ),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _onFormSubmit(Map<String, dynamic>? loginData) async {
    if (loginData != null) {
      String id = loginData['_id'];
      String userId = loginData['user_id'];
      String token = loginData['token'];
      String name = loginData['name'];

      await _storage.write(key: "LOGGEDIN", value: "true");
      await _storage.write(key: "ID", value: id);
      await _storage.write(key: "USERID", value: userId);
      await _storage.write(key: "TOKEN", value: token);
      await _storage.write(key: "NAME", value: name);

      print("Saved Data!");
    }
  }

  _getLogin() async {
    Map<String, String> logindata = {};

    logindata['loggedIn'] = await _storage.read(key: "LOGGEDIN") ?? 'false';
    logindata['id'] = await _storage.read(key: "ID") ?? 'false';
    logindata['userID'] = await _storage.read(key: "USERID") ?? 'false';
    logindata['token'] = await _storage.read(key: "TOKEN") ?? 'false';
    logindata['friendlyName'] = await _storage.read(key: "NAME") ?? 'false';

    print(logindata);
  }

  Future<void> _startupLogin() async {
    String loggedIn = await _storage.read(key: "LOGGEDIN") ?? 'false';
    if (loggedIn == "true") {
      String token = await _storage.read(key: "TOKEN") ?? 'false';
      fetchUser(token).then((fetchUserData) {
        if (fetchUserData != null) {
          // If login is successful, print the response
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomePage()));
        } else {
          print('Login failed!');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LoginPage()));
        }
      });
    }
    print(loggedIn);
    print("Hello World!");
  }

  @override
  void initState() {
    _startupLogin();
  }

  // of the TextField.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SpinKitDualRing(
                    color: Color.fromARGB(255, 222, 222, 222),
                    size: 50.0,
                  ))
            ],
          ),
        ),
      ],
    ));
  }
}
