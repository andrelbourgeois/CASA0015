// importing the dart material library
import 'package:flutter/material.dart';

void main() {
  // i think this runs the app?
  runApp(MyApp());
}

// implements the app
// extend here allows MyApp to inherit properties and methods from StatelessWidget
class MyApp extends StatelessWidget {
  // @override helps to identify inherited methods or variables
  // that are being replaced in the subclass
  @override
  // builds the widget
  Widget build(BuildContext context) {
    // returns a widget that is a material app
    return MaterialApp(
      title: 'CROISSACQ',
      // theme data for the app
      theme: ThemeData(),
      home: MyHomePage(title: 'MyHomePage'),
    );
  }
}

// implements a navigation drawer to be added to each screen in the app bar
class MyDrawer extends StatelessWidget {
  @override
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
          const DrawerHeader(
            decoration: BoxDecoration(
              // make it white
              color: Colors.white,
            ),
            // TODO add profile ICON and link to profile page
            child: Text('I want a profile ICON here'),
          ),
          // Each ListTile will be a navigation option
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
                    builder: (context) => const Map(
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
                    builder: (context) => const Favourites(
                          title: 'Favourites',
                        )),
              );
            },
          ),
          ListTile(
            title: const Text('Pain au Chocolat?'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PainAuChocolat(
                          title: 'PainAuChocolat',
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
                    builder: (context) => const Settings(
                          title: 'Settings',
                        )),
              );
            },
          ),
        ],
      ),
    );
  }
}

// implements the home screen, bottom of the stack?
class MyHomePage extends StatelessWidget {
  // key is an identifier for widget, elements, and semantic nodes
  // a new widget can only update an existing element if the key is the same
  // the ? makes this key optional
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  // builds the home screen
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
      endDrawer: MyDrawer(), // call MyDrawer
      // body of the home screen
      body: const Center(
        child: Text('Home Page Coming Soon'),
      ),
    );
  }
}

// implements map screen
class Map extends StatelessWidget {
  const Map({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          // back button which takes you back to the home screen
          // icon is a back arrow, located on the left of the app bar
          icon: Icon(Icons.arrow_back),
          // initiates action when pressed
          onPressed: () =>
          // pops screens from the stack until we reach the first screen
              Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'CROISSACQ',
          style: TextStyle(color: Colors.black),
        ),
      ),
      endDrawer: MyDrawer(),
      body: Column(children: [Text('Map Coming Soon'), MapToggle()]),
    );
  }
}

// implements a toggle switch widget for the map widget
// will toggle between map view and list view
// must extend stateful widget because this switch has a state
class MapToggle extends StatefulWidget {
  const MapToggle({Key? key}) : super(key: key);
  @override
  // implements a starting state and passes it to a hidden class _MapState
  State<MapToggle> createState() => _MapState();
}

// the _ at the beginning of the name means this class is hidden
// bool isSwitched = false; map view
// bool isSwitched = true; list view
class _MapState extends State<MapToggle> {
  bool isSwitched = false;

  @override
  // build the widget
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

// implements favourites screen
class Favourites extends StatelessWidget {
  const Favourites({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'CROISSACQ',
          style: TextStyle(color: Colors.black),
        ),
      ),
      endDrawer: MyDrawer(),
      body: const Center(
        child: Text('Favourites Coming Soon'),
      ),
    );
  }
}

// implements pain au chocolat screen
class PainAuChocolat extends StatelessWidget {
  const PainAuChocolat({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        backgroundColor: Color(0xffffffff),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text('CROISSACQ', style: TextStyle(color: Colors.black)),
      ),
      endDrawer: MyDrawer(),
      body: const Center(
        child: Text('Pain au Chocolat Coming Soon'),
      ),
    );
  }
}

// implements settings screen
class Settings extends StatelessWidget {
  const Settings({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        backgroundColor: Color(0xffffffff),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text('CROISSACQ', style: TextStyle(color: Colors.black)),
      ),
      endDrawer: MyDrawer(),
      body: const Center(
        child: Text('Settings Coming Soon'),
      ),
    );
  }
}
