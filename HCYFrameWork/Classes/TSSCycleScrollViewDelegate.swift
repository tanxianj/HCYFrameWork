

import Foundation
import UIKit
public protocol TSSCycleScrollViewDelegate: NSObjectProtocol {
    
    /// optional banner 点击回调
    /// - Parameters:
    ///   - scrollView: banner
    ///   - index: 点击index
    func cycleScrollView(_ scrollView: TSSCycleScrollView, didSelectItemAt index: Int)
    
    /// optional banner 自动滚动回调
    /// - Parameters:
    ///   - scrollView: banner
    ///   - index: 自动滚动 index
    func cycleScrollView(_ scrollView: TSSCycleScrollView, didScrollTo index: Int)
    
    
    
    /// 默认Cell：TSSCycleScrollViewDefaultCell
    /// 如果你自定义了cell样式，请在实现此代理方法为你的cell填充数据以及其它一系列设置
    /// - Parameters:
    ///   - cell: cell
    ///   - index: index
    ///   - view: TSSCycleScrollView
    func setupCustomCell(cell:UICollectionViewCell,index:Int,view:TSSCycleScrollView)
    // ========== 轮播自定义cell ==========

    
    ///  optional 因为内部没做 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。
    /// - Returns: Cell Class
    func customCollectionViewCellClass()->AnyClass?
    /**optional  */
    
    /// optional 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的Nib。
    /// - Returns: Cell XibName 确保Cell Xib Name 与Cell Identifier 相同
    func customCollectionViewCellNib()->String?
}

public extension TSSCycleScrollViewDelegate {
    
    func cycleScrollView(_ scrollView: TSSCycleScrollView, didSelectItemAt index: Int) { }
    func cycleScrollView(_ scrollView: TSSCycleScrollView, didScrollTo index: Int) { }
    
    func customCollectionViewCellClass()->AnyClass?{
        return nil
    }
    func customCollectionViewCellNib()->String?{
        return nil
    }
}



public protocol TSSCycleScrollViewDotViewDelegate {
    func changeActivityState(active: Bool)
}

public extension TSSCycleScrollViewDotViewDelegate {
    func changeActivityState(active: Bool) { }
}
public protocol TSSXPageControlDelegate: NSObjectProtocol {
    func TSSPageControl(_ pageControl: TSSCycleScrollViewPageControl, didSelectPageAt index: Int)
}

public extension TSSXPageControlDelegate {
    func TSSPageControl(_ pageControl: TSSCycleScrollViewPageControl, didSelectPageAt index: Int) { }
}
