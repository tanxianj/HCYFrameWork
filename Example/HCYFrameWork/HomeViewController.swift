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
    let getUrl = "http://172.16.80.107:9527/api/user/getVerify"
    let postUrl = "http://172.16.80.107:9527/api/user/login"
    var captchaKey : String = ""
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.tabBarController?.tabBar.showBadgeOnItem(index: 2,badgeValue: "8888")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
//
//    HomeTest.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct HomeTest : Codable {

    let lastmodifiedDate : String?
    let nudgesInfo : [NudgesInfo]?


    enum CodingKeys: String, CodingKey {
        case lastmodifiedDate = "lastmodified_date"
        case nudgesInfo = "nudges_info"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lastmodifiedDate = try values.decodeIfPresent(String.self, forKey: .lastmodifiedDate)
        nudgesInfo = try values.decodeIfPresent([NudgesInfo].self, forKey: .nudgesInfo)
    }


}
struct NudgesInfo : Codable {

    let category : String?
    let categoryId : Int?
    let pCategory : String?
    let pCategoryId : Int?
    let subCategory : String?
    let subCategoryId : Int?
    let timeLineId : Int?
    let timeline : String?
    let imagePath : String?
    let nudgeId : Int?
    let nudgeName : String?
    let url : String?


    enum CodingKeys: String, CodingKey {
        case category = "Category"
        case categoryId = "CategoryId"
        case pCategory = "PCategory"
        case pCategoryId = "PCategoryId"
        case subCategory = "SubCategory"
        case subCategoryId = "SubCategoryId"
        case timeLineId = "TimeLineId"
        case timeline = "Timeline"
        case imagePath = "image_path"
        case nudgeId = "nudge_id"
        case nudgeName = "nudge_name"
        case url = "url"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
        pCategory = try values.decodeIfPresent(String.self, forKey: .pCategory)
        pCategoryId = try values.decodeIfPresent(Int.self, forKey: .pCategoryId)
        subCategory = try values.decodeIfPresent(String.self, forKey: .subCategory)
        subCategoryId = try values.decodeIfPresent(Int.self, forKey: .subCategoryId)
        timeLineId = try values.decodeIfPresent(Int.self, forKey: .timeLineId)
        timeline = try values.decodeIfPresent(String.self, forKey: .timeline)
        imagePath = try values.decodeIfPresent(String.self, forKey: .imagePath)
        nudgeId = try values.decodeIfPresent(Int.self, forKey: .nudgeId)
        nudgeName = try values.decodeIfPresent(String.self, forKey: .nudgeName)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }


}
