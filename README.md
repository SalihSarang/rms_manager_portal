# Manager Portal – Firebase Web Hosting

This README explains how to build and host this Flutter web app on Firebase Hosting.

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Firebase CLI](https://firebase.google.com/docs/cli)
- A Firebase project (created in [Firebase Console](https://console.firebase.google.com))
- Logged in to Firebase from terminal:

```bash
firebase login
```

## One-Time Setup

If Firebase is not initialized yet, run:
 
```bash
firebase init hosting
```

Use these selections:
- **Public directory**: `build/web`
- **Single-page app rewrite**: `Yes`
- **Set up automatic builds and deploys with GitHub**: optional
- **Overwrite `index.html`**: `No`

## Build Flutter Web

From project root:

```bash
flutter clean
flutter pub get
flutter build web --release
```

This creates production files in `build/web`.

## Deploy to Firebase Hosting

Deploy current build:

```bash
firebase deploy --only hosting
```

After deploy, Firebase prints the live hosting URL.

## Useful Commands

Deploy to a specific Firebase project:

```bash
firebase use <project-id>
firebase deploy --only hosting
```

Preview locally before deploy:

```bash
firebase emulators:start --only hosting
```

## Common Troubleshooting

- **Blank page after deploy**: ensure app is built using `flutter build web --release` before deploy.
- **404 on refresh/routes**: ensure Firebase Hosting rewrite to `/index.html` exists in `firebase.json`.
- **Wrong project deployed**: run `firebase use` and confirm the active project alias.

## Deployment Checklist

1. Confirm correct branch/code.
2. Run `flutter build web --release`.
3. Run `firebase deploy --only hosting: site name in firebase`.
4. Open hosting URL and test key pages.
