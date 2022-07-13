//
//  HCYLabel.swift
//  TestframeWork
//
//  Created by Jupiter_TSS on 11/7/22.
//

import Foundation
import UIKit

/// Label Alignment  and Vertical
public struct HCYLabelAlignment : OptionSet {
    public var rawValue: UInt
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    public static var VerticalTop :HCYLabelAlignment { return  HCYLabelAlignment(rawValue: 0) }
    public static var VerticalMiddle: HCYLabelAlignment { return  HCYLabelAlignment(rawValue: 1<<0) }

    public static var VerticalBottom: HCYLabelAlignment { return  HCYLabelAlignment(rawValue: 1 << 1) }

    public static var HorizontalLeft: HCYLabelAlignment { return  HCYLabelAlignment(rawValue: 1 << 2) }
    public static var HorizontalMiddle: HCYLabelAlignment { return  HCYLabelAlignment(rawValue: 1 << 3) }
    public static var HorizontalRight: HCYLabelAlignment { return  HCYLabelAlignment(rawValue: 1 << 4) }
    
    
    public static var topleft:HCYLabelAlignment{return HCYLabelAlignment(rawValue: VerticalTop.rawValue | HorizontalLeft.rawValue)}
    
    public static var topMiddle:HCYLabelAlignment{return HCYLabelAlignment(rawValue: VerticalTop.rawValue | HorizontalMiddle.rawValue)}
    
    public static var topright:HCYLabelAlignment{return HCYLabelAlignment(rawValue: VerticalTop.rawValue | HorizontalRight.rawValue)}
    
    
    public static var MiddleLeft:HCYLabelAlignment{return HCYLabelAlignment(rawValue: VerticalMiddle.rawValue | HorizontalLeft.rawValue)}
    public static var center:HCYLabelAlignment{return HCYLabelAlignment(rawValue: VerticalMiddle.rawValue | HorizontalMiddle.rawValue)}
    public static var Middleright:HCYLabelAlignment{return HCYLabelAlignment(rawValue: VerticalMiddle.rawValue | HorizontalRight.rawValue)}
    
    
    
    public static var bottomLeft:HCYLabelAlignment{return HCYLabelAlignment(rawValue: VerticalBottom.rawValue | HorizontalLeft.rawValue)}
    
    public static var bottomMiddle:HCYLabelAlignment{return HCYLabelAlignment(rawValue: VerticalBottom.rawValue | HorizontalMiddle.rawValue)}
    
    public static var bottomright:HCYLabelAlignment{return HCYLabelAlignment(rawValue: VerticalBottom.rawValue | HorizontalRight.rawValue)}
    
    
    
    
}



/// HCYLabel
open class HCYLabel:UIView{
    
    private let textLab = UILabel()
    public var text:String!{
        didSet{
            textLab.text = text
        }
    }
    
    public var numberOfLines:Int! = 0{
        didSet{
            textLab.numberOfLines = numberOfLines
        }
    }
    public var attributedText:NSAttributedString!{
        didSet{
            textLab.attributedText = attributedText
        }
    }
    public var textColor:UIColor! {
        didSet{
            textLab.textColor = textColor
        }
    }
    public var fontSize:CGFloat!{
        didSet{
            textLab.font = textLab.font.withSize(fontSize.scale())
        }
    }
    public var font:UIFont!{
        didSet{
            textLab.font = font
        }
    }


    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(textLab)
        textLab.text = "HCYLabel"
        textLab.textColor = self.textColor
        textLab.font = self.font
        textLab.numberOfLines = self.numberOfLines
    }
    public convenience init(frame: CGRect ,alignment:HCYLabelAlignment) {
        self.init(frame: frame)
        
        if alignment.contains(.VerticalTop){
            textLab.snp.remakeConstraints { make in
                make.left.right.top.equalToSuperview()
                make.bottom.lessThanOrEqualToSuperview().offset(7.0)
            }
        }
        if alignment.contains(.VerticalMiddle){
            textLab.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.center.equalToSuperview()
            }
        }
        if alignment.contains(.VerticalBottom){
            textLab.snp.remakeConstraints { make in
                make.left.right.bottom.equalToSuperview()
                make.top.greaterThanOrEqualToSuperview().offset(7.0.scale())
            }
        }
        
        
        if alignment.contains(.VerticalTop) && alignment.contains(.VerticalBottom){
            fatalError("Vertical mutex")
        }
        if alignment.contains(.VerticalTop) && alignment.contains(.VerticalMiddle){
            fatalError("Vertical mutex")
        }
        if alignment.contains(.VerticalBottom) && alignment.contains(.VerticalMiddle){
            fatalError("Vertical mutex")
        }
        
        
        
        if alignment.contains(.HorizontalLeft){
            textLab.textAlignment = .left
        }
        if alignment.contains(.HorizontalMiddle){
            textLab.textAlignment = .center
        }
        if alignment.contains(.HorizontalRight){
            textLab.textAlignment = .right
        }
        
        if alignment.contains(.HorizontalLeft) && alignment.contains(.HorizontalRight){
            fatalError("textAlignment mutex")
        }
        if alignment.contains(.HorizontalLeft) && alignment.contains(.HorizontalMiddle){
            fatalError("textAlignment mutex")
        }
        if alignment.contains(.HorizontalRight) && alignment.contains(.HorizontalMiddle){
            fatalError("textAlignment mutex")
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
