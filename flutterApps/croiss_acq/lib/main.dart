// importing the dart material library
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

// importing provider library (what is provider?)
import 'package:provider/provider.dart';

// importing misc files - firebase options, auth, & widgets
import 'screens/welcomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // i think this runs the app?
  runApp(const App());
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
      home: welcomeScreen(),
    );
  }
}
