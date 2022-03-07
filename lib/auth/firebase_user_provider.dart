import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Crmcash360FirebaseUser {
  Crmcash360FirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

Crmcash360FirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Crmcash360FirebaseUser> crmcash360FirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<Crmcash360FirebaseUser>(
            (user) => currentUser = Crmcash360FirebaseUser(user));
