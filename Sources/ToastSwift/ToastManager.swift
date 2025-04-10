//
//  ToastManager.swift
//  ToastSwift
//
//  Created by Jerwin Metromart on 3/7/25.
//

import UIKit

open class ToastManager: NSObject {
    
    // MARK: - Properties
    
    private let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    open var currentToast: ToastSwift? {
        return self.queue.operations.first { !$0.isCancelled && !$0.isFinished } as? ToastSwift
    }
    
    @objc public var isSupportAccessibility: Bool = true
    @objc public var isQueueEnabled: Bool = true
    @MainActor @objc public static let `default` = ToastManager()
    
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        
        #if swift(>=4.2)
        let name = UIDevice.orientationDidChangeNotification
        #else
        let name = NSNotification.Name.UIDeviceOrientationDidChange
        #endif
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.deviceOrientationDidChange),
                                               name: name,
                                               object: nil)
    }
    
    
    // MARK: - Adding Toast
    
    open func add(_ toast: ToastSwift) {
        !isQueueEnabled ? cancelAll() : self.queue.addOperation(toast)
    }
    
    // MARK: - Cancelling Toast
    
    @objc open func cancelAll() {
        queue.cancelAllOperations()
    }
    
    @MainActor @objc private func deviceOrientationDidChange() {
        if let lastToast = queue.operations.last as? ToastSwift {
            lastToast.view.setNeedsLayout()
        }
    }
    
}
