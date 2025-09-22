import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  ///Note : Values available android/app/google-services.json
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyDQQIsbyv50lcmf5qHT_UHP-hscYmu55bw",
    appId: "1:346838759383:android:3ee3fd6770f50596823d92",
    messagingSenderId: "346838759383",
    projectId: "Voovi-1f23a",
    storageBucket: "Voovi-1f23a.firebasestorage.app",
  );

  ///Note : Values available ios/Runner/GoogleService-Info.plist
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "YOUR_API_KEY_HERE",
    appId: "YOUR_APP_ID_HERE",
    messagingSenderId: "YOUR_MESSAGING_SENDER_ID_HERE",
    projectId: "YOUR_PROJECT_ID_HERE",
    storageBucket: "YOUR_STORAGE_BUCKET_HERE.appspot.com",
    iosBundleId: "YOUR_IOS_BUNDLE_ID_HERE",
  );
}
