//
//  TSSBaseViewModelType.swift
//  TSSFrameWork
//
//  Created by Jupiter_TSS on 18/7/22.
//

import Foundation
public protocol TSSBaseViewModelType{
    associatedtype Input
    associatedtype Output
    
    var input : Input{ get }
    var output : Output { get }
}
