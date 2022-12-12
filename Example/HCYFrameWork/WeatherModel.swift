//
//	WeatherModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
//api: https://v0.yiketianqi.com/api?unescape=1&version=v91&appid=43656176&appsecret=I42og6Lm&ext=&cityid=101270101&city=%E6%88%90%E9%83%BD
struct WeatherModel : Codable {

	let city : String?
	let cityEn : String?
	let cityid : String?
	let country : String?
	let countryEn : String?
	let data : [WeatherData]?
	let nums : Int?
	let updateTime : String?


	enum CodingKeys: String, CodingKey {
		case city = "city"
		case cityEn = "cityEn"
		case cityid = "cityid"
		case country = "country"
		case countryEn = "countryEn"
		case data = "data"
		case nums = "nums"
		case updateTime = "update_time"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		cityEn = try values.decodeIfPresent(String.self, forKey: .cityEn)
		cityid = try values.decodeIfPresent(String.self, forKey: .cityid)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		countryEn = try values.decodeIfPresent(String.self, forKey: .countryEn)
		data = try values.decodeIfPresent([WeatherData].self, forKey: .data)
		nums = try values.decodeIfPresent(Int.self, forKey: .nums)
		updateTime = try values.decodeIfPresent(String.self, forKey: .updateTime)
	}


}
