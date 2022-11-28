//
//  TSSLabel.swift
//  
//
//  Created by Jupiter_TSS on 11/7/22.
//

import Foundation
import UIKit

/// Label Alignment  and Vertical
public struct TSSLabelAlignment : OptionSet {
    public var rawValue: UInt
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    public static var VerticalTop :TSSLabelAlignment { return  TSSLabelAlignment(rawValue: 1 << 0) }
    
    public static var VerticalMiddle: TSSLabelAlignment { return  TSSLabelAlignment(rawValue: 1 << 1) }

    public static var VerticalBottom: TSSLabelAlignment { return  TSSLabelAlignment(rawValue: 1 << 2) }

    
    
    public static var HorizontalLeft: TSSLabelAlignment { return  TSSLabelAlignment(rawValue: 1 << 3) }
    
    public static var HorizontalMiddle: TSSLabelAlignment { return  TSSLabelAlignment(rawValue: 1 << 4) }
    
    public static var HorizontalRight: TSSLabelAlignment { return  TSSLabelAlignment(rawValue: 1 << 5) }
    
    
    public static var topleft:TSSLabelAlignment{return TSSLabelAlignment(rawValue: VerticalTop.rawValue | HorizontalLeft.rawValue)}
    
    public static var topMiddle:TSSLabelAlignment{return TSSLabelAlignment(rawValue: VerticalTop.rawValue | HorizontalMiddle.rawValue)}
    
    public static var topright:TSSLabelAlignment{return TSSLabelAlignment(rawValue: VerticalTop.rawValue | HorizontalRight.rawValue)}
    
    
    public static var MiddleLeft:TSSLabelAlignment{return TSSLabelAlignment(rawValue: VerticalMiddle.rawValue | HorizontalLeft.rawValue)}
    public static var center:TSSLabelAlignment{return TSSLabelAlignment(rawValue: VerticalMiddle.rawValue | HorizontalMiddle.rawValue)}
    public static var Middleright:TSSLabelAlignment{return TSSLabelAlignment(rawValue: VerticalMiddle.rawValue | HorizontalRight.rawValue)}
    
    
    
    public static var bottomLeft:TSSLabelAlignment{return TSSLabelAlignment(rawValue: VerticalBottom.rawValue | HorizontalLeft.rawValue)}
    
    public static var bottomMiddle:TSSLabelAlignment{return TSSLabelAlignment(rawValue: VerticalBottom.rawValue | HorizontalMiddle.rawValue)}
    
    public static var bottomright:TSSLabelAlignment{return TSSLabelAlignment(rawValue: VerticalBottom.rawValue | HorizontalRight.rawValue)}
    
    
    
    
}



/// TSSLabel
open class TSSLabel:UIView{
    
//    private let textLab = UILabel()
    private lazy var textLab:UILabel = {
        let textLab = UILabel()
        return textLab
    }()
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
    private override init(frame: CGRect) {
        super.init(frame: frame)   
        self.addSubview(textLab)
    }
    public convenience init(frame: CGRect,
                            alignment:TSSLabelAlignment,
                            text:String? = "TSSLabel",
                            textColor:UIColor = .black,
                            font:UIFont = UIFont.systemFont(ofSize: 17.scale()),
                            numberOfLines:Int = 1,
                            attributedText:NSAttributedString? = nil) {
        
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
        
        
        
        
        self.textLab.text = text
        self.textLab.textColor = textColor
        self.textLab.font = font
        self.textLab.numberOfLines = numberOfLines
        if let _ = attributedText{
            self.textLab.attributedText = attributedText
        }
        
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented")
    }
}
