import UIKit

open class TSSFullscreenPopGesture {
    
    open class func configure() {
        UINavigationBar.tss_navbar_initialize()
        UINavigationController.tss_nav_initialize()
        UIViewController.tss_initialize()
    }
    
}
extension UINavigationBar{
    public class func tss_navbar_initialize() {
        // Inject "-pushViewController:animated:"
        DispatchQueue.once(token: "com.UINavigationBar.MethodSwizzling.TSS", block: {
            let originalMethod = class_getInstanceMethod(self, #selector(layoutSubviews))
            let swizzledMethod = class_getInstanceMethod(self, #selector(tss_layoutSubviews))
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        })
    }
    @objc private func tss_layoutSubviews(){
        self.tss_layoutSubviews()
        
        for view in self.subviews {
           
           let vName = String(describing:(view.self))
           if vName.contains("_UINavigationBarContentView") {
               if #available(iOS 11.0, *) {
                   let margins = view.layoutMargins
                   view.frame = CGRect(x: -margins.left, y: -margins.top, width: margins.left + margins.right + view.frame.size.width, height: margins.top + margins.bottom + view.frame.size.height)
                  break
               }else{
                   self.superview?.layoutMargins = .zero
               }
               break
           }
       }
   }
}
extension UINavigationController {
    
