//
//	WeatherData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct WeatherData : Codable {

	let air : String?
	let airLevel : String?
	let airTips : String?
	let alarm : [String]?
	let date : String?
	let day : String?
	let humidity : String?
	let moonPhrase : String?
	let moonrise : String?
	let moonset : String?
	let narrative : String?
	let phrase : String?
	let pressure : String?
	let rain : String?
	let sunrise : String?
	let sunset : String?
	let tem : String?
	let tem1 : String?
	let tem2 : String?
	let uvDescription : String?
	let uvIndex : String?
	let visibility : String?
	let wea : String?
	let weaDay : String?
	let weaDayImg : String?
	let weaImg : String?
	let weaNight : String?
	let weaNightImg : String?
	let week : String?
	let win : [String]?
	let winMeter : String?
	let winSpeed : String?


	enum CodingKeys: String, CodingKey {
		case air = "air"
		case airLevel = "air_level"
		case airTips = "air_tips"
		case alarm = "alarm"
		case date = "date"
		case day = "day"
		case humidity = "humidity"
		case moonPhrase = "moonPhrase"
		case moonrise = "moonrise"
		case moonset = "moonset"
		case narrative = "narrative"
		case phrase = "phrase"
		case pressure = "pressure"
		case rain = "rain"
		case sunrise = "sunrise"
		case sunset = "sunset"
		case tem = "tem"
		case tem1 = "tem1"
		case tem2 = "tem2"
		case uvDescription = "uvDescription"
		case uvIndex = "uvIndex"
		case visibility = "visibility"
		case wea = "wea"
		case weaDay = "wea_day"
		case weaDayImg = "wea_day_img"
		case weaImg = "wea_img"
		case weaNight = "wea_night"
		case weaNightImg = "wea_night_img"
		case week = "week"
		case win = "win"
		case winMeter = "win_meter"
		case winSpeed = "win_speed"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		air = try values.decodeIfPresent(String.self, forKey: .air)
		airLevel = try values.decodeIfPresent(String.self, forKey: .airLevel)
		airTips = try values.decodeIfPresent(String.self, forKey: .airTips)
		alarm = try values.decodeIfPresent([String].self, forKey: .alarm)
		date = try values.decodeIfPresent(String.self, forKey: .date)
		day = try values.decodeIfPresent(String.self, forKey: .day)
		humidity = try values.decodeIfPresent(String.self, forKey: .humidity)
		moonPhrase = try values.decodeIfPresent(String.self, forKey: .moonPhrase)
		moonrise = try values.decodeIfPresent(String.self, forKey: .moonrise)
		moonset = try values.decodeIfPresent(String.self, forKey: .moonset)
		narrative = try values.decodeIfPresent(String.self, forKey: .narrative)
		phrase = try values.decodeIfPresent(String.self, forKey: .phrase)
		pressure = try values.decodeIfPresent(String.self, forKey: .pressure)
		rain = try values.decodeIfPresent(String.self, forKey: .rain)
		sunrise = try values.decodeIfPresent(String.self, forKey: .sunrise)
		sunset = try values.decodeIfPresent(String.self, forKey: .sunset)
		tem = try values.decodeIfPresent(String.self, forKey: .tem)
		tem1 = try values.decodeIfPresent(String.self, forKey: .tem1)
		tem2 = try values.decodeIfPresent(String.self, forKey: .tem2)
		uvDescription = try values.decodeIfPresent(String.self, forKey: .uvDescription)
		uvIndex = try values.decodeIfPresent(String.self, forKey: .uvIndex)
		visibility = try values.decodeIfPresent(String.self, forKey: .visibility)
		wea = try values.decodeIfPresent(String.self, forKey: .wea)
		weaDay = try values.decodeIfPresent(String.self, forKey: .weaDay)
		weaDayImg = try values.decodeIfPresent(String.self, forKey: .weaDayImg)
		weaImg = try values.decodeIfPresent(String.self, forKey: .weaImg)
		weaNight = try values.decodeIfPresent(String.self, forKey: .weaNight)
		weaNightImg = try values.decodeIfPresent(String.self, forKey: .weaNightImg)
		week = try values.decodeIfPresent(String.self, forKey: .week)
		win = try values.decodeIfPresent([String].self, forKey: .win)
		winMeter = try values.decodeIfPresent(String.self, forKey: .winMeter)
		winSpeed = try values.decodeIfPresent(String.self, forKey: .winSpeed)
	}


}