import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CROISSACQ',
      theme: ThemeData(),
      home: MyHomePage(title: 'MyHomePage'),
    );
  }
}

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
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            // TODO add profile ICON and link to profile page
            child: Text('I want a profile ICON here'),
          ),
          ListTile(
            title: const Text('Map'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Map(
                          title: 'Map',
                        )),
              );
            },
          ),
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'CROISSACQ',
          style: TextStyle(color: Color(0xff000000)),
        ),
      ),
      endDrawer: MyDrawer(),
      body: const Center(
        child: Text('Home Page Coming Soon'),
      ),
    );
  }
}

class Map extends StatelessWidget {
  const Map({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
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
        child: Text('Map Coming Soon'),
        child: Switch()
      ),
    );
  }
}

class Favourites extends StatelessWidget {
  const Favourites({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
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

class PainAuChocolat extends StatelessWidget {
  const PainAuChocolat({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
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

class Settings extends StatelessWidget {
  const Settings({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
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
