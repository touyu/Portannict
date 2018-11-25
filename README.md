# Portannict
:iphone: Annict Client App for iOS. Twitter-like UI.

# Troubleshooting

## Install ReactorKit using Carthage
ReactorKit does not officially support Carthage.
https://github.com/ReactorKit/ReactorKit#installation

Therefore, special operation is required.
According to the official, we do as follows.

```
$ carthage update 2>/dev/null
$ cd Carthage/Checkouts/ReactorKit
$ swift package generate-xcodeproj
$ carthage build
```
However, this will make Deployment Target the latest iOS version.
So, you need to change the deployment target of Reactorkit.

"Build Settings" -> "iOS Deployment Target" -> "iOS 11.0"


