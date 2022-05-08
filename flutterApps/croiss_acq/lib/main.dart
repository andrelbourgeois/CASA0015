// importing firebase libraries
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

// importing the dart material library
import 'package:flutter/material.dart';

// importing provider library (what is provider?)
import 'package:provider/provider.dart';

// importing misc files - firebase options, auth, & widgets
import 'firebase_options.dart';
import 'src/fire_auth.dart';
import 'src/validator.dart';
import 'screens/loginScreen.dart';
import 'screens/profileScreen.dart';
import 'screens/registerScreen.dart';
import 'src/drawerMenu.dart';

// importing google maps library
// import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  // i think this runs the app?
  runApp(App());
}

// implements the app
// extend here allows App to inherit properties and methods from StatelessWidget
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // @override helps to identify inherited methods or variables
  // that are being replaced in the subclass
  @override
  // builds the widget
  Widget build(BuildContext context) {
    // returns a widget that is a material app
    return MaterialApp(
      title: 'CROISSACQ',
      debugShowCheckedModeBanner: false,
      // theme data for the app
      theme: ThemeData(),
      home:LoginScreen(),
    );
  }
}

// Firebase stuff
// An asynchronous method runs in a thread separate from the main
// application thread.
// The processing results are fetched through another call on another thread
Future<FirebaseApp> _initializeFirebase() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  return firebaseApp;
}
