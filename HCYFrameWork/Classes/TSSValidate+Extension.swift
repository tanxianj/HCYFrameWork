//
//  TSSValidate+Extension.swift
//  TSSFrameWork
//
//  Created by Jupiter_TSS on 14/7/22.
//

import Foundation
//MARK: - validate
public enum TSSValidate {
    case email(_: String)          //  email
    case phoneNumber(_: String)    //  mobileNumber
    case userName(_: String)       //  username
    case password(_: String)       //  password
    case nickName(_: String)       //  nickname
    case postalCode(_:String)      //  postcode
    case URL(_: String)            //  URL
    case IP(_: String)             //  IP
    case money(_: String)          // money
    case onlyNumber(_:String,_:Int)// onlyNumber  limit Length
    case numberSpace(_:String,_:Int)//
    var isRight: Bool {
        var predicateStr:String!
        var currentObject:String!
        switch self {
        case let .email(str):
            predicateStr = "^([A-Za-z0-9*_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            currentObject = str
        case let .phoneNumber(str):
            predicateStr = "^((1[34578][0-9]{9})|((0\\d{2}-\\d{8})|(0\\d{3}-\\d{7,8})|(0\\d{10,11}))$"
            currentObject = str
        case let .userName(str):
            predicateStr = "^([\\u4E00-\\u9FA5A-Za-z0-9_]{2,10}$)"
            currentObject = str
        case let .postalCode(str):
            predicateStr = "^[0-8]\\d{5}(?!\\d)$"
            currentObject = str
        case let .password(str):
            predicateStr = "^[a-zA-Z0-9]{6,20}+$"
            currentObject = str
        case let .nickName(str):
            predicateStr = "^([\\u4E00-\\u9FA5A-Za-z0-9_]{2,10}$)"
            currentObject = str
        case let .URL(str):
//            predicateStr = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
            predicateStr = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?,:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?,:_/=<>]*)?)"
            currentObject = str
        case let .IP(str):
            predicateStr = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
            currentObject = str
        case let .money(str):
            
            /*
             // 只允许输入数字和两位小数
                  "^[0-9]*((\\.)[0-9]{0,2})?$"
             //只允许输入纯数字
             "^[0-9]*([0-9])?$"
             //允许输入数字和字母
             "^[A-Za-z0-9]+$"
             
             */
            predicateStr = "^[0-9]*((\\.)[0-9]{0,2})?$"
            currentObject = str
        case let .onlyNumber(str, count):
            predicateStr = "^[0-9]{0,\(count)}?$"
            currentObject = str
        case let .numberSpace(str, count):
            predicateStr = "^[0-9\\ ]{0,\(count)}?$"
            currentObject = str
        }
        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
        return predicate.evaluate(with: currentObject)
    }
}
