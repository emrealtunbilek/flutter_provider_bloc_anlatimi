import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state/auth_service.dart';
import 'package:flutter_state/counter.dart';
import 'package:flutter_state/sayac_with_provider.dart';
import 'package:flutter_state/stream_kullanimi.dart';
import 'package:provider/provider.dart';

import 'bloc_kullanimi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                color: Colors.blue,
                child: Text("Provider ile Sayac App"),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                            create: (_) => Counter(5),
                          ),
                          ChangeNotifierProvider(
                            create: (_) => AuthService(),
                          ),
                        ],
                        child: ProviderlaSayacUygulamasi(),
                      ),
                    ),
                  );
                }),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => StreamKullanimi()));
              },
              child: Text("Stream Kullanımı"),
              color: Colors.yellow,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BlocKullanimi()));
              },
              child: Text("Bloc Kullanımı"),
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
