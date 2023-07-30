<p align="center">
  <img src="https://i.imgur.com/DLOp6Va.pngg" width=200>
</p>

# Portannict
⚠️ 現在、アプリの公開を停止しています。

:iphone: Elegant annict client app for iOS. 

<a href="https://apps.apple.com/jp/app/portannict/id1205227187?mt=8"><img src="https://linkmaker.itunes.apple.com/ja-jp/badge-lrg.svg?releaseDate=2017-03-30&kind=iossoftware&bubble=ios_apps"></a>

## Screenshot

<img src="https://i.imgur.com/HujaqTd.png" width=200>

## Requirements
- Xcode 11.2.1
- Swift 5.1.2
- iOS 11.0+

## SetUp

Create `.env` (BaseImageURL is currently undisclosed)
```
AnnictClientID="<ClientID>"
AnnictClientSecret="<ClientSecret>"
BaseImageURL="https://......."⏎
```

Resolve library dependencies
```
$ bundle install
$ bundle exex pod install
$ carthage bootstrap --platform iOS --cache-builds
```

Install apollo (option)
```
$ npm install
```

Download schema.json (option)
```
$ npx apollo schema:download --endpoint=https://api.annict.com/graphql schema.json --header="Authorization: Bearer <TOKEN>"
```
