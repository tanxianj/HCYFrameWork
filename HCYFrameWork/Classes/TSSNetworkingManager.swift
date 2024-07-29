//
//  TSSNetworkingManager.swift

//
//  Created by Jupiter_TSS on 19/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//
import Alamofire
import RxSwift
open class TSSNetworkingManager{
    //MARK: success block
    public typealias success<T:Decodable> = (_ statusCode:Int,_ model:T,_ responseData:Any)->Void
    //MARK: failure block
    public typealias failure = (_ error:Error)->Void
    /// -单列
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
    ///   - dataModel: dataModel need inherit Decodable
    ///   - shouldCache: should Cache Default false
    ///   - success: -
    public func postRequestWith<T:Decodable>(url:String,
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
    ///   - dataModel: dataModel need inherit Decodable
    ///   - shouldCache: should Cache Default false
    ///   - success: -
    public func getRequestWith<T:Decodable>(url:String,
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
    public func baseRequestWith<T:Decodable>(method:HTTPMethod,
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
        .responseDecodable(of:T.self,completionHandler: { response in
            switch response.result{
            case .success(_):
                guard let statusCode = response.response?.statusCode else{return}
                guard let model = response.value else{return}
                guard let data = response.data else{return}
                
                TSSLog("✅URL ===>>> \(url) ")
                TSSLog("✅parameters ===>>> \(parameters ?? [String:Any]())")
                TSSLog("✅statusCode ===>>> \(response.response!.statusCode)")
                TSSLog("✅json ===>>> \n\(String(data: data, encoding: .utf8)!))")
                
                success(statusCode,model,data)
            case .failure(let error):
                TSSLog("URL:\(url) ❌error===>>>\(error)")
                failure(error)
            }
            
            
        })
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
    /// /// /// default api header
    public var header:HTTPHeaders? = nil
    
    /// init Networking Config
    /// - Parameters:
    ///   - header: api header
    public init(header:HTTPHeaders? = nil){
        self.header = header
    }
    
}

