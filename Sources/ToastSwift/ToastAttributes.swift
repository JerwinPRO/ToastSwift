//
//  ToastAttributes.swift
//  ToastSwift
//
//  Merged from ToastKit
//

import UIKit

public struct ToastAttributes {
    let contentInsets: UIEdgeInsets
    let containerInsets: UIEdgeInsets
    let cornerRadius: CGFloat
    
    let backgroundColor: UIColor
    let foregroundColor: UIColor
   
    let title: String?
    let message: String
    let titleFont: UIFont
    let messageFont: UIFont
    let titleMessageSpacing: CGFloat
    
    let buttonText: String
    let buttonTextFont: UIFont
    let showButton: Bool
    
    let position: ToastPosition
    let positionOffset: CGFloat
    
    let duration: TimeInterval
    let deadline: CGFloat
    
    public init(
        contentInsets: UIEdgeInsets = UIEdgeInsets(top: 10.0, left: 15.0, bottom: 10.0, right: 15.0),
        containerInsets: UIEdgeInsets = UIEdgeInsets(top: .zero, left: 13.0, bottom: .zero, right: 13.0),
        cornerRadius: CGFloat = 8.0,
        backgroundColor: UIColor = UIColor.colorWithHexString("#3C3C3C"),
        foregroundColor: UIColor = UIColor.white,
        title: String? = nil,
        message: String = "",
        titleFont: UIFont = .systemFont(ofSize: 17.0, weight: .semibold),
        messageFont: UIFont = .systemFont(ofSize: 15.0),
        titleMessageSpacing: CGFloat = 4.0,
        buttonText: String = "Button",
        buttonTextFont: UIFont = .systemFont(ofSize: 15.0),
        showButton: Bool = false,
        position: ToastPosition = .bottom,
        positionOffset: CGFloat = .zero,
        duration: TimeInterval = 0.5,
        deadline: CGFloat = 2.0
    ) {
        self.contentInsets = contentInsets
        self.containerInsets = containerInsets
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.title = title
        self.message = message
        self.titleFont = titleFont
        self.messageFont = messageFont
        self.titleMessageSpacing = titleMessageSpacing
        self.buttonText = buttonText
        self.buttonTextFont = buttonTextFont
        self.showButton = showButton
        self.position = position
        self.positionOffset = positionOffset
        self.duration = duration
        self.deadline = deadline
    }
}
