//
//  TSSMJRefresh+Extension.swift
//  
//
//  Created by Jupiter_TSS on 13/7/22.
//

import Foundation
import MJRefresh
import RxSwift
import RxCocoa
open class TSSMJRefreshTools{
    
    /// scroll view pull refresh data
    /// - Parameter block: action
    /// - Returns: -
    public static func tss_header(block:@escaping MJRefreshComponentAction)->MJRefreshHeader{
        let header = MJRefreshNormalHeader(refreshingBlock: block)
        header.isAutomaticallyChangeAlpha = true
        //        header.lastUpdatedTimeLabel?.isHidden = true
        //        header.setAnimationDisabled()
        return header
        
    }
    
    /// scroll view pull up load data
    /// - Parameter block: action
    /// - Returns: -
    public static func tss_footer(block:@escaping MJRefreshComponentAction)->MJRefreshFooter{
        let footer = MJRefreshAutoNormalFooter(refreshingBlock: block)
        //        footer.setAnimationDisabled()
        footer.setTitle("", for: .idle)
        
        return footer
    }
}

public enum ScrollViewRefreshStatus {
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case noMoreData
    case resetNoMoreData
}

/* ============================ OutputRefreshProtocol ================================ */
// viewModel 中 output使用
public protocol ScrollViewRefreshProtocol {
    // 告诉外界的tableView当前的刷新状态
    var refreshStatus : BehaviorRelay<ScrollViewRefreshStatus> { get set }
}
extension ScrollViewRefreshProtocol {
    public func autoSetRefreshHeaderStatus(header: MJRefreshHeader?, footer: MJRefreshFooter?) -> Disposable {
        return refreshStatus.asObservable().subscribe(onNext: { (status) in
            switch status {
            case .beingHeaderRefresh:
                header?.beginRefreshing()
                footer?.endRefreshing()
                footer?.resetNoMoreData()
            case .endHeaderRefresh:
                header?.endRefreshing()
            case .beingFooterRefresh:
                footer?.beginRefreshing()
                header?.endRefreshing()
            case .endFooterRefresh:
                footer?.endRefreshing()
            case .noMoreData:
                footer?.endRefreshingWithNoMoreData()
            case .resetNoMoreData:
                footer?.resetNoMoreData()
            default:
                break
            }
        })
    }
}

/* ============================ Refreshable ================================ */
// 需要使用 MJExtension 的控制器使用
public protocol Refreshable {
    
}

extension Refreshable where Self : UIScrollView {
   public func initRefreshHeader(_ action: @escaping () -> Void) -> MJRefreshHeader? {
        mj_header = TSSMJRefreshTools.tss_header(block: action)
        return mj_header
    }
    
    public func initRefreshFooter(_ action: @escaping () -> Void) -> MJRefreshFooter? {
        mj_footer = TSSMJRefreshTools.tss_footer(block: action)
        return mj_footer
    }
}
extension Refreshable where Self : UITableView {
    public func initRefreshHeader(_ action: @escaping () -> Void) -> MJRefreshHeader? {
        mj_header = TSSMJRefreshTools.tss_header(block: action)
        return mj_header
    }
    
    public func initRefreshFooter(_ action: @escaping () -> Void) -> MJRefreshFooter? {
        mj_footer = TSSMJRefreshTools.tss_footer(block: action)
        return mj_footer
    }
}
extension Refreshable where Self : UICollectionView {
    public func initRefreshHeader(_ action: @escaping () -> Void) -> MJRefreshHeader? {
        mj_header = TSSMJRefreshTools.tss_header(block: action)
        return mj_header
    }
    
    public func initRefreshFooter(_ action: @escaping () -> Void) -> MJRefreshFooter? {
        mj_footer = TSSMJRefreshTools.tss_footer(block: action)
        return mj_footer
    }
}
extension Refreshable where Self : UIViewController {
    public func initRefreshHeader(_ scrollView: UIScrollView, _ action: @escaping () -> Void) -> MJRefreshHeader? {
        scrollView.mj_header = TSSMJRefreshTools.tss_header(block: action)
        return scrollView.mj_header
    }
    
    public func initRefreshFooter(_ scrollView: UIScrollView, _ action: @escaping () -> Void) -> MJRefreshFooter? {
        scrollView.mj_footer = TSSMJRefreshTools.tss_footer(block: action)
        return scrollView.mj_footer
    }
}
extension UIScrollView : Refreshable{}
