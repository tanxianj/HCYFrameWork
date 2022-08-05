//
//  TSSActionSheet.swift
//  TestframeWork
//
//  Created by Jupiter_TSS on 13/7/22.
//

import Foundation
import UIKit
import HCYFrameWork
/// Label Alignment  and Vertical
public struct TSSActionSheetType : OptionSet {
    public var rawValue: UInt
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    public static var title :TSSActionSheetType { return  TSSActionSheetType(rawValue: 1 << 0) }
    
    public static var notice:TSSActionSheetType {return TSSActionSheetType(rawValue: 1 << 1) }
    
    public static var close: TSSActionSheetType { return  TSSActionSheetType(rawValue: 1 << 2) }
    
    public static var cancel: TSSActionSheetType { return  TSSActionSheetType(rawValue: 1 << 3) }
    
    public static var sure: TSSActionSheetType { return  TSSActionSheetType(rawValue: 1 << 4) }
    
    public static var autoHidden: TSSActionSheetType { return  TSSActionSheetType(rawValue: 1 << 5) }
    public static var allowsMultipleSelection:TSSActionSheetType { return  TSSActionSheetType(rawValue: 1 << 6) }
   
//    public static var bottomright:TSSLabelAlignment{return TSSLabelAlignment(rawValue: VerticalBottom.rawValue | HorizontalRight.rawValue)}
    
    
    
    
}
public class TSSActionSheetManager:NSObject,UITableViewDelegate,UITableViewDataSource{
    
    private static var _sharedInstance:TSSActionSheetManager?
    
    /// 单列
    /// - Returns: BasePoputView
    public class func sharedInstance()->TSSActionSheetManager{
        guard let Instance = _sharedInstance else {
            _sharedInstance = TSSActionSheetManager()
            return _sharedInstance!
        }
        return Instance
    }
    
    /// 销毁单列
    public func deInstance(){
        TSSActionSheetManager._sharedInstance = nil
    }
    
    private override init() {}
    
    private lazy var titleLab:UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.textAlignment = .center
        title.font = config.titleFont
        title.textColor = config.titleTextColor
        
        return title
    }()
    private lazy var noticeLab:UILabel = {
        let notice = UILabel()
        notice.numberOfLines = 0
        notice.textAlignment = .center
        notice.font = config.noticeFont
        notice.textColor = config.noticeTextColor
        
        return notice
    }()
    private lazy var closeView:UIView = {
        let close = UIView()
        
        return close
    }()
    
    private lazy var tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TSSActionSheetTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.separatorColor = .colorWithHexString("EAEBEE")
        tableView.separatorInset = .zero
        return tableView
    }()
    
    private lazy var bottomBtnView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10.scale()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        return stackView
    }()
    public lazy var contentView:UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.cornerRadius = config.cornerRadius
        return contentView
    }()
    /// 灰色视图
    public lazy var grayView:UIView = {
        let view = UIView()
        view.backgroundColor = .black.alpha(0.3)
        view.addEventHandler {[weak self] in
            guard let weakSelf = self else {return}
            weakSelf.hidden()
        }
        return view
    }()
    /// 透明视图
    public lazy var clearView:UIView = {
        let view = UIView()
        return view
    }()
    /// 唯一标识
    private let identifiTag = 97532
    //主要点击事件
    public typealias cancelBlock = (()->Void)?
    ///返回 单选自动隐藏方式 的已选择index
    public typealias singleSelectionBlock = ((_ index:Int)->Void)?
    private var singleSelection:singleSelectionBlock = nil
    ///多选
    public typealias multiSelectBlock = ((_ multiSelect:[Int])->Void)?
    private var multiSelect:multiSelectBlock = nil
    
    public var actionSheet:[Any]!
    public weak var delegete:TSSActionSheetManagerDelegate?
    public var config:TSSActionSheetConfig!
    public var type:TSSActionSheetType = []
    public var selectIndexArray:[Int] = []
}
public protocol TSSActionSheetManagerDelegate:NSObjectProtocol{
    func tableView(_ tableView: UITableView,_ dataSource:Any, cellForRowAt indexPath: IndexPath) -> UITableViewCell?
    func registerTableViewforCellReuseIdentifier()->String?
    func registerTableViewWithClass() -> AnyClass?
    func registerTableViewWithNib() -> UINib?
}
extension TSSActionSheetManagerDelegate{
    func tableView(_ tableView: UITableView,_ dataSource:Any, cellForRowAt indexPath: IndexPath) -> UITableViewCell?{return nil}
    func registerTableViewforCellReuseIdentifier()->String?{return nil}
    func registerTableViewWithClass() -> AnyClass?{return nil}
    func registerTableViewWithNib() ->  UINib?{return nil}
}
extension  TSSActionSheetManager{
    public func showActionSheetWith(actionSheet:[Any],
                                    delegate:TSSActionSheetManagerDelegate? = nil,
                                    type:TSSActionSheetType,
                                    config:TSSActionSheetConfig = TSSActionSheetConfig(),
                                    singleSelectionTap:singleSelectionBlock = nil,
                                    cancelTap:cancelBlock = nil,
                                    sureTap:multiSelectBlock = nil){
        guard Keywindow?.viewWithTag(identifiTag) == nil else {return}
        self.singleSelection = singleSelectionTap
        self.config = config
        self.type = type
        grayView.alpha = 0.0
        self.delegete = delegate
        self.actionSheet = actionSheet
        grayView.tag = identifiTag
        
        clearView.frame = Keywindow!.bounds
        grayView.frame  = clearView.bounds
        
        Keywindow!.addSubview(clearView)
        clearView.addSubview(grayView)
        
        clearView.addSubview(contentView)
        
        self.contentView.centerXAnchor.constraint(equalTo: self.grayView.centerXAnchor).isActive = true
        self.contentView.leftAnchor.constraint(equalTo: self.grayView.leftAnchor, constant: config.offset).isActive = true
        self.contentView.topAnchor.constraint(equalTo: self.grayView.bottomAnchor).isActive = true
        self.contentView.heightAnchor.constraint(lessThanOrEqualToConstant: KScreenH * 0.8).isActive = true
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        self.titleLab.text = config.title
        self.noticeLab.text = config.notice
       
        
        if type.contains(.close){
            self.closeView = config.close as! UIView
            contentView.addSubview(closeView)
            closeView.addEventHandler {[weak self]  in
                guard let weakSelf = self else {return}
                weakSelf.hidden()
            }
            closeView.snp.makeConstraints { make in
                make.right.top.equalToSuperview()
                make.width.height.equalTo(50.scale())
            }
        }
        
        if type.contains(.title){
            contentView.addSubview(titleLab)
            titleLab.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.left.equalToSuperview().offset(20.scale())
                make.top.equalToSuperview().offset(20.scale())
                make.height.greaterThanOrEqualTo(30.scale())
            }
        }
        
