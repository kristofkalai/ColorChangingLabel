# ColorChangingLabel
The long-awaited text changing property of UILabel has arrived! 🥳

## Setup

Add the following to `Package.swift`:

```swift
.package(url: "https://github.com/stateman92/ColorChangingLabel", exact: .init(0, 0, 5))
```

[Or add the package in Xcode.](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)

## Usage

```swift
label.change(toColor: .blue, duration: 2) {
    if $0 {
        // do something if the animation is finished
    } else {
        // do something if the animation is cancelled
    }
}
```

For details see the Example app.

## Example

<p style="text-align:center;"><img src="https://github.com/stateman92/ColorChangingLabel/blob/main/Resources/screenrecording.gif?raw=true" width="50%" alt="Example"></p>
