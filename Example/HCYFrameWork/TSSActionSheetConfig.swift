//
//  TSSActionSheetConfig.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 28/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
public class TSSActionSheetConfig{
    
    /// 距离左侧
    public var offset:CGFloat
    
    /// title
    public var title:String
    public var titleFont:UIFont
    public var titleTextColor:UIColor
    
    /// notice
    public var notice:String
    public var noticeFont:UIFont
    public var noticeTextColor:UIColor
    
    /// close View
    public var close:Any?
    
    /// bottom Btn Height
    public var bottomBtnHeight:CGFloat
    
    /// cancel Button
    public var cancelBtn:UIButton
    
    /// sure Button
    public var sureBtn:UIButton
    
    
    /// Action Sheet row Height
    public var rowHeight:CGFloat
    
    /// backView cornerRadius
    public var cornerRadius:CGFloat
    
    /// TableView allowsMultipleSelection? Default false
    public var allowsMultipleSelection:Bool
    public init(title:String = "",
                titleFont:UIFont = .systemFont(ofSize: 17.0.scale()),
                titleTextColor:UIColor = .black,
                
                notice:String = "",
                noticeFont:UIFont = .systemFont(ofSize: 15.0.scale()),
                noticeTextColor:UIColor = .black,
                
                close:Any? = nil,
                offset:CGFloat = 20.0.scale(),
                bottomBtnHeight:CGFloat = 55.scale(),
                cancelBtn:UIButton = UIButton(),
                sureBtn:UIButton = UIButton(),
                rowHeight:CGFloat = 50.scale(),
                cornerRadius:CGFloat = 0.0,
                allowsMultipleSelection:Bool = false
    ){
        self.title = title
        self.titleFont = titleFont
        self.titleTextColor = titleTextColor
        
        self.notice = notice
        self.noticeFont = noticeFont
        self.noticeTextColor =  noticeTextColor
        
        self.close = close
        
        self.offset  = offset
        
        self.bottomBtnHeight = bottomBtnHeight
        
        self.cancelBtn = cancelBtn
        
        self.sureBtn = sureBtn
        
        self.rowHeight = rowHeight
        self.cornerRadius = cornerRadius
        self.allowsMultipleSelection = allowsMultipleSelection
    }
}
