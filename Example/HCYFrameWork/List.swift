//
//	List.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct List{

	var airQuality : String!
	var city : String!
	var date : String!
	var dateLong : Int!
	var high : Int!
	var humidity : String!
	var lastUpdateTime : String!
	var low : Int!
	var moreData : MoreData!
	var pm25 : Int!
	var province : String!
	var weather : String!
	var weatherType : Int!
	var wind : String!
	var windLevel : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		airQuality = dictionary["airQuality"] as? String
		city = dictionary["city"] as? String
		date = dictionary["date"] as? String
		dateLong = dictionary["dateLong"] as? Int
		high = dictionary["high"] as? Int
		humidity = dictionary["humidity"] as? String
		lastUpdateTime = dictionary["lastUpdateTime"] as? String
		low = dictionary["low"] as? Int
		if let moreDataData = dictionary["moreData"] as? [String:Any]{
				moreData = MoreData(fromDictionary: moreDataData)
			}
		pm25 = dictionary["pm25"] as? Int
		province = dictionary["province"] as? String
		weather = dictionary["weather"] as? String
		weatherType = dictionary["weatherType"] as? Int
		wind = dictionary["wind"] as? String
		windLevel = dictionary["windLevel"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if airQuality != nil{
			dictionary["airQuality"] = airQuality
		}
		if city != nil{
			dictionary["city"] = city
		}
		if date != nil{
			dictionary["date"] = date
		}
		if dateLong != nil{
			dictionary["dateLong"] = dateLong
		}
		if high != nil{
			dictionary["high"] = high
		}
		if humidity != nil{
			dictionary["humidity"] = humidity
		}
		if lastUpdateTime != nil{
			dictionary["lastUpdateTime"] = lastUpdateTime
		}
		if low != nil{
			dictionary["low"] = low
		}
		if moreData != nil{
			dictionary["moreData"] = moreData.toDictionary()
		}
		if pm25 != nil{
			dictionary["pm25"] = pm25
		}
		if province != nil{
			dictionary["province"] = province
		}
		if weather != nil{
			dictionary["weather"] = weather
		}
		if weatherType != nil{
			dictionary["weatherType"] = weatherType
		}
		if wind != nil{
			dictionary["wind"] = wind
		}
		if windLevel != nil{
			dictionary["windLevel"] = windLevel
		}
		return dictionary
	}

}