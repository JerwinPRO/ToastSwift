# Feature Comparison: ToastSwift Before and After Merge

This document outlines the features that were merged from [ToastKit](https://github.com/lcaxgg/ToastKit.git) into ToastSwift.

## Overview

ToastSwift now combines the best of both libraries:
- **ToastSwift's** robust queue-based management system and accessibility features
- **ToastKit's** flexible attribute-based configuration and enhanced UI capabilities

## New Features Added

### 1. ToastPosition Enum
**From:** ToastKit  
**Description:** Support for positioning toasts at top, center, or bottom of the screen

```swift
public enum ToastPosition {
    case top
    case center
    case bottom
}
```

**Before:** Only bottom position was available  
**After:** Three position options with custom offsets

### 2. ToastAttributes Struct
**From:** ToastKit  
**Description:** Comprehensive configuration structure for all toast customization

**Key Properties:**
- `contentInsets` - Padding inside the toast
- `containerInsets` - Margins around the toast
- `cornerRadius` - Toast corner radius
- `backgroundColor` - Toast background color
- `foregroundColor` - Text and button color
- `title` - Optional title text
- `message` - Main message text
- `titleFont` - Font for title
- `messageFont` - Font for message
- `titleMessageSpacing` - Spacing between title and message
- `buttonText` - Text for action button
- `buttonTextFont` - Font for button text
- `showButton` - Whether to show action button
- `position` - Toast position (top/center/bottom)
- `positionOffset` - Additional offset from position
- `duration` - Animation duration
- `deadline` - Display duration

**Before:** Settings scattered across multiple properties  
**After:** Single structured configuration object

### 3. UIColor Extension
**From:** ToastKit  
**Description:** Easy hex color creation

```swift
public extension UIColor {
    static func colorWithHexString(_ hex: String) -> UIColor
}
```

**Usage:**
```swift
let color = UIColor.colorWithHexString("#3C3C3C")
```

**Before:** Required manual RGB values  
**After:** Simple hex string support

### 4. Title + Message Support
**From:** ToastKit  
**Description:** Display both title and message in the same toast

**Implementation:**
- Separate labels for title and message
- Customizable fonts for each
- Adjustable spacing between them

**Before:** Single text label only  
**After:** Dual label with flexible configuration

### 5. Button Support
**From:** ToastKit  
**Description:** Interactive button with custom action

**Features:**
- Optional button display
- Customizable button text and font
- Underlined button text for clarity
- Callback closure for button tap

**Usage:**
```swift
let attributes = ToastAttributes(
    message: "Item deleted",
    showButton: true,
    buttonText: "Undo"
)
view.showToastMessage(with: attributes) {
    // Handle button action
}
```

**Before:** Button support existed but was commented out  
**After:** Fully functional button with action callback

### 6. UIView Extension
**From:** ToastKit  
**Description:** Simplified API for showing toasts

```swift
public extension UIView {
    func showToastMessage(
        with attributes: ToastAttributes,
        onButtonTap buttonAction: (() -> Void)? = nil
    )
}
```

**Before:** Required creating ToastSwift object and calling show()  
**After:** Single method call on any UIView

### 7. Enhanced ToastKitView
**From:** ToastKit (adapted)  
**Description:** New view implementation supporting all ToastKit features

**Features:**
- UIStackView-based layout
- Support for title + message
- Button integration
- Position-aware constraints
- Smooth animations

**Before:** ToastView with limited customization  
**After:** ToastKitView with full feature set

## Feature Matrix

| Feature | ToastSwift (Original) | ToastKit | ToastSwift (Merged) |
|---------|----------------------|----------|---------------------|
| Queue Management | ✅ | ❌ | ✅ |
| Accessibility | ✅ | ❌ | ✅ |
| Bottom Position | ✅ | ✅ | ✅ |
| Top Position | ❌ | ✅ | ✅ |
| Center Position | ❌ | ✅ | ✅ |
| Title Support | ❌ | ✅ | ✅ |
| Message Support | ✅ | ✅ | ✅ |
| Button Support | Partial | ✅ | ✅ |
| Button Callback | ❌ | ✅ | ✅ |
| Hex Colors | ❌ | ✅ | ✅ |
| Attributes Config | ❌ | ✅ | ✅ |
| UIView Extension | ❌ | ✅ | ✅ |
| Custom Fonts | ✅ | ✅ | ✅ |
| Custom Insets | ✅ | ✅ | ✅ |
| Corner Radius | ✅ | ✅ | ✅ |

## API Comparison

### Original ToastSwift API
```swift
// Still available and fully functional
let toast = ToastSwift(text: "Hello")
toast.show()
```

### New Simplified API (from ToastKit)
```swift
// New, simpler approach
let attributes = ToastAttributes(message: "Hello")
view.showToastMessage(with: attributes)
```

### Advanced Usage
```swift
// Full customization with new features
let attributes = ToastAttributes(
    backgroundColor: .colorWithHexString("#3C3C3C"),
    foregroundColor: .white,
    title: "Success",
    message: "Operation completed",
    showButton: true,
    buttonText: "View",
    position: .top,
    positionOffset: 20
)
view.showToastMessage(with: attributes) {
    print("Button tapped!")
}
```

## Backward Compatibility

✅ **All original ToastSwift APIs remain functional**
- Existing code continues to work without modification
- Original queue management system intact
- Original ToastView and ToastWindow classes unchanged
- Both APIs can be used together

## Migration Guide

### From Original ToastSwift
```swift
// Before
let toast = ToastSwift(text: "Hello")
toast.show()

// After (optional migration)
let attributes = ToastAttributes(message: "Hello")
view.showToastMessage(with: attributes)
```

### From ToastKit
```swift
// Before (in ToastKit)
let attributes = ToastAttributes(message: "Hello")
view.showToastMessage(with: attributes)

// After (in merged ToastSwift)
let attributes = ToastAttributes(message: "Hello")
view.showToastMessage(with: attributes)
// Same API! Direct migration!
```

## Summary

The merge successfully combines:
1. **ToastSwift's strengths**: Queue management, accessibility, window handling
2. **ToastKit's strengths**: Flexible configuration, enhanced UI, simpler API

Result: A comprehensive toast notification library with maximum flexibility and ease of use.
