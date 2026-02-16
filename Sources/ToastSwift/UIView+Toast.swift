//
//  UIView+Toast.swift
//  ToastSwift
//
//  Merged from ToastKit - UIView extension for simplified toast display
//

import UIKit

public extension UIView {
    /// Shows a toast message with customizable attributes
    /// - Parameters:
    ///   - attributes: Toast configuration attributes
    ///   - buttonAction: Optional closure to handle button tap action
    func showToastMessage(
        with attributes: ToastAttributes,
        onButtonTap buttonAction: (() -> Void)? = nil
    ) {
        let toast = ToastKitView(with: attributes)
        addSubview(toast)
        
        toast.setConstraints(in: self)
        toast.animateWith(duration: attributes.duration, displayDuration: attributes.displayDuration)
        
        if let buttonAction = buttonAction {
            toast.onButtonTap = buttonAction
        }
    }
}
