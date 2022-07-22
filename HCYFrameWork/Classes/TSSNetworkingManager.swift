//
//  TSSNetworkingManager.swift

//
//  Created by Jupiter_TSS on 19/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//
import Alamofire
import RxSwift
open class TSSNetworkingManager{
    
    public typealias success<T:TSSBaseModelProtocol> = (_ statusCode:Int,_ model:T,_ responseData:Any)->Void
    public typealias failure = (_ error:Error)->Void
    /// -
    private static var _sharedInstance:TSSNetworkingManager?
    
    /// 禁止调用 init
    private init(){}
    /// 单列
    /// - Returns: TSSNetworkingManager
    public class func sharedInstance()->TSSNetworkingManager{
        guard let Instance = _sharedInstance else {
            _sharedInstance = TSSNetworkingManager()
            return _sharedInstance!
        }
        return Instance
    }
    
    /// 销毁单列
    public class func desharedInstance(){
        TSSNetworkingManager._sharedInstance = nil
    }
    
    //sessionManager
    private lazy var sessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        return Session(configuration: configuration)
    }()
    
    /// header Default nil
    fileprivate var config:TSSNetworkingConfig = TSSNetworkingConfig()
    
}


extension TSSNetworkingManager{
    
    /// post
    /// - Parameters:
    ///   - url: -
    ///   - parameters: -
    ///   - dataModel: dataModel need inherit TSSBaseModelProtocol
    ///   - shouldCache: should Cache Default false
    ///   - success: -
    open func postRequestWith<T:TSSBaseModelProtocol>(url:String,
                                                      parameters:[String:Any]?  = [:],
                                                      timeOut:TimeInterval = 15,
                                                      encoding:ParameterEncoding = URLEncoding.default,
                                                      dataModel:T.Type,
                                                      success:@escaping success<T>,
                                                      failure:@escaping failure){
        return baseRequestWith(method: .post,
                               url:url,
                               parameters: parameters,
                               timeOut:timeOut,
                               encoding: encoding,
                               dataModel: dataModel,
                               success: success,
                               failure:failure)
    }
    
    /// get
    /// - Parameters:
    ///   - url: -
    ///   - parameters: -
    ///   - dataModel: dataModel need inherit TSSBaseModelProtocol
    ///   - shouldCache: should Cache Default false
    ///   - success: -
    open func getRequestWith<T:TSSBaseModelProtocol>(url:String,
                                                     parameters:[String:Any]?  = [:],
                                                     timeOut:TimeInterval = 15,
                                                     encoding:ParameterEncoding = URLEncoding.default,
                                                     dataModel:T.Type,
                                                     success:@escaping success<T>,
                                                     failure:@escaping failure){
        return baseRequestWith(method: .get,
                               url:url,
                               parameters: parameters,
                               timeOut:timeOut,
                               encoding: encoding,
                               dataModel: dataModel,
                               success: success,
                               failure:failure)
    }
    
    /// Base Request
    /// - Parameters:
    ///   - method: HTTP method
    ///   - url: url
    ///   - parameters: parameters
    ///   - encoding: encoding
    ///   - dataModel: data Model
    ///   - success: success block
    ///   - failure: failure block
    open func baseRequestWith<T:TSSBaseModelProtocol>(method:HTTPMethod,
                                                      url:String,
                                                      parameters:[String:Any]?  = [:],
                                                      timeOut:TimeInterval = 15,
                                                      encoding:ParameterEncoding = URLEncoding.default,
                                                      dataModel:T.Type,
                                                      success:@escaping success<T>,
                                                      failure:@escaping failure){
        self.sessionManager.request(url,
                                    method: method,
                                    parameters: parameters,
                                    encoding: encoding,
                                    headers: config.header,
                                    requestModifier: {$0.timeoutInterval = timeOut})
        .validate()
        .responseJSON { response in
            switch response.result{
            case .success(let value):
                DebugLog("✅URL ===>>> \(url) ")
                DebugLog("✅parameters ===>>> \(parameters ?? [String:Any]())")
                DebugLog("✅statusCode ===>>> \(response.response!.statusCode)")
                DebugLog("✅json ===>>> \n\(value)")
                if let datasource = value as? [String:Any] {
                    let model = dataModel.init(fromDictionary: datasource)
                    success(response.response!.statusCode,model,value)
                }
                
            case .failure(let error):
                DebugLog("URL:\(url) ❌error===>>>\(error)")
                failure(error)
            }
        }
    }
    
}
/// Base Model Protocol
public protocol TSSBaseModelProtocol{
    init(fromDictionary dictionary: [String:Any])
    func toDictionary() -> [String:Any]
}

/// Default Model
public struct TSSBaseModel:TSSBaseModelProtocol{
    public var code : Int!
    public var data : Any!
    public var msg : String!
    
    public init(fromDictionary dictionary: [String : Any]) {
        code = dictionary[TSSNetworkingManager.sharedInstance().config.code] as? Int
        data = dictionary[TSSNetworkingManager.sharedInstance().config.data]
        msg = dictionary[TSSNetworkingManager.sharedInstance().config.msg] as? String
    }
    
    public func toDictionary() -> [String : Any] {
        var dictionary = [String:Any]()
        if code != nil{
            dictionary[TSSNetworkingManager.sharedInstance().config.code] = code
        }
        if data != nil{
            dictionary[TSSNetworkingManager.sharedInstance().config.data] = data
        }
        if msg != nil{
            dictionary[TSSNetworkingManager.sharedInstance().config.msg] = msg
        }
        return dictionary
    }
    
    
}
extension TSSNetworkingManager{
    
    /// rest  Networking Config
    /// - Parameter config: config
    public func restConfig(_ config:TSSNetworkingConfig){
        self.config =  config
    }
}

/// Networking Config
public class TSSNetworkingConfig{
    
    /// default code name
    public var code:String = "code"
    
    /// default data name
    public var data:String = "data"
    
    /// /// default msg name
    public var msg:String = "msg"
    
    /// /// /// default api header
    public var header:HTTPHeaders? = nil
    
    /// init Networking Config
    /// - Parameters:
    ///   - code: code name
    ///   - data: data name
    ///   - msg: msg name
    ///   - header: api header
    public init(code:String = "code",data:String = "data", msg:String = "msg",header:HTTPHeaders? = nil){
        self.code = code
        self.data = data
        self.msg = msg
        self.header = header
    }
    
}
