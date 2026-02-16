# ToastSwift Examples

This file demonstrates various ways to use ToastSwift after merging features from ToastKit.

## Example 1: Simple Toast Message

```swift
import UIKit
import ToastSwift

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show a simple toast with default settings
        let attributes = ToastAttributes(message: "Hello, World!")
        view.showToastMessage(with: attributes)
    }
}
```

## Example 2: Toast with Title and Message

```swift
let attributes = ToastAttributes(
    title: "Success",
    message: "Your data has been saved successfully"
)
view.showToastMessage(with: attributes)
```

## Example 3: Toast at Different Positions

```swift
// Top position
let topAttributes = ToastAttributes(
    message: "This toast appears at the top",
    position: .top,
    positionOffset: 20
)
view.showToastMessage(with: topAttributes)

// Center position
let centerAttributes = ToastAttributes(
    message: "This toast appears in the center",
    position: .center
)
view.showToastMessage(with: centerAttributes)

// Bottom position (default)
let bottomAttributes = ToastAttributes(
    message: "This toast appears at the bottom",
    position: .bottom
)
view.showToastMessage(with: bottomAttributes)
```

## Example 4: Toast with Button

```swift
let attributes = ToastAttributes(
    title: "Action Required",
    message: "Would you like to enable notifications?",
    showButton: true,
    buttonText: "Enable"
)

view.showToastMessage(with: attributes) {
    print("Enable button tapped!")
    // Handle the action here
}
```

## Example 5: Fully Customized Toast

```swift
let attributes = ToastAttributes(
    contentInsets: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16),
    containerInsets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16),
    cornerRadius: 12,
    backgroundColor: .colorWithHexString("#2C2C2E"),
    foregroundColor: .white,
    title: "Custom Toast",
    message: "This is a fully customized toast with custom colors, fonts, and spacing",
    titleFont: .systemFont(ofSize: 17, weight: .bold),
    messageFont: .systemFont(ofSize: 15),
    titleMessageSpacing: 6,
    buttonText: "Dismiss",
    buttonTextFont: .systemFont(ofSize: 15, weight: .medium),
    showButton: false,
    position: .bottom,
    positionOffset: 30,
    duration: 0.5,
    displayDuration: 3.0
)

view.showToastMessage(with: attributes)
```

## Example 6: Using Hex Colors

```swift
let attributes = ToastAttributes(
    backgroundColor: .colorWithHexString("#FF5733"),
    foregroundColor: .colorWithHexString("#FFFFFF"),
    message: "This toast uses hex colors"
)
view.showToastMessage(with: attributes)
```

## Example 7: Toast with Long Message

```swift
let attributes = ToastAttributes(
    title: "Information",
    message: "This is a longer message that demonstrates how the toast view handles multi-line text content gracefully. The view will automatically adjust its height to fit the content.",
    titleMessageSpacing: 8
)
view.showToastMessage(with: attributes)
```

## Example 8: Quick Toast with Custom Duration

```swift
// Show for 5 seconds
let attributes = ToastAttributes(
    message: "This toast will stay for 5 seconds",
    duration: 0.5,  // Fade in/out animation duration
    displayDuration: 5.0   // How long to stay visible
)
view.showToastMessage(with: attributes)
```

## Example 9: Using Original ToastSwift API (Queue-based)

You can still use the original ToastSwift API for queue management:

```swift
// Show a simple toast
let toast = ToastSwift(text: "This is the original API")
toast.show()

// Show multiple toasts in sequence (they will queue)
let toast1 = ToastSwift(text: "First toast", duration: Delay.short)
let toast2 = ToastSwift(text: "Second toast", duration: Delay.long)
toast1.show()
toast2.show()  // This will show after toast1 finishes
```

## Example 10: Custom Initializer Extension

You can create your own extension for commonly used toast styles:

```swift
extension ToastAttributes {
    static func success(message: String) -> ToastAttributes {
        return ToastAttributes(
            backgroundColor: .colorWithHexString("#4CAF50"),
            foregroundColor: .white,
            title: "Success",
            message: message,
            position: .top,
            positionOffset: 20
        )
    }
    
    static func error(message: String) -> ToastAttributes {
        return ToastAttributes(
            backgroundColor: .colorWithHexString("#F44336"),
            foregroundColor: .white,
            title: "Error",
            message: message,
            position: .top,
            positionOffset: 20
        )
    }
    
    static func info(message: String) -> ToastAttributes {
        return ToastAttributes(
            backgroundColor: .colorWithHexString("#2196F3"),
            foregroundColor: .white,
            title: "Info",
            message: message,
            position: .center
        )
    }
}

// Usage:
view.showToastMessage(with: .success(message: "Operation completed"))
view.showToastMessage(with: .error(message: "Something went wrong"))
view.showToastMessage(with: .info(message: "Please note this information"))
```

## Example 11: Toast with Undo Action

```swift
let attributes = ToastAttributes(
    message: "Item deleted",
    showButton: true,
    buttonText: "Undo"
)

view.showToastMessage(with: attributes) {
    // Restore the deleted item
    print("Undo delete action")
}
```

## Example 12: Dark and Light Mode Support

```swift
let attributes = ToastAttributes(
    backgroundColor: UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark
            ? .colorWithHexString("#3C3C3C")
            : .colorWithHexString("#F5F5F5")
    },
    foregroundColor: UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark
            ? .white
            : .black
    },
    message: "This toast adapts to dark/light mode"
)
view.showToastMessage(with: attributes)
```
