//
//  BaseViewController.swift
//  
//
//  Created by Jupiter_TSS on 7/3/22.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
public protocol viewModelProtocol{
    associatedtype ViewModelT
    var viewModel: ViewModelT! { get set }
}
open class HCYBaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    //The line below the navigation bar
    lazy var topLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 234.0/255.0, green: 235.0/255.0, blue: 238.0/255.0, alpha: 1)
        lineView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 1.0/UIScreen.main.scale)
        return lineView
    }()
    
    /// The line below the navigation bar  1 -> 2 -> 3 ==== 1 -> 3
    var deleteViewCount = 0

    /// Page request initial page
    var pageNum:Int = 1
    
    /// Delete from start 1
    var deleteViewCountFirst = 0
    
    open override class func setValue(_ value: Any?, forUndefinedKey key: String) {
        DebugLog("Error setting routing parameters. No key exists: \(key)")
    }
    open override class func setNilValueForKey(_ key: String) {
        DebugLog("Error setting routing parameters. The key is nil: \(key)")
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(self.hiddenNavigationBarHidden(), animated: false)
    }
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    open override func viewDidLoad() {
        super.viewDidLoad()
        if let vcs = self.navigationController?.viewControllers, vcs.count > 1{
            DebugLog("vcs.count \(vcs.count)")
            addleftbutton()
        }
        
        self.view.backgroundColor = .white
        
        self.sh_prefersNavigationBarHidden = self.hiddenNavigationBarHidden()
        self.sh_interactivePopDisabled = self.interactivePopDisabled()
        changeNavigationStyle()
        setupNavigationItems()
        initializeSubViews()
        addSubViews()
        setupSubViewMargins()
        
        view.addSubview(topLine)
        view.bringSubview(toFront: topLine)
        guard self.hiddenNavigationBarHidden() else{return}
        topLine.isHidden = self.hiddenNavigationBarHidden()

        
        
        
        // Do any additional setup after loading the view.
    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard deleteViewCountFirst == 0 else{
            var array = self.navigationController?.viewControllers
            
            let  removeCount = deleteViewCountFirst
            
            if array!.count >= removeCount + 1 {
                array!.removeSubrange(Range(NSRange(location: 1, length: removeCount))!)
                navigationController?.viewControllers = array!
            }
            deleteViewCount = 0
            return
        }
        guard deleteViewCount == 0 else {
            var array = self.navigationController?.viewControllers
            
            let  removeCount = deleteViewCount
            if array!.count >= removeCount + 1 {
                array!.removeSubrange(Range(NSRange(location: array!.count - (removeCount + 1), length: removeCount))!)
                navigationController?.viewControllers = array!
            }
            deleteViewCount = 0
            return
        }
    }
    
    /// Hide navigation bar? Default false
    /// - Returns: true / false
    open func hiddenNavigationBarHidden() -> Bool {
        return false
    }
    
    /// Whether to disable sideslip return gesture, default false
    /// - Returns: true / false
    open func interactivePopDisabled() -> Bool {
        return false
    }
    
    /// Add navigation left Item
    open func addleftbutton()  {
        self.navigationItem.leftBarButtonItem = self.CreateNavigationItem(type: .left, imageName: "return", titleColor: .red, itemAction: nil)
    }
    /// Add navigation right Item
    open func addRightButton(title:String? = nil,imageName:String? = nil,action:@escaping ()->()){
        self.navigationItem.rightBarButtonItem = self.CreateNavigationItem(type: .right, title: title, imageName: imageName, titleColor: .black, itemAction: action)
    }
    //MARK:Quick jump
    open func currentVCpushTo(_ vc:UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func changeNavigationStyle(){
//        setNeedsStatusBarAppearanceUpdate()
        switch self.preferredStatusBarStyle{
        case .lightContent:
            DebugLog("lightContent")
            if #available(iOS 13.0, *) {
                let navBarAppearance = UINavigationBarAppearance()
                navBarAppearance.backgroundImage = UIImage(colors: [RGBColor(r: 140, g: 228, b: 152),
                                                                    RGBColor(r:85,g:195,b:179),
                                                                    RGBColor(r:78,g:178,b:184)],
                                                           size: CGSize(width: KScreenW, height: KNavigationH))
                navBarAppearance.backgroundEffect = nil
                navBarAppearance.shadowColor = .clear
                navBarAppearance.titleTextAttributes = [.foregroundColor:UIColor.white ,.font:UIFont.systemFont(ofSize: 18.scale(), weight: .semibold)]
                guard let _ = self.navigationController else { return }
                self.navigationController!.navigationBar.scrollEdgeAppearance = navBarAppearance
                self.navigationController!.navigationBar.standardAppearance = navBarAppearance
            }else{
                
                self.navigationController!.navigationBar.setBackgroundImage(UIImage(colors: [RGBColor(r: 140, g: 228, b: 152),
                                                                       RGBColor(r:85,g:195,b:179),
                                                                       RGBColor(r:78,g:178,b:184)],
                                                              size: CGSize(width: KScreenW, height: KNavigationH)), for: .default)
                guard let _ = self.navigationController else { return }
                self.navigationController!.navigationBar.shadowImage = UIImage()
                self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white,.font:UIFont.systemFont(ofSize: 18.0.scale(), weight: .semibold)]
            }
            self.topLine.isHidden = true
        default:
            DebugLog("default")
            if #available(iOS 13.0, *) {
                let navBarAppearance = UINavigationBarAppearance()
                navBarAppearance.backgroundColor = .white
                navBarAppearance.backgroundEffect = nil
                navBarAppearance.shadowColor = .clear
                navBarAppearance.titleTextAttributes = [.foregroundColor:UIColor.black ,.font:UIFont.systemFont(ofSize: 18.scale(), weight: .semibold)]
                guard let _ = self.navigationController else { return }
                self.navigationController!.navigationBar.scrollEdgeAppearance = navBarAppearance
                self.navigationController!.navigationBar.standardAppearance = navBarAppearance
            }else{
                guard let _ = self.navigationController else { return }
                self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: ""), for: .default)
                self.navigationController!.navigationBar.shadowImage = UIImage()
                self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.black,.font:UIFont.systemFont(ofSize: 18.0.scale(), weight: .semibold)]
            }
            self.topLine.isHidden = false
        }
    }
    deinit {
        DebugLog("deinit")
    }
    
    
    
}

