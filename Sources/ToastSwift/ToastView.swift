//
//  ToastView.swift
//  ToastSwift
//
//  Created by Jerwin Metromart on 3/7/25.
//

import UIKit

open class ToastView: UIView {

    //MARK: - Properties
    
    private let bottomOffsetPortrait: CGFloat = {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone: return 39
        case .pad: return 60
        case .tv: return 90
        case .carPlay: return 30
        case .mac: return 60
        case .vision: return 60
        case .unspecified: fallthrough
        @unknown default: return 3
        }
    }()

    private let bottomOffsetLandscape: CGFloat = {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone: return 39
        case .pad: return 40
        case .tv: return 60
        case .carPlay: return 20
        case .mac: return 40
        case .vision: return 40
        case .unspecified: fallthrough
        @unknown default: return 20
        }
    }()
    
    private lazy var containerSize: CGSize = {
        let containerSize = UIScreen.main.bounds.size
        let constraintSize = CGSize(
            width: containerSize.width * attributes.maxWidthRatio,
            height: CGFloat.greatestFiniteMagnitude
        )
        
        return containerSize
    }()
    
    public var onButtonTap: (() -> Void)?
    
    private var _attributes: ToastAttributes = ToastAttributes()
    
    open var attributes: ToastAttributes {
        get { _attributes }
        set { _attributes = newValue }
    }
    
    //MARK: - User Interface
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 16
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.textAlignment = .left
        return label
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.textAlignment = .left
        return label
    }()

    public lazy var actionButton: UIButton = { [unowned self] in
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .zero
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = .zero
        stackView.distribution = .fill
        return stackView
    }()
    
    //MARK: - Initialization
    
    public convenience init() {
        self.init(frame: .zero)

        setupSubviews()
    }
    
    required convenience public init?(coder: NSCoder) {
        self.init()
    }
    
    //MARK: - Layout
    
    override open func layoutSubviews() {
        super.layoutSubviews()
      
        layoutContent()
        updateFrame()
    }
}

//MARK: - Setup

private extension ToastView {
    func setupSubviews() {
        isUserInteractionEnabled = true
        
        addSubview(backgroundView)
        addSubview(horizontalStackView)
        
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(messageLabel)
        
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(actionButton)
    }
    
    func layoutContent() {
        let containerSize = UIScreen.main.bounds.size
        let constraintSize = CGSize(
            width: containerSize.width * attributes.maxWidthRatio,
            height: CGFloat.greatestFiniteMagnitude
        )
        
        let textLabelSize = titleLabel.sizeThatFits(constraintSize)
        titleLabel.frame = CGRect(
            x: .zero,
            y: attributes.contentInsets.top,
            width: textLabelSize.width - attributes.contentInsets.left - attributes.contentInsets.right,
            height: textLabelSize.height
        )
        
        let messageLabelSize = messageLabel.sizeThatFits(constraintSize)
        messageLabel.frame = CGRect(
            x: .zero,
            y: attributes.contentInsets.top,
            width: messageLabelSize.width - attributes.contentInsets.left - attributes.contentInsets.right,
            height: messageLabelSize.height
        )
        
        verticalStackView.frame = CGRect(
            x: attributes.contentInsets.left,
            y: attributes.contentInsets.top,
            width: constraintSize.width - attributes.contentInsets.left - attributes.contentInsets.right,
            height: textLabelSize.height + messageLabelSize.height
        )
        
        horizontalStackView.frame = CGRect(
            x: attributes.contentInsets.left,
            y: attributes.contentInsets.top,
            width: constraintSize.width - attributes.contentInsets.left - attributes.contentInsets.right,
            height: verticalStackView.frame.size.height
        )
        
        backgroundView.frame = CGRect(
            x: .zero,
            y: .zero,
            width: constraintSize.width,
            height: horizontalStackView.frame.height + attributes.contentInsets.top + attributes.contentInsets.bottom
        )
    }
    
    func updateFrame () {
        var x: CGFloat = .zero
        var y: CGFloat = .zero
        var width: CGFloat = .zero
        var height: CGFloat = .zero
        
        var orientation: UIInterfaceOrientation = .portrait
        
        if #available(iOS 13.0, *) {
            if let interfaceOrientation = window?.windowScene?.interfaceOrientation {
                orientation = interfaceOrientation
            }
        } else {
            orientation = UIApplication.shared.statusBarOrientation
        }
        
        if orientation.isPortrait || !ToastWindow.shared.shouldRotateManually {
            width = containerSize.width
            height = containerSize.height
            y = attributes.bottomOffsetPortrait > .zero ? attributes.bottomOffsetPortrait : bottomOffsetPortrait
        } else {
            width = containerSize.height
            height = containerSize.width
            y = attributes.bottomOffsetLandscape > .zero ? attributes.bottomOffsetLandscape : bottomOffsetLandscape
        }
        
        if #available(iOS 11.0, *), attributes.useSafeAreaForBottomOffset {
            y += ToastWindow.shared.safeAreaInsets.bottom
        }
        
        let backgroundViewSize = backgroundView.frame.size
        x = (width - backgroundViewSize.width) * 0.5
        y = height - (backgroundViewSize.height + y)
        
        frame = CGRect(
            x: x,
            y: y,
            width: backgroundViewSize.width,
            height: backgroundViewSize.height
        )
    }
}

//MARK: - Binding

extension ToastView {
    func bind(with attributesParam: ToastAttributes) {
        attributes = attributesParam
        
        backgroundView.backgroundColor = attributesParam.backgroundColor
        backgroundView.layer.cornerRadius = attributesParam.cornerRadius
        
        if attributes.shouldUseAttributedText {
            titleLabel.attributedText = attributesParam.titleLabelAttributedText
            messageLabel.attributedText = attributesParam.messageLabelAttributedText
        } else {
            titleLabel.text = attributesParam.titleLabelText
            titleLabel.font = attributesParam.titleLabelFont
            titleLabel.textColor = attributesParam.foregroundColor
            
            messageLabel.text = attributesParam.messageLabelText
            messageLabel.font = attributesParam.messageLabelFont
            messageLabel.textColor = attributesParam.foregroundColor
        }
        
        if attributesParam.shouldUseAttributedButtonTitle {
            actionButton.setAttributedTitle(attributesParam.buttonTitleAttributedText, for: .normal)
        } else {
            actionButton.setTitle(attributesParam.buttonTitle, for: .normal)
        }
    }
}

//MARK: - Action

extension ToastView {
    @objc private func buttonTapped() {
        onButtonTap?()
    }
}



