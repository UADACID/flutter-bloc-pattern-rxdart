import 'package:flutter/material.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;
  final StreamController<int> _streamController = StreamController<int>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: StreamBuilder<int>(
              stream: _streamController.stream,
              initialData: _counter,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                return Text('${snapshot.data}');
              },
            ),
          ),
          RaisedButton(
            child: Text('reset'),
            onPressed: () {
              _streamController.sink.add(0);
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _streamController.sink.add(++_counter);
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
    super.dispose();
  }
}
