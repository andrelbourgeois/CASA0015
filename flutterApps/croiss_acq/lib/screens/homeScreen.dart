import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/drawerMenu.dart';

User? loggedinUser;


class homeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
//const homeScreen({Key? key, required this.title}) : super(key: key);
  final _auth = FirebaseAuth.instance;

//final String title;

  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

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