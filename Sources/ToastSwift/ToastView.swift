//
//  ToastView.swift
//  ToastSwift
//
//  Created by Jerwin Metromart on 3/7/25.
//

import UIKit

open class ToastView: UIView {
   
    // MARK: - Properties
    
    open var text: String? {
        get { return self.textLabel.text }
        set { self.textLabel.text = newValue }
    }
    
    open var attributedText: NSAttributedString? {
        get { return self.textLabel.attributedText }
        set { self.textLabel.attributedText = newValue }
    }
    
    open var hideActionButton: Bool? {
        get { return self.actionTextLabel.isHidden }
        set { self.actionTextLabel.isHidden = newValue ?? true }
    }
    
    // MARK: - Appearance
    
    override open dynamic var backgroundColor: UIColor? {
        get { return self.backgroundView.backgroundColor }
        set { self.backgroundView.backgroundColor = newValue }
    }
    
    @objc open dynamic var cornerRadius: CGFloat {
        get { return self.backgroundView.layer.cornerRadius }
        set { self.backgroundView.layer.cornerRadius = newValue }
    }
    
    @objc public var contentInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    
    @objc open dynamic var textColor: UIColor {
        get { return self.textLabel.textColor }
        set { self.textLabel.textColor = newValue }
    }
    
    @objc open dynamic var font: UIFont {
        get { return self.textLabel.font }
        set { self.textLabel.font = newValue }
    }
    
