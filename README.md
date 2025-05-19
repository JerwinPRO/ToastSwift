# ToastSwift

ToastSwift is a lightweight and user-friendly library written in Swift for creating stunning toast notifications in iOS applications. 

## Features

- Easy to integrate into any Swift project.
- Offers customizable toast messages.
- Lightweight and efficient.

## Getting Started

### Prerequisites
- Xcode 12.0 or later
- iOS 12.0 or later
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

### Basic Toast
To display a simple toast notification:
```swift
import ToastSwift

Toast.show(message: "This is a test toast", duration: 2.0)
```

### Customizable Toast
You can customize the appearance of the toast by specifying options like background color, text color, and position.

```swift
import ToastSwift

let options = ToastOptions(
    backgroundColor: UIColor.black,
    textColor: UIColor.white,
    position: .bottom
)

Toast.show(message: "Custom Toast", options: options, duration: 3.0)
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
