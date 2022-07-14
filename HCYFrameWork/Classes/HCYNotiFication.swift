//
//  HCYNotFication.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 14/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import HCYFrameWork

/// one to more send NotiFication
public class HCYNotiFication{
    
    /// NotiFication name
    public var name:String
    
    /// NotiFication observer
    public var observer:AnyObject?
    
    /// NotiFication  data
    public var data:Any?
    
    /// init
    /// - Parameters:
    ///   - name: NotiFication name
    ///   - obeserver: NotiFication observer
    ///   - data: NotiFication  data
    public init(name:String,obeserver:AnyObject? = nil,data:Any? = nil){
        self.name = name
        self.observer = obeserver
        self.data = data
    }
    
    /// print info
    public func info(){
        DebugLog("\(name) \(String(describing: observer))  \(data ?? "")")
    }
    
}

/// NotiFication Center
public class HCYNotiFicationCenter{
    
    /// 单列
    public static let shared = HCYNotiFicationCenter()
    
    /// 禁止使用 init 方式初始化
    private init(){}
    
    /// observer  name :[observer]
    public var observer = Dictionary<String,Array<AnyObject>>()
    
    /// callBacks
    public var callBacks = Dictionary<String,Array<(_ notiFication:HCYNotiFication)->Void>>()
    
    /// addObserver
    /// - Parameters:
    ///   - name:NotiFication  name
    ///   - object: NotiFication object  self
    ///   - callback: action
    public func addObserver(name:String,object:AnyObject,callback:@escaping (_ notiFication:HCYNotiFication)->Void){
        if self.observer[name] != nil {
            self.observer[name]?.append(object)
            callBacks[name]?.append(callback)
        }else{
            var array = Array<AnyObject>()
            var callbackArray = Array<(_ notiFication:HCYNotiFication)->Void>()
            array.append(object)
            callbackArray.append(callback)
            
            
            observer[name] = array
            callBacks[name] =  callbackArray
        }
    }
    
    /// remove ObServer
    /// - Parameter name: notiFication name
    public func removeAllObServer(name:String){
        self.observer.removeValue(forKey: name)
        self.callBacks.removeValue(forKey: name)
    }
    
    /// send notiFication
    /// - Parameter notiFication: notiFication
    public func postNotiFication(notiFication:HCYNotiFication){
        let name = notiFication.name
        if  let arry = self.observer[name]{
            for i in 0..<arry.count {
                
                let notifi = HCYNotiFication(name: notiFication.name, data: notiFication.data)
                notifi.observer = arry[i]
                callBacks[name]![i](notifi)
            }
        }
    }
}
