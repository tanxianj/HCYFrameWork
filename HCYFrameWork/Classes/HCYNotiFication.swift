//
//  HCYNotFication.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 14/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import HCYFrameWork

public class HCYNotiFication{
    public var name:String
    public var obeserver:AnyObject?
    public var data:Any?
    public init(name:String,obeserver:AnyObject? = nil,data:Any? = nil){
        self.name = name
        self.obeserver = obeserver
        self.data = data
    }
    public func info(){
        DebugLog("\(name) \(String(describing: obeserver))  \(data)")
    }
    
}
public class HCYNotiFicationCenter{
    public static let shared = HCYNotiFicationCenter()
    private init(){}
    public var observer = Dictionary<String,Array<AnyObject>>()
    public var callBacks = Dictionary<String,Array<(_ notiFication:HCYNotiFication)->Void>>()
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
    
    public func removeAllObServer(name:String){
        self.observer.removeValue(forKey: name)
        self.callBacks.removeValue(forKey: name)
    }
    public func postNotiFication(notiFication:HCYNotiFication){
        let name = notiFication.name
        if  let arry = self.observer[name]{
            for i in 0..<arry.count {
                
                let notifi = HCYNotiFication(name: notiFication.name, data: notiFication.data)
                notifi.obeserver = arry[i]
                callBacks[name]![i](notifi)
            }
        }
    }
}
