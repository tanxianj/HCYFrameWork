//
//  BasePoputView.swift
//
//
//  Created by Jupiter_TSS on 9/4/22.
//

import UIKit
import RxSwift
public class TSSBasePopupViewManager{
    private static var _sharedInstance:TSSBasePopupViewManager?
    
    /// 单列
    /// - Returns: BasePoputView
    public class func sharedInstance()->TSSBasePopupViewManager{
        guard let Instance = _sharedInstance else {
            _sharedInstance = TSSBasePopupViewManager()
            return _sharedInstance!
        }
        return Instance
    }
    
    /// 销毁单列
    public func deInstance(){
        TSSBasePopupViewManager._sharedInstance = nil
    }
    
    /// 唯一标识
    private let identifiTag = 97531
    /// 视图偏移量
    private var offset = 0.0
    /// 需要显示的位置
    public var superView:UIView!
    /// 当前弹窗 事件 后续是否有其他弹窗
    //    var continuePopup = false
    
    /// 需要弹出的视图
    public var contenView:UIView!
    
    public typealias Action = (_ index:Int)->Void
    
    /// 点击回调
    public var contentViewAction:Action!
    
    /// 灰色视图
    public lazy var grayView:UIView = {
        let view = UIView()
        view.backgroundColor = .black.alpha(0.3)
        view.addEventHandler {[weak self] in
            guard let weakSelf = self else {return}
            weakSelf.hidden()
            weakSelf.contentViewAction(-1)
            
        }
        return view
    }()
    
