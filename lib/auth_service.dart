import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum KullaniciDurumu { OturumAcilmis, OturumAcilmamis, OturumAciliyor }

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  KullaniciDurumu _durum = KullaniciDurumu.OturumAcilmamis;
  User _user;
  KullaniciDurumu get durum => _durum;

  User get user => _user;

  set durum(KullaniciDurumu value) {
    _durum = value;
    notifyListeners();
  }

  AuthService() {
    _auth.authStateChanges().listen(_authStateChanged);
  }

  void _authStateChanged(User user) {
    if (user == null) {
      _user = null;
      durum = KullaniciDurumu.OturumAcilmamis;
    } else {
      _user = user;
      durum = KullaniciDurumu.OturumAcilmis;
    }
  }

  Future<User> createUserWithEmailandPassword(
      String email, String sifre) async {
    try {
      durum = KullaniciDurumu.OturumAciliyor;
      UserCredential _credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: sifre);
      User _yeniKullanici = _credential.user;
      _user = _yeniKullanici;
      return _yeniKullanici;
    } catch (e) {
      durum = KullaniciDurumu.OturumAcilmamis;
      debugPrint("create userda hata cıktı $e");
      return null;
    }
  }

  Future<User> signInUserWithEmailandPassword(
      String email, String sifre) async {
    try {
      durum = KullaniciDurumu.OturumAciliyor;
      UserCredential _credential =
          await _auth.signInWithEmailAndPassword(email: email, password: sifre);
      User _oturumAcanKullanici = _credential.user;
      _user = _oturumAcanKullanici;
      return _oturumAcanKullanici;
    } catch (e) {
      durum = KullaniciDurumu.OturumAcilmamis;
      debugPrint("sing in metotunda hata cıktı $e");
      return null;
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      _user = null;
      durum = KullaniciDurumu.OturumAcilmamis;
      return true;
    } catch (e) {
      debugPrint("sing out metotunda hata cıktı $e");
      return false;
    }
  }
}
