<p align="center">
  <img src="https://i.imgur.com/DLOp6Va.pngg" width=200>
</p>

# Portannict
:iphone: Elegant annict client app for iOS. 

<a href="https://apps.apple.com/jp/app/portannict/id1205227187?mt=8"><img src="https://linkmaker.itunes.apple.com/ja-jp/badge-lrg.svg?releaseDate=2017-03-30&kind=iossoftware&bubble=ios_apps"></a>

## Screenshot

<img src="https://i.imgur.com/HujaqTd.png" width=200>

## Requirements
- Xcode 11.2.1
- Swift 5.1.2
- iOS 11.0+

## SetUp

Create `.env`
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