    @objc open dynamic var bottomOffsetPortrait: CGFloat = {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone: return 39 // Figma design
        case .pad: return 60
        case .tv: return 90
        case .carPlay: return 30
        case .mac: return 60
        case .vision: return 60
            // default values
        case .unspecified: fallthrough
        @unknown default: return 3
        }
    }()
    
    @objc open dynamic var bottomOffsetLandscape: CGFloat = {
        switch UIDevice.current.userInterfaceIdiom {
            // specific values
        case .phone: return 39 // Figma design
        case .pad: return 40
        case .tv: return 60
        case .carPlay: return 20
        case .mac: return 40
        case .vision: return 40
            // default values
        case .unspecified: fallthrough
        @unknown default: return 20
        }
    }()
    
    @objc open dynamic var useSafeAreaForBottomOffset: Bool = false
    
    @objc open dynamic var maxWidthRatio: CGFloat = (405 / 430) //Figma UI design width / canvas width
    
    @objc open dynamic var shadowPath: CGPath? {
      get { return self.layer.shadowPath }
      set { self.layer.shadowPath = newValue }
    }
    
    @objc open dynamic var shadowColor: UIColor? {
      get { return self.layer.shadowColor.flatMap { UIColor(cgColor: $0) } }
      set { self.layer.shadowColor = newValue?.cgColor }
    }
    
    @objc open dynamic var shadowOpacity: Float {
      get { return self.layer.shadowOpacity }
      set { self.layer.shadowOpacity = newValue }
    }
    
    @objc open dynamic var shadowOffset: CGSize {
      get { return self.layer.shadowOffset }
      set { self.layer.shadowOffset = newValue }
    }
    
    @objc open dynamic var shadowRadius: CGFloat {
      get { return self.layer.shadowRadius }
      set { self.layer.shadowRadius = newValue }
    }

    
    // MARK: - User Interface
    
    private lazy var backgroundView: UIView = {
        let `self` = UIView()
        self.backgroundColor = UIColor(red: 0.24, green: 0.24, blue: 0.24, alpha: 1.00)
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 16
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        return self
    }()
    
    private lazy var textLabel: UILabel = {
        let `self` = UILabel()
        self.textColor = .white
        self.backgroundColor = .clear
        self.font = UIFont.systemFont(ofSize: 13.5)
        self.numberOfLines = 0
        self.textAlignment = .left
        return self
    }()
    
    private lazy var actionTextLabel: UILabel = {
        let `self` = UILabel()
        self.textColor = .white
        self.backgroundColor = .clear
        self.font = UIFont.systemFont(ofSize: 13.5)
        self.numberOfLines = 0
        self.textAlignment = .center
        return self
    }()
    
    private lazy var columnStackView: UIStackView = {
        let `self` = UIStackView()
        self.axis = .horizontal
        self.spacing = 16
        self.distribution = .fill
        return self
    }()
    
    
    //MARK: Initializing

    public convenience init() {
        self.init(frame: .zero)
        self.isUserInteractionEnabled = true
        self.addSubview(self.backgroundView)
        self.addSubview(self.columnStackView)
        self.columnStackView.addArrangedSubview(self.textLabel)
        self.columnStackView.addArrangedSubview(self.actionTextLabel)
        
        let actionLabelAttribute: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Medium", size: 13.5),
            NSAttributedString.Key.kern: 0.2,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        
        self.actionTextLabel.attributedText = NSAttributedString(string: "View", attributes: actionLabelAttribute)
       
        self.actionTextLabel.isHidden = self.hideActionButton ?? true
    }
    
    required convenience public init?(coder: NSCoder) {
        self.init()
    }
    
    // MARK: Layout
    
    override open func layoutSubviews() {
      super.layoutSubviews()
//      let containerSize = ToastWindow.shared.frame.size
        let containerSize = UIScreen.main.bounds.size
        let constraintSize = CGSize(
            width: containerSize.width * maxWidthRatio,
            height: CGFloat.greatestFiniteMagnitude
        )
        
        let textLabelSize = self.textLabel.sizeThatFits(constraintSize)
        self.textLabel.frame = CGRect(
            x: self.contentInsets.left,
            y: self.contentInsets.top,
            width: textLabelSize.width - self.contentInsets.left - self.contentInsets.right,
            height: textLabelSize.height
        )
        
        let actionTextLabelSize = self.actionTextLabel.sizeThatFits(constraintSize)
        self.actionTextLabel.frame = CGRect(
            x: 0,
            y: 0,
            width: actionTextLabelSize.width,
            height: actionTextLabelSize.height
        )
        
        self.columnStackView.frame = CGRect(
            x: self.contentInsets.left,
            y: self.contentInsets.top,
            width: constraintSize.width - self.contentInsets.left - self.contentInsets.right,
            height: textLabelSize.height
        )
        
        self.backgroundView.frame = CGRect(
            x: 0,
            y: 0,
            width: constraintSize.width,
            height: self.columnStackView.frame.height + self.contentInsets.top + self.contentInsets.bottom
        )
        
        self.textLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        self.actionTextLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        NSLayoutConstraint.activate([
            self.actionTextLabel.widthAnchor.constraint(equalToConstant: self.actionTextLabel.frame.width)
        ])
        
        var x: CGFloat
        var y: CGFloat
        var width: CGFloat
        var height: CGFloat
        
        let orientation = UIApplication.shared.statusBarOrientation
        if orientation.isPortrait || !ToastWindow.shared.shouldRotateManually {
            width = containerSize.width
            height = containerSize.height
            y = self.bottomOffsetPortrait
        } else {
            width = containerSize.height
            height = containerSize.width
            y = self.bottomOffsetLandscape
        }
        if #available(iOS 11.0, *), useSafeAreaForBottomOffset {
            y += ToastWindow.shared.safeAreaInsets.bottom
        }
        
        let backgroundViewSize = self.backgroundView.frame.size
        x = (width - backgroundViewSize.width) * 0.5
        y = height - (backgroundViewSize.height + y)
        self.frame = CGRect(
            x: x,
            y: y,
            width: backgroundViewSize.width,
            height: backgroundViewSize.height
        )
    }

    override open func hitTest(_ point: CGPoint, with event: UIEvent!) -> UIView? {
      if let superview = self.superview {
        let pointInWindow = self.convert(point, to: superview)
        let contains = self.frame.contains(pointInWindow)
        if contains && self.isUserInteractionEnabled {
          return self
        }
      }
      return nil
    }
}

