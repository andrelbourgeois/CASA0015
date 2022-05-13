// implements favourites screen
import 'package:flutter/material.dart';
import '../utils/drawerMenu.dart';
import '../screens/homeScreen.dart';

class favouritesScreen extends StatelessWidget {
  const favouritesScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context) => homeScreen()), (route) => false)
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: const Text(
            'CROISSACQ',
            style: TextStyle(color: Colors.black),
          ),
        ),
        endDrawer: drawerMenu(),
        body: Center(
          child: Column(children: [
            Text('Favourites Coming Soon'),
          ]),
        ));
  }
}