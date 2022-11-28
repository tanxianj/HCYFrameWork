

import Foundation
import UIKit

protocol TSSCycleScrollViewDelegate: NSObjectProtocol {
    func cycleScrollView(_ scrollView: TSSCycleScrollView, didSelectItemAt index: Int)
    func cycleScrollView(_ scrollView: TSSCycleScrollView, didScrollTo index: Int)
    
    
    /** 如果你自定义了cell样式，请在实现此代理方法为你的cell填充数据以及其它一系列设置 */
    func setupCustomCell(cell:UICollectionViewCell,index:Int,view:TSSCycleScrollView)
    // ========== 轮播自定义cell ==========

    /** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
    func customCollectionViewCellClass()->AnyClass?
    /** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的Nib。 */
    func customCollectionViewCellNib()->String?
}

extension TSSCycleScrollViewDelegate {
    func cycleScrollView(_ scrollView: TSSCycleScrollView, didSelectItemAt index: Int) { }
    func cycleScrollView(_ scrollView: TSSCycleScrollView, didScrollTo index: Int) { }
    
    func customCollectionViewCellClass()->AnyClass?{
        return nil
    }
    func customCollectionViewCellNib()->String?{
        return nil
    }
}



protocol DotViewDelegate {
    func changeActivityState(active: Bool)
}

extension DotViewDelegate {
    func changeActivityState(active: Bool) { }
}
