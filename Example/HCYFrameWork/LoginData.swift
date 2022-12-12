//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct LoginData : Codable {

    let captcha : String?
    let captchaKey : String?


    enum CodingKeys: String, CodingKey {
        case captcha = "captcha"
        case captchaKey = "captchaKey"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        captcha = try values.decodeIfPresent(String.self, forKey: .captcha)
        captchaKey = try values.decodeIfPresent(String.self, forKey: .captchaKey)
    }


}
