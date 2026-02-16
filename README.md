# ToastSwift

ToastSwift is a lightweight and user-friendly library written in Swift for creating stunning toast notifications in iOS applications. 

## Features

- Easy to integrate into any Swift project.
- Highly customizable toast messages with colors, fonts, padding, corner radius, and more 🎨
- Supports positioning: top, center, or bottom 🧭
- Add a button for user interaction (optional) 🖱️
- Support for title and message labels
- Queue-based toast management system
- Accessibility support
- Lightweight and efficient.

## Getting Started

### Prerequisites
- Xcode 12.0 or later
- iOS 15.0 or later
- Swift 5.0 or later

### Installation

#### Manual Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/JerwinPRO/ToastSwift.git
   ```
2. Add `ToastSwift` to your project.

#### Swift Package Manager
1. In Xcode, go to `File > Swift Packages > Add Package Dependency`.
2. Enter the repository URL: `https://github.com/JerwinPRO/ToastSwift`.
3. Follow the prompts to complete the installation.

## Usage

### Method 1: Using UIView Extension (New - Simplified API)

This is the simplest way to show toast messages with full customization support.

#### Basic Toast
```swift
import ToastSwift

// Show a simple toast message
let attributes = ToastAttributes(message: "Hello, World!")
view.showToastMessage(with: attributes)
```

#### Toast with Title and Message
```swift
import ToastSwift

let attributes = ToastAttributes(
    title: "Success",
    message: "Your operation completed successfully"
)
view.showToastMessage(with: attributes)
```

#### Toast with Button
```swift
import ToastSwift

let attributes = ToastAttributes(
    message: "Would you like to undo?",
    showButton: true,
    buttonText: "Undo"
)

view.showToastMessage(with: attributes) {
    print("Undo button tapped!")
    // Handle button action here
}
```

#### Fully Customized Toast
```swift
import ToastSwift

let attributes = ToastAttributes(
    contentInsets: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16),
    cornerRadius: 12,
    backgroundColor: .colorWithHexString("#2C2C2E"),
    foregroundColor: .white,
    title: "Custom Title",
    message: "This is a fully customized toast message",
    titleFont: .systemFont(ofSize: 17, weight: .bold),
    messageFont: .systemFont(ofSize: 15),
    titleMessageSpacing: 6,
    position: .top,  // Can be .top, .center, or .bottom
    positionOffset: 20,
    duration: 0.5,
    deadline: 3.0
)

view.showToastMessage(with: attributes)
```

### Method 2: Using Original Queue-Based API

The original ToastSwift API with queue management for sequential toasts.

#### Basic Toast
```swift
import ToastSwift

let toast = ToastSwift(text: "This is a test toast")
toast.show()
```

#### Customizable Toast
```swift
import ToastSwift

let toast = ToastSwift(
    text: "Custom Toast",
    backgroundColor: .black,
    duration: Delay.long
)
toast.show()
```

### Position Options

ToastSwift now supports three positioning options:
- `.top` - Display toast at the top of the screen
- `.center` - Display toast in the center of the screen
- `.bottom` - Display toast at the bottom of the screen (default)

### Using Hex Colors

You can easily use hex color codes:
```swift
let attributes = ToastAttributes(
    backgroundColor: .colorWithHexString("#FF5733"),
    foregroundColor: .colorWithHexString("#FFFFFF"),
    message: "Toast with hex colors"
)
```

## Contribution
Contributions are welcome! To contribute:
1. Fork the repository.
2. Create a feature branch: `git checkout -b feature-name`.
3. Commit your changes: `git commit -m 'Add new feature'`.
4. Push to the branch: `git push origin feature-name`.
5. Open a pull request.

## License
This project is currently not licensed. For any usage, please contact the repository owner.

## Contact
For questions or support, please create an issue in the repository or reach out to [JerwinPRO](https://github.com/JerwinPRO).
