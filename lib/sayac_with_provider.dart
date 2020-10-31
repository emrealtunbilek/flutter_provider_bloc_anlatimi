import 'package:flutter/material.dart';
import 'package:flutter_state/auth_service.dart';
import 'package:flutter_state/counter.dart';
import 'package:provider/provider.dart';

class ProviderlaSayacUygulamasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);

    switch (myAuth.durum) {
      case KullaniciDurumu.OturumAciliyor:
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      case KullaniciDurumu.OturumAcilmamis:
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Uygulamayı Kullanmak için Lütfen Oturum Açın"),
                RaisedButton(
                  onPressed: () async {
                    await myAuth.createUserWithEmailandPassword(
                        "emrealtunbilek@gmail.com", "password");
                  },
                  color: Colors.red,
                  child: Text("Kullanıcı Olustur"),
                ),
                RaisedButton(
                  onPressed: () async {
                    await myAuth.signInUserWithEmailandPassword(
                        "emrealtunbilek@gmail.com", "password");
                  },
                  color: Colors.green,
                  child: Text("Oturum Aç"),
                ),
              ],
            ),
          ),
        );

      case KullaniciDurumu.OturumAcilmis:
        return Scaffold(
          appBar: AppBar(
            title: Text("Provider ile Sayac App"),
          ),
          body: Center(
            child: MyColumn(),
          ),
          floatingActionButton: MyFloatingActionButtons(),
        );
    }
  }
}

class MyFloatingActionButtons extends StatelessWidget {
  const MyFloatingActionButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("floating action button build");
    //var mySayac = Provider.of<Counter>(context, listen: false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          heroTag: "1",
          onPressed: () {
            context.read<Counter>().arttir();
          },
          child: Icon(Icons.add),
        ),
        SizedBox(
          height: 5,
        ),
        FloatingActionButton(
          heroTag: "2",
          onPressed: () {
            context.read<Counter>().azalt();
          },
          child: Icon(Icons.remove),
        ),
      ],
    );
  }
}

class MyColumn extends StatelessWidget {
  const MyColumn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("mycolumn widget build");
    //var mySayac = Provider.of<Counter>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          context.watch<Counter>().sayac.toString(),
          style: TextStyle(fontSize: 32),
        ),
        Text(
          Provider.of<AuthService>(context).user.email,
          style: TextStyle(fontSize: 32),
        ),
        RaisedButton(
            color: Colors.yellowAccent,
            child: Text("Oturumu kapat"),
            onPressed: () async {
              await context.read<AuthService>().signOut();
            })
      ],
    );
  }
}
