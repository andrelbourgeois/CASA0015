import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/profileScreen.dart';
import '../screens/homeScreen.dart';
import '../screens/mapScreen.dart';
import '../screens/favouritesScreen.dart';
import '../screens/settingsScreen.dart';

class drawerMenu extends StatefulWidget {
  @override
  _drawerMenuState createState() => _drawerMenuState();
}

class _drawerMenuState extends State<drawerMenu> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //signout function
  signOut() async {
    await auth.signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
// implements a navigation drawer to be added to each screen in the app bar
//class drawerMenu extends StatelessWidget {
  // @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        // children allows the implementation of multiple child elements
        children: [
          // the top of the drawer
          DrawerHeader(
            decoration: BoxDecoration(
              // make it white
              color: Colors.white,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const profileScreen(
                            title: 'Profile',
                          )),
                );
              },
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage(
                  'assets/images/croissantLogo.png',
                ),
              ),
            ),
          ),
          // Each ListTile will be a navigation option
          ListTile(
            title: const Text('Home'),
            // initiates the navigation when tapped
            onTap: () {
              // pops off the drawer menu screen from the stack
              Navigator.pop(context);
              // pushes new screen onto the stack - in this case, the map screen
              Navigator.push(
                context,
                // replaces the screen with a platform-adaptive transition
                MaterialPageRoute(
                    // builds the new screen - in this case, the map screen
                    builder: (context) => const homeScreen(
                          title: 'Home',
                        )),
              );
            },
          ),
          ListTile(
            title: const Text('Map'),
            // initiates the navigation when tapped
            onTap: () {
              // pops off the drawer menu screen from the stack
              Navigator.pop(context);
              // pushes new screen onto the stack - in this case, the map screen
              Navigator.push(
                context,
                // replaces the screen with a platform-adaptive transition
                MaterialPageRoute(
                    // builds the new screen - in this case, the map screen
                    builder: (context) => const mapScreen(
                          title: 'Map',
                        )),
              );
            },
          ),
          // for comments on remaining list tiles, see above
          ListTile(
            title: const Text('Favourites'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const favouritesScreen(
                          title: 'Favourites',
                        )),
              );
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const settingsScreen(
                          title: 'Settings',
                        )),
              );
            },
          ),
          ElevatedButton(
            child: Text('Sign Out'),
            onPressed: () {
              signOut();
            },
          )
        ],
      ),
    );
  }
}
