import 'package:flutter/material.dart';

import 'bloc/sayac_bloc.dart';
import 'bloc/sayac_event.dart';

class BlocKullanimi extends StatefulWidget {
  @override
  _BlocKullanimiState createState() => _BlocKullanimiState();
}

class _BlocKullanimiState extends State<BlocKullanimi> {
  final _sayacBloc = SayacBloc();

  @override
  void dispose() {
    _sayacBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc Kullanimi"),
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
              stream: _sayacBloc.sayac,
              builder: (context, snapshot) {
                return Text(
                  snapshot.data.toString(),
                  style: TextStyle(fontSize: 48),
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
              _sayacBloc.sayacEventSink.add(ArttirmaEvent());
            },
            child: Icon(Icons.add),
          ),
          SizedBox(
            height: 5,
          ),
          FloatingActionButton(
            heroTag: "2",
            onPressed: () {
              _sayacBloc.sayacEventSink.add(AzaltmaEvent());
            },
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
