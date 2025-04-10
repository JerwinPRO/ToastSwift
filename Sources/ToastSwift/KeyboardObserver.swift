//
//  KeyboardObserver.swift
//  ToastSwift
//
//  Created by Jerwin Metromart on 3/7/25.
//

import UIKit

final class KeyboardObserver {
    @MainActor
    static let shared = KeyboardObserver()
    
    private(set) var isKeyboardVisible = false
    
    init() {
        #if swift(>=4.2)
        let keyboardWillShowNotificationName = UIWindow.keyboardWillShowNotification
        let keyboardWillHideNotificationName = UIWindow.keyboardWillHideNotification
        #else
        let keyboardWillShowNotificationName = Notification.Name.UIKeyboardWillShow
        let keyboardWillHideNotificationName = Notification.Name.UIKeyboardWillHide
        #endif
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: keyboardWillShowNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: keyboardWillHideNotificationName, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        isKeyboardVisible = true
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        isKeyboardVisible = false
    }
}

