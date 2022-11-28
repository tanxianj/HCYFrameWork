//
//  Encodable+TSSExtension.swift
//
//  Created by Jupiter_TSS on 16/11/22.
//

import Foundation
fileprivate let encoder = JSONEncoder()
fileprivate let decoder = JSONDecoder()
extension Encodable{
    /// to Data
    /// - Returns: Data
    func toData()->Data?{
        return try? encoder.encode(self)
    }
    
    /// to Dictionary
    /// - Returns: Dictionary
    func toDictionary()->[String:Any]?{
        if let data = toData(){
            return try? JSONSerialization.jsonObject(with: data,options: .allowFragments) as? [String:Any]
        }else{
            return nil
        }
    }
    
    /// to Dictionary Array
    /// - Returns: Dictionary Array
    func toDictionaryArray()->[[String:Any]]?{
        if let data = toData(){
            return try? JSONSerialization.jsonObject(with: data,options: .allowFragments) as? [[String:Any]]
        }else{
            return nil
        }
    }
}
extension Data{
    func toModel<T:Codable>(model:T.Type)->T?{
        return try? decoder.decode(T.self, from: self)
    }
    func toString()->String?{
        return String(data: self, encoding: .utf8)
    }
}
