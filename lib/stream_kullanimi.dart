import 'dart:async';

import 'package:flutter/material.dart';

class StreamKullanimi extends StatefulWidget {
  @override
  _StreamKullanimiState createState() => _StreamKullanimiState();
}

class _StreamKullanimiState extends State<StreamKullanimi> {
  final StreamController<int> _streamController = StreamController<int>();
  int _counter = 0;

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Kullanimi"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<int>(
              initialData: 0,
              stream: _streamController.stream,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                return Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "1",
            onPressed: () {
              _streamController.sink.add(++_counter);
            },
            child: Icon(Icons.add),
          ),
          SizedBox(
            height: 5,
          ),
          FloatingActionButton(
            heroTag: "2",
            onPressed: () {
              _streamController.sink.add(--_counter);
            },
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
