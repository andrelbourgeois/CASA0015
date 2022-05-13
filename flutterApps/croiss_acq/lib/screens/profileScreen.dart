// implements the profile screen
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../utils/drawerMenu.dart';
import '../screens/homeScreen.dart';

// User? loggedinUser;


// implements settings screen
class profileScreen extends StatefulWidget {
  @override
  _profileScreenState createState() => _profileScreenState();
}
class _profileScreenState extends State<profileScreen> {
  /*
  final _auth = FirebaseAuth.instance;

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

   */

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
          backgroundColor: Color(0xffffffff),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: const Text('CROISSACQ', style: TextStyle(color: Colors.black)),
        ),
        endDrawer: drawerMenu(),
        body: Center(
          child: Column(children: [
            SizedBox(
              height: 20.0,
            ),
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage(
                'assets/images/croissantLogo.png',
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text('EMAIL: ${loggedinUser?.email}',),
          ]),
        ));
  }
}

