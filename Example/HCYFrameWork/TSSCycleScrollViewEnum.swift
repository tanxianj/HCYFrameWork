
import Foundation
import UIKit
/// PageControl 的对齐方式
public enum XJCycleScrollViewPageControlAlignment {
    case center(offset: CGFloat)
    case right(rightOfset: CGFloat,bottomOfset:CGFloat)
    case left(leftOfset: CGFloat,bottomOfset:CGFloat)
}

/// PageControl 的 Style
/// 这个后面的 animated 需要加一些参数，让我们可以自由的配置
/// 或者再增加一些其他的自定义的 case
public enum XJCycleScrollViewPageControlStyle {
    case `default`
    case animated
}

