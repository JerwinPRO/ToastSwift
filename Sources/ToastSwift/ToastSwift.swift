// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public class Delay: NSObject {
    @available(*, unavailable) private override init() {}
    @objc(Short) public static let short: TimeInterval = 2.0
    @objc(Long) public static let long: TimeInterval = 3.5
}

open class ToastSwift: Operation, @unchecked Sendable {
    
    //MARK: - Properties
  
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
    
    //MARK: - User Interface
    
    @MainActor
    @objc public var view: ToastView = ToastView()
    
    // MARK: - Initialization
   
    @MainActor
    @objc public init(with attributes: ToastAttributes, onButtonTap buttonAction: (() -> Void)? = nil) {
        super.init()
        view.bind(with: attributes)
    }
    
    //MARK: - Actions
    
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
                guard let self = self else { return }
                self.start()
            }
            
            return
        }
        
        main()
    }
    
    override open func main() {
        self.isExecuting = true
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.view.setNeedsLayout()
            self.view.alpha = 0
            ToastWindow.shared.addSubview(self.view)
            
            UIView.animate(
                withDuration: 0.5,
                delay: self.view.attributes.delay,
                options: .beginFromCurrentState,
                animations: {
                    self.view.alpha = 1
                },
                completion: { completed in
                    if ToastManager.default.isSupportAccessibility {
                        var message: String = ""
                        
                        if self.view.attributes.shouldUseAttributedText {
                            if let val = self.view.attributes.messageLabelAttributedText?.string {
                                message = val
                            }
                        } else {
                            message = self.view.attributes.messageLabelText
                        }
                        
#if swift(>=4.2)
                        UIAccessibility.post(notification: .announcement, argument: message)
#else
                        UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, message)
#endif
                    }
                    UIView.animate(
                        withDuration: self.view.attributes.duration,
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
