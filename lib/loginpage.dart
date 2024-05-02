import 'package:flutter/material.dart';
import 'homepage.dart';
import 'api_calls/login.dart';
import 'api_calls/fetch_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Flutter code sample for [Form].
const _storage = FlutterSecureStorage();

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // of the TextField.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
    return logindata;
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                          prefixIcon: Icon(Icons.password),
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    login(passwordController.text, emailController.text)
                        .then((loginData) {
                      print(loginData);
                      if (loginData != null) {
                        _onFormSubmit(loginData);
                        
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HomePage(fuck: {_getLogin()},)));
                      } else {
                        print('Login failed');
                      }
                    });
                  }
                },
                child: const Text('Submit!'),
              ),
            ),
          ]),
    );
  }
}
