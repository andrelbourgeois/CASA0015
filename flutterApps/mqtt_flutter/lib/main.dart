import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('MQTT Feeds')),
        body: MyListView()
      )
    );
  }
}

class MyListView extends StatefulWidget{
  @override
  ListViewState createState() {return ListViewState();}
}

class ListViewState extends State<MyListView>{
  late List<String> feeds;

  @override
  void initState() {
    super.initState();
    feeds = [];
    updateList(String s){
      ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: feeds.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(feeds[index].toString()),
        );
      },
    );
  }

}