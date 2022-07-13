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
//MARK: Base ViewController
open class HCYBaseViewController: UIViewController {
    
    /// Rxswift disposeBag
    let disposeBag = DisposeBag()
    //The line below the navigation bar
    lazy var topLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 234.0/255.0, green: 235.0/255.0, blue: 238.0/255.0, alpha: 1)
        lineView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 1.0/UIScreen.main.scale)
        return lineView
    }()
    
    /// Delete from the end . delete count
    var deleteViewCount = 0
    
    /// Page request initial page
    var pageNum:Int = 1
    
    /// Delete from to behind
    var deleteViewCountFirst = 0
    
    open override class func setValue(_ value: Any?, forUndefinedKey key: String) {
        DebugLog("Error setting routing parameters. No key exists: \(key)")
    }
    open override class func setNilValueForKey(_ key: String) {
        DebugLog("Error setting routing parameters. The key is nil: \(key)")
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(self.hcy_hiddenNavigationBarHidden(), animated: false)
    }
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    open override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: auto add back btn
        if let vcs = self.navigationController?.viewControllers, vcs.count > 1{
            DebugLog("vcs.count \(vcs.count)")
            addleftbutton()
        }
        
        self.view.backgroundColor = .white
        
        self.hcy_prefersNavigationBarHidden = self.hcy_hiddenNavigationBarHidden()
        self.hcy_interactivePopDisabled = self.hcy_interactivePopDisabled()
        changeNavigationStyle()
        setupNavigationItems()
        initializeSubViews()
        addSubViews()
        setupSubViewMargins()
        
        view.addSubview(topLine)
        view.bringSubview(toFront: topLine)
        //        view.bringSubviewToFront(topLine)
        guard self.hcy_hiddenNavigationBarHidden() else{return}
        topLine.isHidden = self.hcy_hiddenNavigationBarHidden()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //MARK:  Delete from to behind
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
        //MARK: Delete from the end
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
    open func hcy_hiddenNavigationBarHidden() -> Bool {
        return false
    }
    
    /// Whether to disable sideslip return gesture, default false
    /// - Returns: true / false
    open func hcy_interactivePopDisabled() -> Bool {
        return false
    }
    
    /// Add navigation left  back Item
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
        guard let _ = self.navigationController else { return }
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
                self.navigationController!.navigationBar.scrollEdgeAppearance = navBarAppearance
                self.navigationController!.navigationBar.standardAppearance = navBarAppearance
            }else{
                
                self.navigationController!.navigationBar.setBackgroundImage(UIImage(colors: [RGBColor(r: 140, g: 228, b: 152),
                                                                                             RGBColor(r:85,g:195,b:179),
                                                                                             RGBColor(r:78,g:178,b:184)],
                                                                                    size: CGSize(width: KScreenW, height: KNavigationH)), for: .default)
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
                self.navigationController!.navigationBar.scrollEdgeAppearance = navBarAppearance
                self.navigationController!.navigationBar.standardAppearance = navBarAppearance
            }else{
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
    
    /// initialize SubViews
    @objc open func initializeSubViews() {
        
    }
    
    /// addSubViews
    @objc open func addSubViews() {
        
    }
    
    /// setup SubView Margins
    @objc open func setupSubViewMargins() {
        
    }
    
    /// setup Navigation Items
    @objc open func setupNavigationItems() {
        
    }
    
    
}

extension UIViewController{
    public static func makeVCWithXIB<T:viewModelProtocol>(viewController:T.Type,viewModel:T.ViewModelT)->T{
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
    public static func makeVCWithSB<T:viewModelProtocol>(viewController:T.Type,viewModel:T.ViewModelT)->T{
        var vc = makeVCWithSB(viewController: viewController)
        vc.viewModel = viewModel
        return vc
    }
    public static func makeVCWithSB<T>(viewController:T.Type)->T{
        
        let viewControllerName = String(describing: viewController)
        
        let storyboard = UIStoryboard(name: viewControllerName, bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerName) as? T else {  fatalError("Unable to create ViewController: \(viewControllerName) from storyboard: \(storyboard)") }
        return viewController
    }
}


