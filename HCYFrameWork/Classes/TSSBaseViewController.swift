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

public protocol TSSBaseViewControllerDelegate:UIViewController{
    func willResignActiveNotification()
    func didEnterBackgroundNotification()
    func willEnterForegroundNotification()
    func didBecomeActiveNotification()
}
//MARK: Base ViewController
open class TSSBaseViewController: UIViewController {
    weak var tss_baseViewDelegate:TSSBaseViewControllerDelegate?
    /// Rxswift disposeBag
    public let disposeBag = DisposeBag()
    //The line below the navigation bar
    public lazy var topLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 234.0/255.0, green: 235.0/255.0, blue: 238.0/255.0, alpha: 1)
        lineView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 1.0/UIScreen.main.scale)
        return lineView
    }()
   /*
    public lazy var tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.defaultConfig()
        return tableView
    }()
    public lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.defaultConfig()
        return collectionView
    }()
    */
    /// Delete from the end . delete count
    public var deleteViewCount = 0
    
    /// Page request initial page
    public var pageNum:Int = 1
    
    /// Delete from to behind
    public var deleteViewCountFirst = 0
    
    open override class func setValue(_ value: Any?, forUndefinedKey key: String) {
        DebugLog("Error setting routing parameters. No key exists: \(key)")
    }
    open override class func setNilValueForKey(_ key: String) {
        DebugLog("Error setting routing parameters. The key is nil: \(key)")
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(self.tss_hiddenNavigationBarHidden(), animated: false)
        guard tss_baseViewDelegateisEnabled() else{return}
        self.tss_baseViewDelegate = self
    }
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tss_baseViewDelegate = nil
    }
    open override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: auto add back btn
        if let vcs = self.navigationController?.viewControllers, vcs.count > 1{
            DebugLog("vcs.count \(vcs.count)")
            tss_addleftbutton()
        }
        
        self.view.backgroundColor = .white
        
        self.tss_prefersNavigationBarHidden = self.tss_hiddenNavigationBarHidden()
        self.tss_interactivePopDisabled = self.tss_interactivePopDisabled()
//        changeNavigationStyle()
        setupNavigationItems()
        initializeSubViews()
        addSubViews()
        setupSubViewMargins()
        tss_registerNotifaction()
        view.addSubview(topLine)
        view.bringSubviewToFront(topLine)
        guard self.tss_hiddenNavigationBarHidden() else{return}
        topLine.isHidden = self.tss_hiddenNavigationBarHidden()
    }
    
    /// register Notifaction
    func tss_registerNotifaction(){
        NotificationCenter.default.rx.notification(UIApplication.willResignActiveNotification).subscribe(onNext: { [weak self] notification in
            guard let weakSelf = self else {return}
            weakSelf.tss_baseViewDelegate?.willResignActiveNotification()
        }).disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(UIApplication.didEnterBackgroundNotification).subscribe(onNext: {  [weak self] notification in
            guard let weakSelf = self else {return}
            weakSelf.tss_baseViewDelegate?.didEnterBackgroundNotification()
        }).disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(UIApplication.willEnterForegroundNotification).subscribe(onNext: { [weak self] notification in
            guard let weakSelf = self else {return}
            weakSelf.tss_baseViewDelegate?.willEnterForegroundNotification()
        }).disposed(by: disposeBag)
        NotificationCenter.default.rx.notification(UIApplication.didBecomeActiveNotification).subscribe(onNext: { [weak self] notification in
            guard let weakSelf = self else {return}
            weakSelf.tss_baseViewDelegate?.didBecomeActiveNotification()
        }).disposed(by: disposeBag)
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
    open func tss_hiddenNavigationBarHidden() -> Bool {
        return false
    }
    
    /// Whether to disable sideslip return gesture, default false
    /// - Returns: true / false
    open func tss_interactivePopDisabled() -> Bool {
        return false
    }
    
    /// APP activity Delegate isEnabled? Default false
    /// - Returns: true / false
    open func tss_baseViewDelegateisEnabled()->Bool{
        return false
    }
    
    /// Add navigation left  back Item
    open func tss_addleftbutton()  {
        self.navigationItem.leftBarButtonItem = self.CreateNavigationItem(type: .left, imageName: "return", titleColor: .red, itemAction: nil)
    }
    /// Add navigation right Item
    open func tss_addRightButton(title:String? = nil,imageName:String? = nil,action:@escaping ()->()){
        self.navigationItem.rightBarButtonItem = self.CreateNavigationItem(type: .right, title: title, imageName: imageName, titleColor: .black, itemAction: action)
    }
    //MARK:Quick jump
    open func tss_currentVCpushTo(_ vc:UIViewController) {
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

extension TSSBaseViewController:Initialization{
    /// initialize SubViews
    @objc open func initializeSubViews() {}
    /// addSubViews
    @objc open func addSubViews() {}
    /// setup SubView Margins
    @objc open func setupSubViewMargins() {}
    /// setup Navigation Items
    @objc open func setupNavigationItems() {}
}
extension TSSBaseViewController:TSSBaseViewControllerDelegate{
    @objc open func willResignActiveNotification(){}
    @objc open func didEnterBackgroundNotification(){}
    @objc open func willEnterForegroundNotification(){}
    @objc open func didBecomeActiveNotification(){}
}
extension TSSBaseViewController{
    public func tss_addScrollToTopBtn(){
        let view = UIView()
        view.backgroundColor = .red
        self.view.addSubview(view)
        view.snp.makeConstraints { make in
            make.width.height.equalTo(50.scale())
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        view.addEventHandler {
            guard let scrollView = self.view.subviews.first(where: {$0 is UIScrollView}) as? UIScrollView else{return}
            let contentInset = scrollView.contentInset
            DebugLog("contentInset \(contentInset.top)")
            scrollView.setContentOffset(CGPoint(x: 0, y: -contentInset.top), animated: true)
        }
    }
}


