import UIKit

open class HCYFullscreenPopGesture {
    
    open class func configure() {
        
        UINavigationController.hcy_nav_initialize()
        UIViewController.hcy_initialize()
    }
    
}

extension UINavigationController {
    
    private var hcy_popGestureRecognizerDelegate: _HCYFullscreenPopGestureRecognizerDelegate {
        guard let delegate = objc_getAssociatedObject(self, RuntimeKey.KEY_hcy_popGestureRecognizerDelegate!) as? _HCYFullscreenPopGestureRecognizerDelegate else {
            let popDelegate = _HCYFullscreenPopGestureRecognizerDelegate()
            popDelegate.navigationController = self
            objc_setAssociatedObject(self, RuntimeKey.KEY_hcy_popGestureRecognizerDelegate!, popDelegate, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return popDelegate
        }
        return delegate
    }
    
    open class func hcy_nav_initialize() {
        // Inject "-pushViewController:animated:"
        DispatchQueue.once(token: "com.UINavigationController.MethodSwizzling", block: {
            let originalMethod = class_getInstanceMethod(self, #selector(pushViewController(_:animated:)))
            let swizzledMethod = class_getInstanceMethod(self, #selector(hcy_pushViewController(_:animated:)))
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        })
    }
    
    //    override open class func initialize() {
    //        // Inject "-pushViewController:animated:"
    //        DispatchQueue.once(token: "com.UINavigationController.MethodSwizzling", block: {
    //            let originalMethod = class_getInstanceMethod(self, #selector(pushViewController(_:animated:)))
    //            let swizzledMethod = class_getInstanceMethod(self, #selector(hcy_pushViewController(_:animated:)))
    //            method_exchangeImplementations(originalMethod!, swizzledMethod!)
    //        })
    //    }
    
    @objc private func hcy_pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.interactivePopGestureRecognizer?.view?.gestureRecognizers?.contains(self.hcy_fullscreenPopGestureRecognizer) == false {
            
            // Add our own gesture recognizer to where the onboard screen edge pan gesture recognizer is attached to.
            self.interactivePopGestureRecognizer?.view?.addGestureRecognizer(self.hcy_fullscreenPopGestureRecognizer)
            
            // Forward the gesture events to the private handler of the onboard gesture recognizer.
            let internalTargets = self.interactivePopGestureRecognizer?.value(forKey: "targets") as? Array<NSObject>
            let internalTarget = internalTargets?.first?.value(forKey: "target")
            let internalAction = NSSelectorFromString("handleNavigationTransition:")
            if let target = internalTarget {
                self.hcy_fullscreenPopGestureRecognizer.delegate = self.hcy_popGestureRecognizerDelegate
                self.hcy_fullscreenPopGestureRecognizer.addTarget(target, action: internalAction)
                
                // Disable the onboard gesture recognizer.
                self.interactivePopGestureRecognizer?.isEnabled = false
            }
        }
        
        // Handle perferred navigation bar appearance.
        self.hcy_setupViewControllerBasedNavigationBarAppearanceIfNeeded(viewController)
        
        // Forward to primary implementation.
        self.hcy_pushViewController(viewController, animated: animated)
    }
    
    private func hcy_setupViewControllerBasedNavigationBarAppearanceIfNeeded(_ appearingViewController: UIViewController) {
        
        if !self.hcy_viewControllerBasedNavigationBarAppearanceEnabled {
            return
        }
        
        let blockContainer = _HCYViewControllerWillAppearInjectBlockContainer() { [weak self] (_ viewController: UIViewController, _ animated: Bool) -> Void in
            self?.setNavigationBarHidden(viewController.hcy_prefersNavigationBarHidden, animated: animated)
        }
        
        // Setup will appear inject block to appearing view controller.
        // Setup disappearing view controller as well, because not every view controller is added into
        // stack by pushing, maybe by "-setViewControllers:".
        appearingViewController.hcy_willAppearInjectBlockContainer = blockContainer
        let disappearingViewController = self.viewControllers.last
        if let vc = disappearingViewController {
            if vc.hcy_willAppearInjectBlockContainer == nil {
                vc.hcy_willAppearInjectBlockContainer = blockContainer
            }
        }
    }
    
    /// The gesture recognizer that actually handles interactive pop.
    public var hcy_fullscreenPopGestureRecognizer: UIPanGestureRecognizer {
        guard let pan = objc_getAssociatedObject(self, RuntimeKey.KEY_hcy_fullscreenPopGestureRecognizer!) as? UIPanGestureRecognizer else {
            let panGesture = UIPanGestureRecognizer()
            panGesture.maximumNumberOfTouches = 1;
            objc_setAssociatedObject(self, RuntimeKey.KEY_hcy_fullscreenPopGestureRecognizer!, panGesture, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            return panGesture
        }
        return pan
    }
    
    /// A view controller is able to control navigation bar's appearance by itself,
    /// rather than a global way, checking "fd_prefersNavigationBarHidden" property.
    /// Default to true, disable it if you don't want so.
    public var hcy_viewControllerBasedNavigationBarAppearanceEnabled: Bool {
        get {
            guard let bools = objc_getAssociatedObject(self, RuntimeKey.KEY_hcy_viewControllerBasedNavigationBarAppearanceEnabled!) as? Bool else {
                self.hcy_viewControllerBasedNavigationBarAppearanceEnabled = true
                return true
            }
            return bools
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.KEY_hcy_viewControllerBasedNavigationBarAppearanceEnabled!, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

fileprivate typealias _HCYViewControllerWillAppearInjectBlock = (_ viewController: UIViewController, _ animated: Bool) -> Void

fileprivate class _HCYViewControllerWillAppearInjectBlockContainer {
    var block: _HCYViewControllerWillAppearInjectBlock?
    init(_ block: @escaping _HCYViewControllerWillAppearInjectBlock) {
        self.block = block
    }
}

extension UIViewController {
    
    fileprivate var hcy_willAppearInjectBlockContainer: _HCYViewControllerWillAppearInjectBlockContainer? {
        get {
            return objc_getAssociatedObject(self, RuntimeKey.KEY_hcy_willAppearInjectBlockContainer!) as? _HCYViewControllerWillAppearInjectBlockContainer
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.KEY_hcy_willAppearInjectBlockContainer!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open class func hcy_initialize() {
        
        DispatchQueue.once(token: "com.UIViewController.MethodSwizzling", block: {
            let originalMethod = class_getInstanceMethod(self, #selector(viewWillAppear(_:)))
            let swizzledMethod = class_getInstanceMethod(self, #selector(hcy_viewWillAppear(_:)))
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        })
    }
    
    //    override open class func initialize() {
    //
    //        DispatchQueue.once(token: "com.UIViewController.MethodSwizzling", block: {
    //            let originalMethod = class_getInstanceMethod(self, #selector(viewWillAppear(_:)))
    //            let swizzledMethod = class_getInstanceMethod(self, #selector(hcy_viewWillAppear(_:)))
    //            method_exchangeImplementations(originalMethod!, swizzledMethod!)
    //        })
    //    }
    
    @objc private func hcy_viewWillAppear(_ animated: Bool) {
        // Forward to primary implementation.
        self.hcy_viewWillAppear(animated)
        
        if let block = self.hcy_willAppearInjectBlockContainer?.block {
            block(self, animated)
        }
    }
    
    /// Whether the interactive pop gesture is disabled when contained in a navigation stack.
    public var hcy_interactivePopDisabled: Bool {
        get {
            guard let bools = objc_getAssociatedObject(self, RuntimeKey.KEY_hcy_interactivePopDisabled!) as? Bool else {
                return false
            }
            return bools
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.KEY_hcy_interactivePopDisabled!, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /// Indicate this view controller prefers its navigation bar hidden or not,
    /// checked when view controller based navigation bar's appearance is enabled.
    /// Default to false, bars are more likely to show.
    public var hcy_prefersNavigationBarHidden: Bool {
        get {
            guard let bools = objc_getAssociatedObject(self, RuntimeKey.KEY_hcy_prefersNavigationBarHidden!) as? Bool else {
                return false
            }
            return bools
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.KEY_hcy_prefersNavigationBarHidden!, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /// Max allowed initial distance to left edge when you begin the interactive pop
    /// gesture. 0 by default, which means it will ignore this limit.
    public var hcy_interactivePopMaxAllowedInitialDistanceToLeftEdge: Double {
        get {
            guard let doubleNum = objc_getAssociatedObject(self, RuntimeKey.KEY_hcy_interactivePopMaxAllowedInitialDistanceToLeftEdge!) as? Double else {
                return 0.0
            }
            return doubleNum
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.KEY_hcy_interactivePopMaxAllowedInitialDistanceToLeftEdge!, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
}

private class _HCYFullscreenPopGestureRecognizerDelegate: NSObject, UIGestureRecognizerDelegate {
    
    weak var navigationController: UINavigationController?
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        guard let navigationC = self.navigationController else {
            return false
        }
        
        // Ignore when no view controller is pushed into the navigation stack.
        guard navigationC.viewControllers.count > 1 else {
            return false
        }
        
        // Disable when the active view controller doesn't allow interactive pop.
        guard let topViewController = navigationC.viewControllers.last else {
            return false
        }
        guard !topViewController.hcy_interactivePopDisabled else {
            return false
        }
        
        // Ignore pan gesture when the navigation controller is currently in transition.
        guard let trasition = navigationC.value(forKey: "_isTransitioning") as? Bool else {
            return false
        }
        guard !trasition else {
            return false
        }
        
        guard let panGesture = gestureRecognizer as? UIPanGestureRecognizer else {
            return false
        }
        
        // Ignore when the beginning location is beyond max allowed initial distance to left edge.
        let beginningLocation = panGesture.location(in: panGesture.view)
        let maxAllowedInitialDistance = topViewController.hcy_interactivePopMaxAllowedInitialDistanceToLeftEdge
        guard maxAllowedInitialDistance <= 0 || Double(beginningLocation.x) <= maxAllowedInitialDistance else {
            return false
        }
        
        // Prevent calling the handler when the gesture begins in an opposite direction.
        let translation = panGesture.translation(in: panGesture.view)
        guard translation.x > 0 else {
            return false
        }
        
        return true
    }
}

fileprivate struct RuntimeKey {
    static let KEY_hcy_willAppearInjectBlockContainer
    = UnsafeRawPointer(bitPattern: "KEY_hcy_willAppearInjectBlockContainer".hashValue)
    static let KEY_hcy_interactivePopDisabled
    = UnsafeRawPointer(bitPattern: "KEY_hcy_interactivePopDisabled".hashValue)
    static let KEY_hcy_prefersNavigationBarHidden
    = UnsafeRawPointer(bitPattern: "KEY_hcy_prefersNavigationBarHidden".hashValue)
    static let KEY_hcy_interactivePopMaxAllowedInitialDistanceToLeftEdge
    = UnsafeRawPointer(bitPattern: "KEY_hcy_interactivePopMaxAllowedInitialDistanceToLeftEdge".hashValue)
    static let KEY_hcy_fullscreenPopGestureRecognizer
    = UnsafeRawPointer(bitPattern: "KEY_hcy_fullscreenPopGestureRecognizer".hashValue)
    static let KEY_hcy_popGestureRecognizerDelegate
    = UnsafeRawPointer(bitPattern: "KEY_hcy_popGestureRecognizerDelegate".hashValue)
    static let KEY_hcy_viewControllerBasedNavigationBarAppearanceEnabled
    = UnsafeRawPointer(bitPattern: "KEY_hcy_viewControllerBasedNavigationBarAppearanceEnabled".hashValue)
    static let KEY_hcy_scrollViewPopGestureRecognizerEnable
    = UnsafeRawPointer(bitPattern: "KEY_hcy_scrollViewPopGestureRecognizerEnable".hashValue)
}

extension UIScrollView: UIGestureRecognizerDelegate {
    
    public var hcy_scrollViewPopGestureRecognizerEnable: Bool {
        get {
            guard let bools = objc_getAssociatedObject(self, RuntimeKey.KEY_hcy_scrollViewPopGestureRecognizerEnable!) as? Bool else {
                return false
            }
            return bools
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.KEY_hcy_scrollViewPopGestureRecognizerEnable!, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    //UIGestureRecognizerDelegate
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.hcy_scrollViewPopGestureRecognizerEnable, self.contentOffset.x <= 0, let gestureDelegate = otherGestureRecognizer.delegate {
            if gestureDelegate.isKind(of: _HCYFullscreenPopGestureRecognizerDelegate.self) {
                return true
            }
        }
        return false
    }
}

public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    class func once(token: String, block: () -> Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}
