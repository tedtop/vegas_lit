# Vegas Lit
MVP for a sportsbook application written in Flutter with Firebase backend

## General Troubleshooting
Make sure an app exists in Firebase for each build target (iOS, Android & Web), and the package names set up in Firebase match those in the manifest files in each 

### Install Flutter Dependencies
```
flutter pub run
```

## iOS build archive for distribution to TestFlight
```
flutter build ipa
```
Will generate an archive in `build/ios/archive`, open that in Xcode Organizer and `Distribute App` to push to TestFlight

## iOS Troubleshooting
### Install or update CocoaPods
```
sudo gem install cocoapods
pod repo update
pod install
pod update
```


### Clean build directory & rebuild
```
flutter clean
flutter build ipa
```

### Update SDK
```
flutter doctor
flutter upgrade
```

### Android
https://flutter.dev/docs/deployment/android#signing-the-app

## American Odds in Spreads vs. Moneylines
https://www.actionnetwork.com/education/american-odds#Vs

## JSON code generator for Dart, etc.
https://app.quicktype.io/