extension HCYBaseViewController:Initialization{
    @objc open func initializeSubViews() {
        
    }
    
    @objc open func addSubViews() {
        
    }
    
    @objc open func setupSubViewMargins() {
        
    }
    
    @objc open func setupNavigationItems() {
        
    }
    
    
}

extension UIViewController{
    static public func makeVCWithXIB<T:viewModelProtocol>(viewController:T.Type,viewModel:T.ViewModelT)->T{
        let viewControllerName = String(describing: viewController)
        //动态获取命名空间
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        //注意工程中必须有相关的类，否则程序会crash
        let classT:AnyObject = NSClassFromString(namespace + "." + viewControllerName)!
        // 告诉编译器它的真实类型
        if let viewControllerClass = classT as? UIViewController.Type, var vc = viewControllerClass.init() as? T{
            vc.viewModel = viewModel
            return vc
        }else{
            fatalError("Unable to create ViewController: \(viewControllerName) from XIB: \(viewControllerName)")
        }
        
    }
    static public func makeVCWithSB<T:viewModelProtocol>(viewController:T.Type,viewModel:T.ViewModelT)->T{
        var vc = makeVCWithSB(viewController: viewController)
        vc.viewModel = viewModel
        return vc
    }
    static public  func makeVCWithSB<T>(viewController:T.Type)->T{
        
        let viewControllerName = String(describing: viewController)
        
        let storyboard = UIStoryboard(name: viewControllerName, bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerName) as? T else {  fatalError("Unable to create ViewController: \(viewControllerName) from storyboard: \(storyboard)") }
        return viewController
    }
}


