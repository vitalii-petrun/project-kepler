import 'package:firebase_core/firebase_core.dart';

import '../firebase_options.dart';

class Authentication {
  static Future<FirebaseApp> initializeFirebase() async {
    final firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    return firebaseApp;
  }
}
