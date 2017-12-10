# Portannict
Unofficial annict client app for iOS

## Icon
<img src="http://i.imgur.com/F3xbXac.png"  width="160">

## UI
<img src="https://raw.githubusercontent.com/touyu/Annict-for-iOS/master/Docs/images/ScreenShot1.PNG" width="300">
<!--
<img src="http://i.imgur.com/LGcivTc.png" width="300">
<img src="http://i.imgur.com/PVPbnHw.png" width="300">
-->

## Setup

### Gem
```
$ bundle install --path vendor/bundle
```

### Download schema.json
```
$ apollo-codegen download-schema https://api.annict.com/graphql --header "Authorization: Bearer $TOKEN" --output schema.json
```

### Fastlane
- [README](https://github.com/touyu/Portannict/blob/master/fastlane/README.md)
