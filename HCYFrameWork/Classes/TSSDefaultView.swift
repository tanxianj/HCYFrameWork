//
//  HBDefaultView.swift
//
//  Created by --- on 2022/4/7.
//
/**
 //MARK:用法介绍
 
 v1,v2,v3... 你需要自定义的视图 按顺序添加
 v1,v2,v3...  需要使用系统的 autoLayout 约束宽高
 v1,v2,v3... 不再支持 RXswift 请使用 subviewsBlock回调中的 index 或 将 v1,v2,v3...做成一个 V 传入 在 V中处理事件
 mainAction 不传入 则点击无响应
 defaultView.needAppear = false  则点击无响应 == 不传入mainAction
 subviewsBlock 不传入 默认执行 mainAction
 
 self.tableView.hb_loadingView = SYDefaultView.loadingViewWith(subviews: [v1,v2,v3...],mainAction: {
     print("主点击事件")
     self.loadData()
     
 },subviewsBlock: { index in
     print("子点击事件\(index)")
 })
 offsetY 向上或向下偏移 x
 self.tableView.hb_loadingView.offsetY = x
 可单独设置 color 默认为 white
 self.tableView.hb_loadingView.backgroundColor = color
 列如:加载数据
 loadData()
  func loadData(){
 //MARK:开始转圈
 self.tableView.hb_loadingView.beginRefreshing()
 .......
 你要做的事
 .......
 正常结束转圈
 self.tableView.hb_loadingView.endRefreshing()
 
 异常结束转圈
 self.tableView.hb_loadingView.endRefreshingWith...()
 //MARK:设置需要显示error 的index
 errorIndex 默认为 -1 当前数组中最后一个 UILabel  如果不为 -1 则从当前数组中 取errorIndex 为需要显示error  的 UILabel
 errorIndex 传入错误会崩溃！！！检查errorIndex 是否为UILabel
 self.tableView.hb_loadingView.endRefreshingWithString(errorIndex: errorIndex, error: errorString)
 }
 
 */
import UIKit

public let KNoMoreData = "您暂时没有相关数据"
open class TSSDefaultView: UIView {
    let tss_Space:CGFloat = 10.0
    //主要点击事件
    public typealias refreshingBlock = (()->Void)?
    ///子视图点击事件
    public typealias subviewsBlock = ((_ index:Int)->Void)?
    var refreshing:(()->Void)?
    /// 偏移量
    var offsetY:CGFloat = 0
    /// 是否重新加载视图
    var needAppear = true
    
    private lazy var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.addEventHandler {
            if let refreshing = self.refreshing{
                refreshing()
            }
        }
        addSubview(stackView)
        return stackView
    }()

    private lazy var errorImage:UIImageView = {
        let errorImage = UIImageView()
        errorImage.image = UIImage(named: "page_reminding_chucuo-1")
        errorImage.widthAnchor.constraint(greaterThanOrEqualToConstant: 70).isActive = true
        errorImage.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        errorImage.addEventHandler {
            
        }
        return errorImage
    }()
    private  lazy var errorLab:UILabel = {
        let errorLab = UILabel()
        errorLab.textAlignment = .center
        errorLab.textColor = .black
        errorLab.numberOfLines = 0
        errorLab.font = .systemFont(ofSize: 14)
        errorLab.text = KNoMoreData
        errorLab.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.size.width - 80).isActive = true
        errorLab.addEventHandler {
           
        }
        return errorLab
    }()
    private lazy var switchActivity:TSSLoadingCircle = {
        let switchActivity = TSSLoadingCircle()
        addSubview(switchActivity)
        switchActivity.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 70, height: 70))
        }
        return switchActivity
    }()
