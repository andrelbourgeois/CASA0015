// implements the profile screen
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/drawerMenu.dart';
import '../screens/homeScreen.dart';
import '../screens/welcomeScreen.dart';


// implements settings screen
class profileScreen extends StatefulWidget {
  @override
  _profileScreenState createState() => _profileScreenState();
}
class _profileScreenState extends State<profileScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //signout function
  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => welcomeScreen())
    );
  }

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
              backgroundColor: Colors.black,
              ),
            SizedBox(
              height: 20.0,
            ),
            Text('EMAIL: ${loggedinUser?.email}',),
            ElevatedButton(
              child: Text('Sign Out'),
              onPressed: () {
                signOut();
              },style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
            )
          ]),
        ));
  }
}

