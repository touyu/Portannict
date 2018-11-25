# Portannict
:iphone: Annict Client App for iOS. Twitter-like UI.

# Troubleshooting

## Install ReactorKit using Carthage
ReactorKit does not officially support Carthage.
https://github.com/ReactorKit/ReactorKit#installation

Therefore, special operation is required.

```
carthage update 2>/dev/null
(d Carthage/Checkouts/ReactorKit
swift package generate-xcodeproj
carthage build
```