    /// 透明视图
    public lazy var clearView:UIView = {
        let view = UIView()
        
        return view
    }()
    private init() {
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
extension TSSBasePopupViewManager{
    
    /// 显示弹窗
    /// - Parameters:
    ///   - showinView: 父容器
    ///   - contentView: 需要显示的视图
    ///   - offset:向下偏移量
    ///   - popType: 视图呈现方式
    ///   - clearance: 与父容器间距
    ///   - withDuration: 动画时长
    ///   - action: 呈现视图中的点击事件 本视图点击事件默认 关闭弹出 index = -1  呈现视图中的点击事件需发送RxSwift通知
    public func showPoputWith(in showinView:TSSBasePopupShowInType = .viewIsWindow ,
                              contentView:UIView,
                              popupType:TSSBasePopupType = .bottomToCenter,
                              config:TSSBasePopupConfig =  TSSBasePopupConfig(),
                              action:Action!){
        
        
        //        guard self.continuePopup == false else{return}
        guard Keywindow?.viewWithTag(identifiTag) == nil else {return}
        self.superView = showinView.view
        self.superView.clipsToBounds = true
        self.offset  = config.offset
        grayView.alpha = 0.0
        grayView.tag = identifiTag
        
        
        
        clearView.frame = Keywindow!.bounds
        Keywindow!.addSubview(clearView)
        
        grayView.backgroundColor = config.bgcolor
        grayView.frame = Keywindow!.bounds
        clearView.addSubview(grayView)
        
        self.contentViewAction = action
        self.contenView = contentView
        self.contenView.alpha = 0.0
        self.clearView.addSubview(contentView)
        
        DispatchQueue.main.async {
            switch popupType {
            case .bottomToTop:
                self.doSetStartToBottom(config.clearance)
                self.doanimateWith_bottomtotop(config.withDuration)
            case .bottomToCenter:
                self.doSetStartToBottom(config.clearance)
                self.doanimateWith_bottomToCenter(config.withDuration)
            case .topToCenter:
                self.doSetStartToTop(config.clearance)
                self.doanimateWith_topToCenter(config.withDuration)
            case .topToBottom:
                self.doSetStartToTop(config.clearance)
                self.doanimateWith_topToBottom(config.withDuration)
            case .leftToRight:
                break
            case .rightToLeft:
                break
            }
            
        }
    }
    
    public func doSetStartToBottom(_ left:CGFloat){
        
        /// 都可以二选一
        //MARK:1
        self.contenView.centerXAnchor.constraint(equalTo: self.superView.centerXAnchor).isActive = true
        self.contenView.leftAnchor.constraint(equalTo: self.superView.leftAnchor, constant: left).isActive = true
        self.contenView.topAnchor.constraint(equalTo: self.superView.bottomAnchor).isActive = true
        self.contenView.heightAnchor.constraint(lessThanOrEqualToConstant: self.superView.mj_h * 0.8).isActive = true
        self.contenView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //MARK:2
        //                self.contenView.snp.makeConstraints { make in
        //                    make.centerX.equalToSuperview()
        //                    make.left.equalToSuperview().offset(left)
        //                    make.top.equalToSuperview().offset( self.superView.mj_h)
        //                    make.height.lessThanOrEqualTo(self.superView.mj_h * 0.8)
        //                }
        self.contenView.sizeToFit()
        self.contenView.setNeedsLayout()
        self.contenView.layoutIfNeeded()
    }
    public func doSetStartToTop(_ left:CGFloat){
        
        self.contenView.centerXAnchor.constraint(equalTo: self.superView.centerXAnchor).isActive = true
        self.contenView.leftAnchor.constraint(equalTo: self.superView.leftAnchor, constant: left).isActive = true
        self.contenView.bottomAnchor.constraint(equalTo: self.superView.topAnchor).isActive = true
        self.contenView.heightAnchor.constraint(lessThanOrEqualToConstant: self.superView.mj_h * 0.8).isActive = true
        self.contenView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //        self.contenView.snp.makeConstraints { make in
        //            make.centerX.equalToSuperview()
        //            make.left.equalToSuperview().offset(left)
        //            make.bottom.equalTo(self.superView.snp.top)
        //            make.height.lessThanOrEqualTo(self.superView.mj_h * 0.8)
        //        }
        
        
        self.contenView.sizeToFit()
        self.contenView.setNeedsLayout()
        self.contenView.layoutIfNeeded()
    }
    //===>>>>> animate start
    public func doanimateWith_bottomtotop(_ withDuration:CGFloat){
        UIView.animate(withDuration: withDuration) {
            var bottomOfSet = 0.0
            if let superView = self.superView.superview, superView.mj_h == Keywindow!.mj_h{
                bottomOfSet = Keywindow!.safeAreaInsets.bottom
            }
            if self.superView == Keywindow{
                bottomOfSet = Keywindow!.safeAreaInsets.bottom
            }
            self.contenView.transform = CGAffineTransform.init(translationX: 0, y: -self.contenView.mj_h - bottomOfSet + self.offset)
            self.grayView.alpha = 1.0
            self.contenView.alpha = 1.0
        }
    }
    public func doanimateWith_bottomToCenter(_ withDuration:CGFloat){
        UIView.animate(withDuration: withDuration) {
            
            self.contenView.transform = CGAffineTransform.init(translationX: 0, y: -self.contenView.mj_h - (self.superView.mj_h - self.contenView.mj_h) / 2.0 + self.offset)
            self.grayView.alpha = 1.0
            self.contenView.alpha = 1.0
        }
    }
    public func doanimateWith_topToCenter(_ withDuration:CGFloat){
        UIView.animate(withDuration: withDuration) {
            
            self.contenView.transform = CGAffineTransform.init(translationX: 0, y: self.contenView.mj_h + (self.superView.mj_h - self.contenView.mj_h) / 2.0 + self.offset)
            self.grayView.alpha = 1.0
            self.contenView.alpha = 1.0
        }
    }
    public func doanimateWith_topToBottom(_ withDuration:CGFloat){
        UIView.animate(withDuration: withDuration) {
            //            self.contenView.mj_y = 0.0
            var bottomOfSet = 0.0
            if let superView = self.superView.superview, superView.mj_h == Keywindow!.mj_h{
                bottomOfSet = Keywindow!.safeAreaInsets.top
            }
            if self.superView == Keywindow{
                bottomOfSet = Keywindow!.safeAreaInsets.top
            }
            self.contenView.transform = CGAffineTransform.init(translationX: 0, y: self.contenView.mj_h + self.offset + bottomOfSet )
            self.grayView.alpha = 1.0
            self.contenView.alpha = 1.0
        }
    }
    //===<<<<< animate end
    public func hidden(){
        guard let _ = contenView else {return}
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.grayView.alpha = 0
            strongSelf.contenView.transform = .identity
        } completion: { [weak self] b in
            guard let strongSelf = self else {return}
            if b {
                strongSelf.grayView.removeFromSuperview()
                strongSelf.contenView.removeFromSuperview()
                strongSelf.clearView.removeFromSuperview()
                strongSelf.deInstance()
            }
        }
    }
}
//MARK:子视图 点击事件需调用 events 事件
open class TSSBasePoputEvents{
    public static let shared = TSSBasePoputEvents()
    private let  disposeBag = DisposeBag()
    var events = PublishSubject<Int>()
    private init() {
        events.asObserver().subscribe(onNext:{ index in
            //            DebugLog("点击自定义视图 \(index)")
            self.sendToPoputView(index: index)
            
        }).disposed(by: disposeBag)
    }
    public func sendToPoputView(index:Int){
        TSSBasePopupViewManager.sharedInstance().hidden()
        TSSBasePopupViewManager.sharedInstance().contentViewAction(index)
    }
}
