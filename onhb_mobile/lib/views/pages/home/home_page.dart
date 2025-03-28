import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late final WebViewController controller;

  // @override
  // void initState() {
  //   super.initState();
  //   controller = WebViewController()
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     ..loadRequest(Uri.parse('https://www.olimpiadadehistoria.com.br/')); // Replace with your URL
  // }

  Future<void> _redirectOnhb() async {
    if (!await launchUrl(
      Uri.parse('https://www.olimpiadadehistoria.com.br/'),
    )) {
      throw Exception("Error while opening the site url");
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: Center(
        child: Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mobile_friendly, color: primaryColor),
                    SizedBox(width: 5),
                    Text(
                      "Seja Bem-vindo",
                      // style: TextStyle(color: primaryColor),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Divider(),
                SizedBox(height: 15),

                Text(
                  "Você pode utilizar o nosso App para:",
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                SizedBox(height: 40),

                ListTile(
                  leading: Icon(Icons.check, color: primaryColor),
                  title: Text(
                    "Corrigir a sua prova",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.check, color: primaryColor),
                  title: Text(
                    "Saber mais sobre a ONHB",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),

                ListTile(
                  leading: Icon(
                    Icons.pending_actions_outlined,
                    color: primaryColor,
                  ),
                  title: Text(
                    "Se inscrever na ONHB",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),

                Spacer(),

                MaterialButton(
                  color: primaryColor,
                  onPressed: _redirectOnhb,
                  child: Text(
                    "Saiba Mais",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
