//
//  ToastKitView.swift
//  ToastSwift
//
//  Merged from ToastKit - Enhanced toast view with button and title support
//

import UIKit

public class ToastKitView: UIView {
    
    //MARK: - Properties
    
    private var attributes: ToastAttributes!
    private(set) var onButtonTap: (() -> Void)?
    
    //MARK: - Initializations
    
    init(with attributesParam: ToastAttributes) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = attributesParam.backgroundColor
        layer.cornerRadius = attributesParam.cornerRadius
        
        attributes = attributesParam
        
        let titleLabel = setupTitleLabel(attributesParam)
        let messageLabel = setupMessageLabel(attributesParam)
        let button = setupButton(attributesParam)
    
        let vStack = UIStackView(arrangedSubviews: [titleLabel, messageLabel])
        vStack.axis = .vertical
        vStack.spacing = attributesParam.titleMessageSpacing
        
        let subView: UIView
        
        if attributesParam.showButton {
            let hStack = UIStackView(arrangedSubviews: [vStack, button])
            hStack.axis = .horizontal
            hStack.alignment = .center
            hStack.spacing = 12
            
            subView = hStack
        } else {
            subView = vStack
        }
       
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: topAnchor, constant: attributesParam.contentInsets.top),
            subView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -attributesParam.contentInsets.bottom),
            subView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: attributesParam.contentInsets.left),
            subView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -attributesParam.contentInsets.right)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setup

private extension ToastKitView {
    func setupTitleLabel(_ attributes: ToastAttributes) -> UILabel {
        let titleLabel = UILabel()
        
        if let title = attributes.title, !title.isEmpty {
            let attributedText = NSAttributedString(
                string: title,
                attributes: [
                    .font: attributes.titleFont,
                    .foregroundColor: attributes.foregroundColor
                ]
            )
            
            titleLabel.attributedText = attributedText
        }
        
        titleLabel.numberOfLines = 0
        return titleLabel
    }
    
    func setupMessageLabel(_ attributes: ToastAttributes) -> UILabel {
        let messageLabel = UILabel()
        
        let attributedText = NSAttributedString(
            string: attributes.message,
            attributes: [
                .font: attributes.messageFont,
                .foregroundColor: attributes.foregroundColor
            ]
        )
        
        messageLabel.attributedText = attributedText
        messageLabel.numberOfLines = 0
        
        return messageLabel
    }
    
    func setupButton(_ attributes: ToastAttributes) -> UIButton {
        let button = UIButton(type: .system)
        let attributedTitle = NSAttributedString(
            string: attributes.buttonText,
            attributes: [
                .font: attributes.buttonTextFont,
                .foregroundColor: attributes.foregroundColor,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.tintColor = attributes.foregroundColor
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return button
    }
}

//MARK: - Public method/s

extension ToastKitView {
    func setConstraints(in view: UIView) {
        let safeAreaInsets = view.safeAreaInsets
        
        switch attributes.position {
        case .top:
            let topInset = safeAreaInsets.top
            let topOffset = (topInset > 0 ? attributes.positionOffset : attributes.positionOffset + 16)
            
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: attributes.containerInsets.left),
                trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -attributes.containerInsets.right),
                topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topOffset)
            ])
            
        case .center:
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: attributes.containerInsets.left),
                trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -attributes.containerInsets.right),
                centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: attributes.positionOffset)
            ])
            
        case .bottom:
            let bottomInset = safeAreaInsets.bottom
            let bottomOffset = (bottomInset > 0 ? -attributes.positionOffset : -(attributes.positionOffset + 16))
            
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: attributes.containerInsets.left),
                trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -attributes.containerInsets.right),
                bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bottomOffset)
            ])
        }
    }
    
    func animateWith(duration: TimeInterval, displayDuration: CGFloat) {
        alpha = 0
        
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        }) { [weak self] _ in
            guard let self = self else { return }
            
            // Wait for `displayDuration` seconds, then fade out
            DispatchQueue.main.asyncAfter(deadline: .now() + displayDuration) { [weak self] in
                guard let self = self else { return }
                
                // Fade Out
                UIView.animate(withDuration: duration, animations: { [weak self] in
                    self?.alpha = 0
                }) { [weak self] _ in
                    self?.removeFromSuperview()
                }
            }
        }
    }
}

//MARK: - Action/s

extension ToastKitView {
    @objc private func buttonTapped() {
        onButtonTap?()
    }
}
