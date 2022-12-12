//
//	LoginModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import HCYFrameWork


struct LoginModel : Codable {

    let code : Int?
    let data : LoginData?
    let msg : String?


    enum CodingKeys: String, CodingKey {
        case code = "code"
        case data = "data"
        case msg = "msg"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        data = try LoginData(from: decoder)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }


}