        if type.contains(.notice){
            contentView.addSubview(noticeLab)
            noticeLab.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.left.equalToSuperview().offset(20.scale())
                make.height.greaterThanOrEqualTo(30.scale())
                if contentView.subviews.contains(where: {$0 == titleLab}){
                    make.top.equalTo(titleLab.snp.bottom)
                }else{
                    make.top.equalToSuperview().offset(20.scale())
                }
                
            }
        }
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(20.scale()).priority(199)
            if contentView.subviews.contains(where: {$0 == closeView}){
                make.top.equalTo(closeView.snp.bottom).offset(20.scale()).priority(299)
            }
            if contentView.subviews.contains(where: {$0 == titleLab}){
                make.top.equalTo(titleLab.snp.bottom).offset(20.scale()).priority(399)
            }
            if contentView.subviews.contains(where: {$0 == noticeLab}){
                make.top.equalTo(noticeLab.snp.bottom).offset(20.scale()).priority(499)
            }
            if type.isEmpty{
                make.bottom.equalToSuperview().offset(-40.scale())
            }
            
            make.centerX.equalToSuperview()
            make.height.equalTo(CGFloat(self.actionSheet.count) * config.rowHeight)
        }
        if !type.isEmpty{
            contentView.addSubview(bottomBtnView)
            bottomBtnView.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(20.scale())
                make.bottom.equalToSuperview().offset(-20.scale())
                make.centerX.equalToSuperview()
                make.height.equalTo(config.bottomBtnHeight)
                make.top.equalTo(tableView.snp.bottom).offset(20.scale())
            }
        }
        
        if type.contains(.cancel){
            bottomBtnView.addArrangedSubview(config.cancelBtn)
            config.cancelBtn.addEventHandler {[weak self]  in
                guard let weakSelf = self else {return}
                cancelTap?()
                weakSelf.hidden()
            }
            config.cancelBtn.snp.makeConstraints { make in
                make.height.equalToSuperview()
            }
        }
        if type.contains(.sure){
            bottomBtnView.addArrangedSubview(config.sureBtn)
            config.sureBtn.addEventHandler {[weak self]  in
                guard let weakSelf = self else {return}
                sureTap?(weakSelf.selectIndexArray)
                weakSelf.hidden()
            }
            config.sureBtn.snp.makeConstraints { make in
                make.height.equalToSuperview()
            }
        }
        if type.contains(.autoHidden){
            if contentView.subviews.contains(where: {$0 == bottomBtnView}){
                bottomBtnView.removeFromSuperview()
                tableView.snp.makeConstraints { make in
                    make.bottom.equalToSuperview().offset(-40.scale())
                }
            }
        }
        if type.contains(.allowsMultipleSelection){
            tableView.allowsMultipleSelection = true
        }
        
        self.contentView.sizeToFit()
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
        UIView.animate(withDuration: 0.2) {
            self.contentView.transform = CGAffineTransform.init(translationX: 0, y: -self.contentView.mj_h)
            self.grayView.alpha = 1.0
            self.contentView.alpha = 1.0
        }
    }
    
    //===<<<<< animate end
    public func hidden(){
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.grayView.alpha = 0
            strongSelf.contentView.transform = .identity
        } completion: { [weak self] b in
            guard let strongSelf = self else {return}
            if b {
                strongSelf.grayView.removeFromSuperview()
                strongSelf.contentView.removeFromSuperview()
                strongSelf.clearView.removeFromSuperview()
                strongSelf.deInstance()
            }
        }
    }
}
extension TSSActionSheetManager{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.actionSheet.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellClass = delegete?.registerTableViewWithClass(),let Identifier = delegete?.registerTableViewforCellReuseIdentifier(){
            tableView.register(cellClass.self, forCellReuseIdentifier: Identifier)
        }
        if let cellNib = delegete?.registerTableViewWithNib(),let Identifier = delegete?.registerTableViewforCellReuseIdentifier(){
            tableView.register(cellNib, forCellReuseIdentifier: Identifier)
        }
        guard let cell = delegete?.tableView(tableView, self.actionSheet[indexPath.row], cellForRowAt: indexPath) else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TSSActionSheetTableViewCell
            if let title = self.actionSheet[indexPath.row] as? String {
                cell.titleLab.text = title
            }
        return cell
        }
       
        
        return cell
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.singleSelection?(indexPath.row)
        if type.contains(.autoHidden){
            hidden()
        }
        if !selectIndexArray.contains(where: {$0 == indexPath.row}){
            selectIndexArray.append(indexPath.row)
        }
        
    }
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectIndexArray.removeAll(where: {$0 == indexPath.row})
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        config.rowHeight
    }
}
