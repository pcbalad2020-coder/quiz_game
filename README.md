# quiz_game

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## iOS App Store release

The iOS project currently uses Google's sample AdMob app ID and test ad unit
IDs. iOS will continue to show test ads in both debug and release builds until
the app's real iOS AdMob app ID and ad unit IDs are configured. Flutter debug
builds use test ad units on both platforms; Android release builds continue to
use the existing Android production ad units.

Before submitting to App Store Connect:

1. Replace the `com.example.quizGame` bundle identifier in the Runner target
   with the identifier registered by the Apple Developer account that will
   publish the app.
2. Set up that Apple Developer team and signing profile in Xcode on macOS.
3. Replace the sample iOS AdMob app ID in `ios/Runner/Info.plist` and configure
   the real iOS ad unit IDs before enabling production ads.
4. Complete App Store Connect metadata, privacy disclosures, age rating, and
   review information for the app.

Build a signed App Store archive on macOS after configuring the bundle ID and
Apple signing:

```sh
flutter build ipa --release
```
