// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public class Delay: NSObject {
    @available(*, unavailable) private override init() {}
    @objc(Short) public static let short: TimeInterval = 2.0
    @objc(Long) public static let long: TimeInterval = 3.5
}

open class ToastSwift: Operation {
    
    // MARK: Properties
   
    @MainActor
    @objc public var text: String? {
        get { return self.view.text }
        set { return self.view.text = newValue }
    }
    
    @MainActor
    @objc public var attributedText: NSAttributedString? {
        get { return self.view.attributedText }
        set { return self.view.attributedText = newValue }
    }
    
    @MainActor
    public var hideActionButton: Bool {
        get { return self.view.hideActionButton ?? true }
        set { return self.view.hideActionButton = newValue }
    }
    
    @objc public var delay: TimeInterval = 0
    @objc public var duration: TimeInterval = 2.0
    @objc public var action: (() -> Void)?
    
    private var _executing = false
    override public var isExecuting: Bool {
        get { return _executing }
        set {
            self.willChangeValue(forKey: "isExecuting")
            self._executing = newValue
            self.didChangeValue(forKey: "isExecuting")
        }
    }
    
    private var _finished = false
    override public var isFinished: Bool {
        get { return _finished }
        set {
            self.willChangeValue(forKey: "isFinished")
            self._finished = newValue
            self.didChangeValue(forKey: "isFinished")
        }
    }
    
    // MARK: User Interface
    
    @MainActor
    @objc public var view: ToastView = ToastView()
    
    
    // MARK: Initializing
    
    @MainActor
    @objc public init(text: String? = nil, backgroundColor: UIColor = UIColor(red: 0.24, green: 0.24, blue: 0.24, alpha: 1.00), willHideActionButton: Bool = true, delay: TimeInterval = 0, duration: TimeInterval = Delay.short) {
        self.delay = delay
        self.duration = duration
        self.view.backgroundColor = backgroundColor
        super.init()
        self.text = text
    }
    
    @MainActor
    @objc public init(attributedText: NSAttributedString?, backgroundColor: UIColor = UIColor(red: 0.24, green: 0.24, blue: 0.24, alpha: 1.00), willHideActionButton: Bool = true, delay: TimeInterval = 0, duration: TimeInterval = Delay.short) {
        self.delay = delay
        self.duration = duration
        self.view.backgroundColor = backgroundColor
        super.init()
        self.attributedText = attributedText
    }
    
    // MARK: Actions
    
    @MainActor @objc public func show() {
        ToastManager.default.add(self)
    }
    
    open override func cancel() {
        super.cancel()
        self.finish()
        Task {
            await MainActor.run {
                self.view.removeFromSuperview()
            }
        }
    }
    
    override open func start() {
        let isRunnable = !self.isFinished && !self.isCancelled && !self.isExecuting
        guard isRunnable else { return }
        guard Thread.isMainThread else {
            DispatchQueue.main.async { [weak self] in
                self?.start()
            }
            return
        }
        main()
    }
    
    override open func main() {
      self.isExecuting = true

      DispatchQueue.main.async {
        self.view.setNeedsLayout()
        self.view.alpha = 0
        ToastWindow.shared.addSubview(self.view)

        UIView.animate(
          withDuration: 0.5,
          delay: self.delay,
          options: .beginFromCurrentState,
          animations: {
            self.view.alpha = 1
          },
          completion: { completed in
              if ToastManager.default.isSupportAccessibility {
              #if swift(>=4.2)
              UIAccessibility.post(notification: .announcement, argument: self.view.text)
              #else
              UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, self.view.text)
              #endif
            }
            UIView.animate(
              withDuration: self.duration,
              animations: {
                self.view.alpha = 1.0001
              },
              completion: { completed in
                self.finish()
                UIView.animate(
                  withDuration: 0.5,
                  animations: {
                    self.view.alpha = 0
                  },
                  completion: { completed in
                    self.view.removeFromSuperview()
                  }
                )
              }
            )
          }
        )
      }
    }
    
    func finish() {
      self.isExecuting = false
      self.isFinished = true
    }
}
