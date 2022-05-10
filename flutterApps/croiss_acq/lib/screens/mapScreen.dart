// implements map screen
// and other map related functions
import 'package:flutter/material.dart';
import '../utils/drawerMenu.dart';
import '../screens/homeScreen.dart';


// importing google maps library
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class mapScreen extends StatelessWidget {
  const mapScreen({Key? key, required this.title}) : super(key: key);

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
            //Navigator.of(context).popUntil((route) => route.isFirst),
            //Navigator.pop(context)
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) => homeScreen(title: 'homeScreen',)), (route) => false)
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: const Text(
            'CROISSACQ',
            style: TextStyle(color: Colors.black),
          ),
        ),
        endDrawer: drawerMenu(),
        body: Center(
          child: Column(children: [
            Text('Map Coming Soon'), MapToggle(),
            // contains the map screen so it doesn't overflow
            //SizedBox(width: 200.0, height: 300.0, child: MapScreen())
          ]),
        ));
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

/*class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(51.5072, 0.1276),
    zoom: 11,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
      ),
    );
  }
}
*/
