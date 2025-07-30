//
//  ToastAttributes.swift
//  ToastSwift
//
//  Created by Jayvee on 7/11/25.
//

import UIKit

@objc public class ToastAttributes: NSObject {
    @objc public var titleLabelText: String?
    @objc public var messageLabelText: String
    @objc public var buttonTitle: String
    
    @objc public var titleLabelFont: UIFont
    @objc public var messageLabelFont: UIFont
    @objc public var buttonTitleFont: UIFont
    
    @objc public var foregroundColor: UIColor
    @objc public var backgroundColor: UIColor
    
    @objc public var cornerRadius: CGFloat
    @objc public var contentInsets: UIEdgeInsets
    
    @objc public var showButton: Bool
    @objc public var shouldUseAttributedText: Bool
    @objc public var shouldUseAttributedButtonTitle: Bool
    
    @objc public var useSafeAreaForBottomOffset: Bool
    @objc public var maxWidthRatio: CGFloat
    
    @objc public var bottomOffsetPortrait: CGFloat
    @objc public var bottomOffsetLandscape: CGFloat
    
    @objc public var delay: TimeInterval
    @objc public var duration: TimeInterval
    
    @objc public var titleLabelAttributedText: NSAttributedString? {
        guard shouldUseAttributedText, let title = titleLabelText else { return nil }
        return NSAttributedString(
            string: title,
            attributes: [
                .font: titleLabelFont,
                .foregroundColor: foregroundColor
            ]
        )
    }
    
    @objc public var messageLabelAttributedText: NSAttributedString? {
        guard shouldUseAttributedText, !messageLabelText.isEmpty else { return nil }
        return NSAttributedString(
            string: messageLabelText,
            attributes: [
                .font: messageLabelFont,
                .foregroundColor: foregroundColor
            ]
        )
    }
    
    @objc public var buttonTitleAttributedText: NSAttributedString? {
        guard shouldUseAttributedButtonTitle, !buttonTitle.isEmpty else { return nil }
        return NSAttributedString(
            string: buttonTitle,
            attributes: [
                .font: buttonTitleFont,
                .foregroundColor: foregroundColor,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )
    }
    
    @objc public init(
        titleLabelText: String? = "Title here",
        messageLabelText: String = "message here",
        buttonTitle: String = "Button",
        titleLabelFont: UIFont = .systemFont(ofSize: 15),
        messageLabelFont: UIFont = .systemFont(ofSize: 13),
        buttonTitleFont: UIFont = .systemFont(ofSize: 13),
        foregroundColor: UIColor = .white,
        backgroundColor: UIColor = UIColor.colorWithHexString("#3C3C3C"),
        cornerRadius: CGFloat = 16.0,
        contentInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15),
        showButton: Bool = false,
        shouldUseAttributedText: Bool = true,
        shouldUseAttributedButtonTitle: Bool = true,
        useSafeAreaForBottomOffset: Bool = false,
        maxWidthRatio: CGFloat = 405 / 430,
        bottomOffsetPortrait: CGFloat = .zero,
        bottomOffsetLandscape: CGFloat = .zero,
        delay: TimeInterval = .zero,
        duration: TimeInterval = Delay.short
    ) {
        self.titleLabelText = titleLabelText
        self.messageLabelText = messageLabelText
        self.buttonTitle = buttonTitle
        self.titleLabelFont = titleLabelFont
        self.messageLabelFont = messageLabelFont
        self.buttonTitleFont = buttonTitleFont
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.contentInsets = contentInsets
        self.showButton = showButton
        self.shouldUseAttributedText = shouldUseAttributedText
        self.shouldUseAttributedButtonTitle = shouldUseAttributedButtonTitle
        self.useSafeAreaForBottomOffset = useSafeAreaForBottomOffset
        self.maxWidthRatio = maxWidthRatio
        self.bottomOffsetPortrait = bottomOffsetPortrait
        self.bottomOffsetLandscape = bottomOffsetLandscape
        self.delay = delay
        self.duration = duration
    }
}
