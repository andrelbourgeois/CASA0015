// implements the profile screen
import 'package:flutter/material.dart';
import '../utils/drawerMenu.dart';
import '../screens/homeScreen.dart';

// implements settings screen
class profileScreen extends StatelessWidget {
  const profileScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () =>
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) => homeScreen(title: 'homeScreen',)), (route) => false)
          ),
          backgroundColor: Color(0xffffffff),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: const Text('CROISSACQ', style: TextStyle(color: Colors.black)),
        ),
        endDrawer: drawerMenu(),
        body: Center(
          child: Column(children: [
            Text('Profile Coming Soon'),
          ]),
        ));
  }
}