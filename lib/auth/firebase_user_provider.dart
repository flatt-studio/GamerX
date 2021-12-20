import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class GamerXFirebaseUser {
  GamerXFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

GamerXFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<GamerXFirebaseUser> gamerXFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<GamerXFirebaseUser>((user) => currentUser = GamerXFirebaseUser(user));
