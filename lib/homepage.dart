import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _storage = FlutterSecureStorage();



class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.fuck});
  final Set<Map<String, String>> fuck;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    logindata.length,
                    style: const TextStyle(fontSize: 28),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "RevoltFlow",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Swipe from the left of screen to see your servers and messages",
                    style: TextStyle(),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