//    private lazy var switchActivity:UIActivityIndicatorView = {
//        let switchActivity = UIActivityIndicatorView(style: .gray)
//        switchActivity.hidesWhenStopped = true
//        addSubview(switchActivity)
//        return switchActivity
//    }()
    private override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension TSSDefaultView{

    public static func loadingViewWithDefaultRefreshingBlock(mainAction: refreshingBlock = nil,subviewsBlock:subviewsBlock = nil) ->TSSDefaultView {
        let  view = TSSDefaultView()
        view.stackView.addArrangedSubview(view.errorImage)
        view.stackView.addArrangedSubview(view.errorLab)
        view.refreshing = mainAction
        
        if let _  = subviewsBlock{
            view.errorImage.addEventHandler {
                subviewsBlock!(0)
            }
            view.errorLab.addEventHandler {
                subviewsBlock!(1)
            }
        }else{
            view.subviews.forEach { v in
                v.isUserInteractionEnabled = false
            }
        }
        return view
    }
    public static func loadingViewWith(subviews:[UIView],
                               mainAction: refreshingBlock = nil,
                               subviewsBlock:subviewsBlock = nil) ->TSSDefaultView {
        let  view = TSSDefaultView()
        switch subviews.count{
        case 0:
            view.refreshing = mainAction
            
            return view
        case 1:
        
        
            view.refreshing = mainAction
            guard let sub = subviews.first else { return view }
            view.stackView.addArrangedSubview(sub)
            if sub.isKind(of: UIImageView.self),let image = sub as? UIImageView{
                if image.contentMode.rawValue == 0 {
                    image.contentMode = .scaleAspectFit
                }
//                    image.contentMode = .scaleAspectFit
                if let size = image.image?.size{
                    let f = size.width / size.height
                    let w = UIScreen.main.bounds.size.width - 80
                    
                    image.widthAnchor.constraint(lessThanOrEqualToConstant: w).isActive = true
                    image.heightAnchor.constraint(lessThanOrEqualToConstant: w * f ).isActive = true
                }
            }
            
            return view
        default:
            subviews.forEach { sub in
                if sub.isKind(of: UIImageView.self),let image = sub as? UIImageView{
                    if image.contentMode.rawValue == 0 {
                        image.contentMode = .scaleAspectFit
                    }
//                    image.contentMode = .scaleAspectFit
                    if let size = image.image?.size{
                        let f = size.width / size.height
                        let w = UIScreen.main.bounds.size.width - 80
                        
                        image.widthAnchor.constraint(lessThanOrEqualToConstant: w).isActive = true
                        image.heightAnchor.constraint(lessThanOrEqualToConstant: w * f ).isActive = true
                    }
                }
                view.stackView.addArrangedSubview(sub)
                if let _ = subviewsBlock,let index = subviews.firstIndex(of: sub){
                    sub.addEventHandler {
                        subviewsBlock!(index)
                    }
                }else{
                    view.subviews.forEach { v in
                        v.isUserInteractionEnabled = false
                    }
                }
                    
                
            }
        
            view.refreshing = mainAction
            return view
        }
       
    }
    //控件隐藏
    private func controlHide() {
        stackView.isHidden = true
        switchActivity.startAnimating()
    }
    //控件显示
    private func controlShow() {
        stackView.isHidden = false
        switchActivity.stopAnimating()
    }
    //开始刷新
    public func beginRefreshing() {
        guard needAppear else{return}
        self.isHidden = false
        controlHide()
        
        if let  superview =  self.superview ,superview is UIScrollView {
            let tmp = self.superview as! UIScrollView
            tmp.isScrollEnabled = false
        }

    }
    //成功结束
    public func endRefreshing() {
        needAppear = false
        controlShow()
        self.isHidden = true
        if let  superview =  self.superview ,superview is UIScrollView {
            let tmp = self.superview as! UIScrollView
            tmp.isScrollEnabled = true
        }
    }
    //错误提示
    public func endRefreshingWithString(errorIndex:Int = -1,error:String) {
        guard needAppear else{return}
        self.isHidden = false
        controlShow()
        switch errorIndex{
        case -1:
            if let lab = stackView.arrangedSubviews.last(where: {$0.isKind(of: UILabel.self)}) as? UILabel{
                lab.text = error
            }else{
                fatalError("未找到UILabel")
            }
        default:
            if let lab = stackView.arrangedSubviews[errorIndex] as? UILabel{
                lab.text = error
            }else{
                fatalError("当前index不是UILabel")
            }
            
            
        }
       
        needAppear = true
        
        if let superview = self.superview,superview is UIScrollView {
            let tmp = self.superview as! UIScrollView
            tmp.isScrollEnabled = false
        }
//        guard !needAppear else {
//            self.isHidden = false
//            controlShow()
//            if let lab = stackView.arrangedSubviews.last(where: {$0.isKind(of: UILabel.self)}) as? UILabel{
//                lab.text = error
//            }
//            errorLab.text = error
//            needAppear = true
//            if self.superview! is UIScrollView {
//                let tmp = self.superview as! UIScrollView
//                tmp.isScrollEnabled = false
//            }
//            return
//        }
    }
    //禁止所有点击
    public func endRefreshingWithEnabledClick(errorIndex:Int = -1,noEnabledString:String?) {
        if let _ = self.superview{
            self.isUserInteractionEnabled = false
            self.superview!.isUserInteractionEnabled = false
        }
        endRefreshingWithString(errorIndex:errorIndex,error: noEnabledString ?? KNoMoreData)
    }
    //没有数据
    public func endRefreshingWithNoDataString(errorIndex:Int = -1,noDataString:String? = KNoMoreData) {
        endRefreshingWithString(errorIndex:errorIndex,error: noDataString ?? KNoMoreData)
    }
    //网络错误
    public func endRefreshingWithErrorString(errorIndex:Int = -1,errorString:String?)  {
        endRefreshingWithString(errorIndex:errorIndex,error: errorString ?? "网络好像出错了")
    }
    //自定义错误图片
    public func endRefreshingWithNormalString(errorIndex:Int = -1,normalString:String,normalImage:UIImage) {
        endRefreshingWithString(errorIndex:errorIndex,error: normalString)
//        defaultButton.setBackgroundImage(normalImage, for: .normal)
        
    }
    func defaultButtonClick() {
        if let action = refreshing {
            action()
        }
    }
    open override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        var  rect = self.superview!.bounds
        rect.origin.y += offsetY + 0.5
        rect.size.height -= offsetY - 0.5
        self.frame = rect
        placeSubviews()
        self.addEventHandler {[weak self] in
            guard let strongSelf = self else {return}
            strongSelf.defaultButtonClick()
        }
    }
    func placeSubviews() {
//        switchActivity.frame = bounds
        
        stackView.widthAnchor.constraint(equalToConstant: self.superview!.bounds.size.width - 40).isActive = true
        stackView.heightAnchor.constraint(lessThanOrEqualToConstant: self.bounds.height).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    
    
}
fileprivate var tssLoadingViewKey = "tssLoadingViewKey"
extension UIView{
   public  var tss_loadingView:TSSDefaultView{
        get{
            return (objc_getAssociatedObject(self, &tssLoadingViewKey) as? TSSDefaultView) ?? TSSDefaultView()
        }
        set{
            if  self.tss_loadingView != newValue {
                // 删除旧的，添加新的
                self.tss_loadingView.removeFromSuperview()
                addSubview(newValue)
                // 存储新的
                objc_setAssociatedObject(self, &tssLoadingViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            
        }
    }
}