    private var tss_popGestureRecognizerDelegate: _TSSFullscreenPopGestureRecognizerDelegate {
        guard let delegate = objc_getAssociatedObject(self, RuntimeKey.KEY_tss_popGestureRecognizerDelegate!) as? _TSSFullscreenPopGestureRecognizerDelegate else {
            let popDelegate = _TSSFullscreenPopGestureRecognizerDelegate()
            popDelegate.navigationController = self
            objc_setAssociatedObject(self, RuntimeKey.KEY_tss_popGestureRecognizerDelegate!, popDelegate, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return popDelegate
        }
        return delegate
    }
    
    public class func tss_nav_initialize() {
        // Inject "-pushViewController:animated:"
        DispatchQueue.once(token: "com.UINavigationController.MethodSwizzling.TSS", block: {
            let originalMethod = class_getInstanceMethod(self, #selector(pushViewController(_:animated:)))
            let swizzledMethod = class_getInstanceMethod(self, #selector(tss_pushViewController(_:animated:)))
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        })
    }
    
    
    
    //    override open class func initialize() {
    //        // Inject "-pushViewController:animated:"
    //        DispatchQueue.once(token: "com.UINavigationController.MethodSwizzling", block: {
    //            let originalMethod = class_getInstanceMethod(self, #selector(pushViewController(_:animated:)))
    //            let swizzledMethod = class_getInstanceMethod(self, #selector(tss_pushViewController(_:animated:)))
    //            method_exchangeImplementations(originalMethod!, swizzledMethod!)
    //        })
    //    }
    
    @objc private func tss_pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.interactivePopGestureRecognizer?.view?.gestureRecognizers?.contains(self.tss_fullscreenPopGestureRecognizer) == false {
            
            // Add our own gesture recognizer to where the onboard screen edge pan gesture recognizer is attached to.
            self.interactivePopGestureRecognizer?.view?.addGestureRecognizer(self.tss_fullscreenPopGestureRecognizer)
            
            // Forward the gesture events to the private handler of the onboard gesture recognizer.
            let internalTargets = self.interactivePopGestureRecognizer?.value(forKey: "targets") as? Array<NSObject>
            let internalTarget = internalTargets?.first?.value(forKey: "target")
            let internalAction = NSSelectorFromString("handleNavigationTransition:")
            if let target = internalTarget {
                self.tss_fullscreenPopGestureRecognizer.delegate = self.tss_popGestureRecognizerDelegate
                self.tss_fullscreenPopGestureRecognizer.addTarget(target, action: internalAction)
                
                // Disable the onboard gesture recognizer.
                self.interactivePopGestureRecognizer?.isEnabled = false
            }
        }
        
        // Handle perferred navigation bar appearance.
        self.tss_setupViewControllerBasedNavigationBarAppearanceIfNeeded(viewController)
        
        // Forward to primary implementation.
        self.tss_pushViewController(viewController, animated: animated)
    }
    
    private func tss_setupViewControllerBasedNavigationBarAppearanceIfNeeded(_ appearingViewController: UIViewController) {
        
        if !self.tss_viewControllerBasedNavigationBarAppearanceEnabled {
            return
        }
        
        let blockContainer = _TSSViewControllerWillAppearInjectBlockContainer() { [weak self] (_ viewController: UIViewController, _ animated: Bool) -> Void in
            self?.setNavigationBarHidden(viewController.tss_prefersNavigationBarHidden, animated: animated)
        }
        
        // Setup will appear inject block to appearing view controller.
        // Setup disappearing view controller as well, because not every view controller is added into
        // stack by pushing, maybe by "-setViewControllers:".
        appearingViewController.tss_willAppearInjectBlockContainer = blockContainer
        let disappearingViewController = self.viewControllers.last
        if let vc = disappearingViewController {
            if vc.tss_willAppearInjectBlockContainer == nil {
                vc.tss_willAppearInjectBlockContainer = blockContainer
            }
        }
    }
    
    /// The gesture recognizer that actually handles interactive pop.
    public var tss_fullscreenPopGestureRecognizer: UIPanGestureRecognizer {
        guard let pan = objc_getAssociatedObject(self, RuntimeKey.KEY_tss_fullscreenPopGestureRecognizer!) as? UIPanGestureRecognizer else {
            let panGesture = UIPanGestureRecognizer()
            panGesture.maximumNumberOfTouches = 1;
            objc_setAssociatedObject(self, RuntimeKey.KEY_tss_fullscreenPopGestureRecognizer!, panGesture, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            return panGesture
        }
        return pan
    }
    
    /// A view controller is able to control navigation bar's appearance by itself,
    /// rather than a global way, checking "fd_prefersNavigationBarHidden" property.
    /// Default to true, disable it if you don't want so.
    public var tss_viewControllerBasedNavigationBarAppearanceEnabled: Bool {
        get {
            guard let bools = objc_getAssociatedObject(self, RuntimeKey.KEY_tss_viewControllerBasedNavigationBarAppearanceEnabled!) as? Bool else {
                self.tss_viewControllerBasedNavigationBarAppearanceEnabled = true
                return true
            }
            return bools
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.KEY_tss_viewControllerBasedNavigationBarAppearanceEnabled!, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

fileprivate typealias _TSSViewControllerWillAppearInjectBlock = (_ viewController: UIViewController, _ animated: Bool) -> Void

fileprivate class _TSSViewControllerWillAppearInjectBlockContainer {
    var block: _TSSViewControllerWillAppearInjectBlock?
    init(_ block: @escaping _TSSViewControllerWillAppearInjectBlock) {
        self.block = block
    }
}

extension UIViewController {
    
    fileprivate var tss_willAppearInjectBlockContainer: _TSSViewControllerWillAppearInjectBlockContainer? {
        get {
            return objc_getAssociatedObject(self, RuntimeKey.KEY_tss_willAppearInjectBlockContainer!) as? _TSSViewControllerWillAppearInjectBlockContainer
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.KEY_tss_willAppearInjectBlockContainer!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public class func tss_initialize() {
        
        DispatchQueue.once(token: "com.UIViewController.MethodSwizzling.TSS", block: {
            let originalMethod = class_getInstanceMethod(self, #selector(viewWillAppear(_:)))
            let swizzledMethod = class_getInstanceMethod(self, #selector(tss_viewWillAppear(_:)))
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        })
    }
    
    @objc private func tss_viewWillAppear(_ animated: Bool) {
        // Forward to primary implementation.
        self.tss_viewWillAppear(animated)
        
        if let block = self.tss_willAppearInjectBlockContainer?.block {
            block(self, animated)
        }
    }
    
    /// Whether the interactive pop gesture is disabled when contained in a navigation stack.
    public var tss_interactivePopDisabled: Bool {
        get {
            guard let bools = objc_getAssociatedObject(self, RuntimeKey.KEY_tss_interactivePopDisabled!) as? Bool else {
                return false
            }
            return bools
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.KEY_tss_interactivePopDisabled!, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /// Indicate this view controller prefers its navigation bar hidden or not,
    /// checked when view controller based navigation bar's appearance is enabled.
    /// Default to false, bars are more likely to show.
    public var tss_prefersNavigationBarHidden: Bool {
        get {
            guard let bools = objc_getAssociatedObject(self, RuntimeKey.KEY_tss_prefersNavigationBarHidden!) as? Bool else {
                return false
            }
            return bools
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.KEY_tss_prefersNavigationBarHidden!, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /// Max allowed initial distance to left edge when you begin the interactive pop
    /// gesture. 0 by default, which means it will ignore this limit.
    public var tss_interactivePopMaxAllowedInitialDistanceToLeftEdge: Double {
        get {
            guard let doubleNum = objc_getAssociatedObject(self, RuntimeKey.KEY_tss_interactivePopMaxAllowedInitialDistanceToLeftEdge!) as? Double else {
                return 0.0
            }
            return doubleNum
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.KEY_tss_interactivePopMaxAllowedInitialDistanceToLeftEdge!, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
}

private class _TSSFullscreenPopGestureRecognizerDelegate: NSObject, UIGestureRecognizerDelegate {
    
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
        guard !topViewController.tss_interactivePopDisabled else {
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
        let maxAllowedInitialDistance = topViewController.tss_interactivePopMaxAllowedInitialDistanceToLeftEdge
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
    static let KEY_tss_willAppearInjectBlockContainer
    = UnsafeRawPointer(bitPattern: "KEY_tss_willAppearInjectBlockContainer".hashValue)
    static let KEY_tss_interactivePopDisabled
    = UnsafeRawPointer(bitPattern: "KEY_tss_interactivePopDisabled".hashValue)
    static let KEY_tss_prefersNavigationBarHidden
    = UnsafeRawPointer(bitPattern: "KEY_tss_prefersNavigationBarHidden".hashValue)
    static let KEY_tss_interactivePopMaxAllowedInitialDistanceToLeftEdge
    = UnsafeRawPointer(bitPattern: "KEY_tss_interactivePopMaxAllowedInitialDistanceToLeftEdge".hashValue)
    static let KEY_tss_fullscreenPopGestureRecognizer
    = UnsafeRawPointer(bitPattern: "KEY_tss_fullscreenPopGestureRecognizer".hashValue)
    static let KEY_tss_popGestureRecognizerDelegate
    = UnsafeRawPointer(bitPattern: "KEY_tss_popGestureRecognizerDelegate".hashValue)
    static let KEY_tss_viewControllerBasedNavigationBarAppearanceEnabled
    = UnsafeRawPointer(bitPattern: "KEY_tss_viewControllerBasedNavigationBarAppearanceEnabled".hashValue)
    
}
