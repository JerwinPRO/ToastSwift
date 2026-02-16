//
//  UIColor+Extension.swift
//  ToastSwift
//
//  Merged from ToastKit
//

import UIKit

public extension UIColor {
    /// Creates a UIColor from a hex string
    /// - Parameter hex: Hex color string (e.g., "#FF5733", "FF5733", "#fff")
    /// - Returns: UIColor, or black color if hex string is invalid
    static func colorWithHexString(_ hex: String) -> UIColor {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        // Validate hex string length (should be 3 or 6 characters)
        guard hexSanitized.count == 3 || hexSanitized.count == 6 else {
            print("Warning: Invalid hex color string '\(hex)'. Using black as fallback.")
            return .black
        }
        
        // Convert 3-character hex to 6-character hex
        if hexSanitized.count == 3 {
            hexSanitized = hexSanitized.map { "\($0)\($0)" }.joined()
        }
        
        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            print("Warning: Failed to parse hex color string '\(hex)'. Using black as fallback.")
            return .black
        }
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}
