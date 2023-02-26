# ColorChangingLabel
The long-awaited text changing property of UILabel has arrived! 🥳

### How to use

After you set up the label, you can change its color like:

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

### Example

<p style="text-align:center;"><img src="https://github.com/stateman92/ColorChangingLabel/blob/main/Resources/screenrecording.gif?raw=true" width="50%" alt="Example"></p>
