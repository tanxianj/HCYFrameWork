//
//  NetWorkViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 1/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import SVGKit
import HCYFrameWork
import Kingfisher
import Alamofire
import RxSwift
class NetWorkViewController: TSSBaseViewController {
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var codeImageV: UIImageView!
    let getUrl = "http://172.16.80.107:9527/api/user/getVerify"
    let postUrl = "http://172.16.80.107:9527/api/user/login"
    var captchaKey : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
     @IBAction func getBtn(_ sender: Any) {
         TSSNetworkingManager.sharedInstance().getRequestWith(url: getUrl, dataModel: LoginModel.self, success: { statusCode, model, responseData in
             self.captchaKey = model.data!.captchaKey!
             let base64String =  model.data!.captcha!.replacingOccurrences(of: "data:image/png;base64,", with: "")
             let base64EncodeData = Data(base64Encoded: base64String,options:Data.Base64DecodingOptions.ignoreUnknownCharacters)

             self.codeImageV.image = UIImage(data: base64EncodeData!)
         }, failure: { error in
             
         })
             
        
     }
     
     
     @IBAction func postBtn(_ sender: UIButton) {
         TSSNetworkingManager.sharedInstance().postRequestWith(url: postUrl,
                                                               parameters: ["username":"lei",
                                                                            "password":"MTIzNDU2aGN5X3NoYXJlZF9iaWtlc0AyMDIy",
                                                                            "captcha":self.codeTextField.text ?? "",
                                                                            "captchaKey":self.captchaKey],
                                                               dataModel: LoginModel.self, success: { statusCode, model, responseData in
             
         }, failure: { error in
             
         })
             
         
     }
}
