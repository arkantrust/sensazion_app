# 📦 Building the Android App

This document explains how to build and install the Android version of our Flutter app. (iOS support coming soon.)

## 🛠️ Build Commands

To build release APKs for Android (split by ABI), run:

```bash
flutter build apk --release --split-per-abi
```

This generates multiple APKs in `build/app/outputs/apk/release/`, one for each architecture (e.g., `arm64-v8a`, `armeabi-v7a`, etc.).

> Most modern android devices use `arm64-v8a`.

### Why split by ABI?

* 🔽 **Smaller APKs**: Devices download only what they need, reducing download and install size.
* 🚀 **Better performance**: Minified code and assets = faster app load times.
* 📦 **Avoids fat APKs**: A single APK with all ABIs is large and inefficient.

## 📲 Install on Device

To install the generated APK (e.g., `arm64-v8a`) on your device:

```bash
flutter install --use-application-binary=./build/app/outputs/apk/release/app-arm64-v8a-release.apk
```

> Make sure the connected device matches the target ABI.

## 📚 About App Bundles

[Official Flutter docs on building AABs](https://docs.flutter.dev/deployment/android#build-an-app-bundle)

We currently prefer APKs for direct installs because:

* 🧪 **App Bundles sometimes break**: AABs can introduce issues during Google Play testing or internal QA.
* 🔍 **Harder to test locally**: AABs need Play Store or bundletool to install, which complicates device testing.

We may switch to AABs for Play Store deployment once our CI/CD pipeline covers it reliably.
