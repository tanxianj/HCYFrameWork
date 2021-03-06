//
//  HomeViewController.swift
//  ProjectMould
//
//  Created by Jupiter_TSS on 1/6/22.
//

import UIKit
import SVGKit
import HCYFrameWork
import Kingfisher
import Alamofire
import RxSwift
class HomeViewController: TSSBaseViewController {
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var codeImageV: UIImageView!
    let getUrl = "http://172.16.80.107:9527/api/user/getVerify2"
    var captchaKey : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        
        
        
        
        
        let md5 = "12345".md5
        DebugLog("12345 md5 is \(md5)")
        // 827CCB0EEA8A706C4C34A16891F84E7B
    }

   
    @IBAction func getBtn(_ sender: Any) {
        TSSNetworkingManager.sharedInstance().getRequestWith(url: "http://172.16.80.107:9527/api/user/getVerify",timeOut: 1,dataModel: LoginModel.self) { statusCode, model, responseData in
            self.captchaKey = model.data.captchaKey
            let base64String =  model.data.captcha.replacingOccurrences(of: "data:image/png;base64,", with: "")
            let base64EncodeData = Data(base64Encoded: base64String,options:Data.Base64DecodingOptions.ignoreUnknownCharacters)

            self.codeImageV.image = UIImage(data: base64EncodeData!)
        } failure: { error in
        
        }
       
    }
    
    
    @IBAction func postBtn(_ sender: UIButton) {
        TSSNetworkingManager.sharedInstance().postRequestWith(url: "http://172.16.80.107:9527/api/user/login",parameters: ["username":"lei","password":"MTIzNDU2aGN5X3NoYXJlZF9iaWtlc0AyMDIy","captcha":self.codeTextField.text ?? "","captchaKey":self.captchaKey],timeOut: 10,encoding: JSONEncoding.default, dataModel: TSSBaseModel.self) { statusCode, model, responseData in
            
        } failure: { error in
            
        }
        
        

        
        
    }
}
