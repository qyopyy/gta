# PlayGTA iOS app

A thin full-screen iPhone/iPad app (landscape, screen stays awake) that opens your PlayGTA server page, which
supplies the joysticks and buttons. On first launch it asks for the server address; four-finger tap changes it.

## Get the IPA (no Mac needed)
1. Create a new GitHub repo (e.g. `playgta-ios`) and upload everything in this folder, including `.github/`.
2. Actions tab → "Build iOS IPA" → Run workflow. ~5 min later the IPA is under Releases.

## Install
The IPA is unsigned. Install it with Sideloadly or AltStore on a computer (they sign it with your Apple ID;
free Apple IDs need re-signing every 7 days). TestFlight/App Store need a paid Apple Developer account.

## Server
Run PlayGTA (`bun start`) and enter its LAN address, or an https tunnel URL, in the app.
