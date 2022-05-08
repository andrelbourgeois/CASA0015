import 'package:flutter/material.dart';
import '../src/drawerMenu.dart';


class homeScreen extends StatelessWidget {
  const homeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    // provides the scaffolding for the screen from which to add things
    return Scaffold(
      // the top app bar
        appBar: AppBar(
          // colours, TODO can i put these in app theme?
          backgroundColor: Colors.white,
          // icon colours
          iconTheme: IconThemeData(color: Colors.black),
          // centering the title
          centerTitle: true,
          title: const Text(
            'CROISSACQ',
            style: TextStyle(color: Color(0xff000000)),
          ),
        ),
        // adding the drawer on the right of the app bar
        endDrawer: drawerMenu(), // drawerMenu
        // body of the home screen
        body: Center(
            child: (Column(children: [
              Text('Home Page Coming Soon'),
              ElevatedButton(
                child: Text('Press me!'),
                onPressed: () {
                  print('Hello');
                },
              ),
            ]))));
  }
}