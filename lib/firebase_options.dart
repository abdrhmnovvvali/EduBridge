// File generated from Firebase `google-services.json` + `GoogleService-Info.plist` (edubridge-9884a).
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('Web üçün Firebase təyin edilməyib.');
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return ios;
      default:
        throw UnsupportedError('Bu platform üçün Firebase təyin edilməyib.');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCqOuCifYNNRtJp8nTumhBu8U6OCKU-5-Y',
    appId: '1:217698629218:android:eafd20efc974fbbb84c33b',
    messagingSenderId: '217698629218',
    projectId: 'edubridge-9884a',
    storageBucket: 'edubridge-9884a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBjlaH2XGlYVmrJwoR9cK2EvwSsHcwC3XQ',
    appId: '1:217698629218:ios:341045147c8065ed84c33b',
    messagingSenderId: '217698629218',
    projectId: 'edubridge-9884a',
    storageBucket: 'edubridge-9884a.firebasestorage.app',
    iosBundleId: 'com.edubridge.edubridge',
  );
}
