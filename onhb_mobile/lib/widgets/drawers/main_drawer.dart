import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:simple_icons/simple_icons.dart";

class DrawerRow extends StatelessWidget {
  final IconButton iconButton;
  final TextButton text;

  const DrawerRow({super.key, required this.iconButton, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [iconButton, SizedBox(width: 20), text],
    );
  }
}

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Future<void> _redirectGithub() async {
    if (!await launchUrl(Uri.parse("https://github.com/Ilusinusmate"))) {
      print("An error ocurred trying to acess the url");
    }
  }

  Future<void> _redirectAuthor() async {
    if (!await launchUrl(Uri.parse("https://github.com/Ilusinusmate"))) {
      print("An error ocurred trying to acess the url");
    }
  }

  Text _buildText(String text, BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodyMedium);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: DrawerHeader(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: ListTile(
                  leading: Icon(Icons.book, color: Colors.white,),
                  title: Text("ONHB Mobile App"),
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                  ),
                ),
              ),
            ),

            DrawerRow(
              iconButton: IconButton(
                onPressed: _redirectGithub,
                icon: Icon(SimpleIcons.github),
              ),
              text: TextButton(
                onPressed: _redirectGithub,
                child: _buildText("Github do Projeto", context),
              ),
            ),

            DrawerRow(
              iconButton: IconButton(
                onPressed: _redirectAuthor,
                icon: Icon(SimpleIcons.github),
              ),
              text: TextButton(
                onPressed: _redirectAuthor,
                child: _buildText("Autor do Projeto", context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
