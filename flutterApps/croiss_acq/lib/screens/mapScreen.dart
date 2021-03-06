/*
Code for this file was modified from similar work by Souvik Biswas in 2021
Article - https://blog.codemagic.io/creating-a-route-calculator-using-google-maps/
GitHub - https://github.com/sbis04/flutter_maps
 */

// implements map screen
// and other map related functions
import 'dart:async';
// importing math
import 'dart:math';

// importing material
import 'package:flutter/material.dart';

// import my API
import '../utils/secrets.dart'; // Stores the Google Maps API Key

//importing mapping and routing functionality
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../utils/drawerMenu.dart';
import '../screens/homeScreen.dart';

// importing google maps library
import 'package:google_maps_flutter/google_maps_flutter.dart';

class mapScreen extends StatefulWidget {
  @override
  State<mapScreen> createState() => mapScreenState();
}

class mapScreenState extends State<mapScreen> {
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  late GoogleMapController mapController;

  late Position _currentPosition;
  String _currentAddress = '';

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final destinationAddressFocusNode = FocusNode();

  String _startAddress = '';
  String _destinationAddress = '';
  String? _placeDistance;

  Set<Marker> markers = {};

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _textField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required double width,
    required Icon prefixIcon,
    Widget? suffixIcon,
    required Function(String) locationCallback,
  }) {
    return Container(
      width: width * 0.8,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        focusNode: focusNode,
        decoration: new InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Colors.blue.shade300,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }

  // method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  // method for retrieving the address
  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.name}, ${place.locality}, ${place.postalCode}, ${place
            .country}";
        startAddressController.text = _currentAddress;
        _startAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  // method for calculating the distance between 2 places
  Future<bool> _calculateDistance() async {
    try {
      // retrieve placemarkers from addresses
      List<Location>? startPlacemark = await locationFromAddress(_startAddress);
      List<Location>? destinationPlacemark = await locationFromAddress(
          _destinationAddress);

      // use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it reults in better accuracy
      double startLatitude = _startAddress == _currentAddress
          ? _currentPosition.latitude
          : startPlacemark[0].latitude;

      double startLongitude = _startAddress == _currentAddress
          ? _currentPosition.longitude
          : startPlacemark[0].longitude;

      double destinationLatitude = destinationPlacemark[0].latitude;
      double destinationLongitude = destinationPlacemark[0].longitude;

      String startCoordinatesString = '($startLatitude, $startLongitude)';
      String destinationCoordinatesString = '($destinationLatitude, $destinationLongitude)';

      // sets the start location marker
      Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude, startLongitude),
        infoWindow: InfoWindow(
          title: 'Start $startCoordinatesString',
          snippet: _startAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // sets the destination location marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
          snippet: _destinationAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // add markers to the list
      markers.add(startMarker);
      markers.add(destinationMarker);

      print(
        'START COORDINATES: ($startLatitude, $startLongitude)',
      );
      print(
        'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
      );

      // calculate to check that the position relative
      // to the frame, and pan & zoom the camera accordingly

      double miny = (startLatitude <= destinationLatitude)
          ? startLatitude
          : destinationLatitude;
      double minx = (startLongitude <= destinationLongitude)
          ? startLongitude
          : destinationLongitude;
      double maxy = (startLatitude <= destinationLatitude)
          ? destinationLatitude
          : startLatitude;
      double maxx = (startLongitude <= destinationLongitude)
          ? destinationLongitude
          : startLongitude;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;

      // accomodate the two locations within the camera view
      // of the map
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100.0,
        ),
      );

      /*

      calculating the distance between the start and the end positions
      with a straight path, without considering any route

      double distanceInMeters = await Geolocator().bearingBetween(
        startCoordinates.latitude,
        startCoordinates.longitude,
        destinationCoordinates.latitude,
        destinationCoordinates.longitude,
      );

      */

      await _createPolylines(startLatitude, startLongitude, destinationLatitude,
          destinationLongitude);

      double totalDistance = 0.0;

      // calculating the total distance by adding the distance
      // between small segments
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      setState(() {
        _placeDistance = totalDistance.toStringAsFixed(2);
        print('DISTANCE $_placeDistance km');
      });

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  // formula for calculating distance between two coordinates
  // https://stackoverflow.com/a/54138876/11910277
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  // create the polylines for showing the route between two places
  _createPolylines(
      double startLatitude,
      double startLongitude,
      double destinationLatitude,
      double destinationLongitude,
      ) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Secrets.API_KEY, // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.transit,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {

    // Determining the screen width & height
    var height = MediaQuery
        .of(context)
        .size
        .height - 370;
    var width = MediaQuery
        .of(context)
        .size
        .width;

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
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => homeScreen()),
                    (route) => false)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'CROISSACQ',
          style: TextStyle(color: Colors.black),
        ),
      ),
      endDrawer: drawerMenu(),
      body: Stack(children: [
        // MapToggle(),
        // Show current location button
        Container(
          height: height,
          width: width,
          child: GoogleMap(
            markers: Set<Marker>.from(markers),
            initialCameraPosition: _initialLocation,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: MapType.hybrid,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            polylines: Set<Polyline>.of(polylines.values),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
              child: ClipOval(
                child: Material(
                  color: Colors.orange.shade100, // button color
                  child: InkWell(
                    splashColor: Colors.orange, // inkwell color
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: Icon(Icons.my_location),
                    ),
                    onTap: () {
                      mapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(
                              _currentPosition.latitude,
                              _currentPosition.longitude,
                            ),
                            zoom: 18.0,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        // Show the place input fields & button for
        // showing the route
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                width: width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Places',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(height: 20),
                      _textField(
                          label: 'Start',
                          hint: 'Choose starting point',
                          prefixIcon: Icon(Icons.looks_one),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.my_location),
                            onPressed: () {
                              startAddressController.text = _currentAddress;
                              _startAddress = _currentAddress;
                            },
                          ),
                          controller: startAddressController,
                          focusNode: startAddressFocusNode,
                          width: width,
                          locationCallback: (String value) {
                            setState(() {
                              _startAddress = value;
                            });
                          }),
                      SizedBox(height: 10),
                      _textField(
                          label: 'Destination',
                          hint: 'Choose destination',
                          prefixIcon: Icon(Icons.looks_two),
                          controller: destinationAddressController,
                          focusNode: destinationAddressFocusNode,
                          width: width,
                          locationCallback: (String value) {
                            setState(() {
                              _destinationAddress = value;
                            });
                          }),
                      SizedBox(height: 10),
                      Visibility(
                        visible: _placeDistance == null ? false : true,
                        child: Text(
                          'DISTANCE: $_placeDistance km',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: (_startAddress != '' &&
                            _destinationAddress != '')
                            ? () async {
                          startAddressFocusNode.unfocus();
                          destinationAddressFocusNode.unfocus();
                          setState(() {
                            if (markers.isNotEmpty) markers.clear();
                            if (polylines.isNotEmpty)
                              polylines.clear();
                            if (polylineCoordinates.isNotEmpty)
                              polylineCoordinates.clear();
                            _placeDistance = null;
                          });

                          _calculateDistance().then((isCalculated) {
                            if (isCalculated) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Distance Calculated Sucessfully'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Error Calculating Distance'),
                                ),
                              );
                            }
                          });
                        }
                            : null,
                        // color: Colors.red,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(20.0),
                        // ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Show Route'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // TODO add button to find croissant - point to specific bakery

        // ElevatedButton(
        // onPressed: (_goToTheLake), child: Text('To the lake!'))
      ]),
    );
  }
  /*
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

   */
}


/*
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

 */
