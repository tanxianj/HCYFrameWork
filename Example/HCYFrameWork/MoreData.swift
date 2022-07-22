//
//	MoreData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct MoreData{

	var alert : AnyObject!
	var precipitation : AnyObject!
	var sunrise : String!
	var sunset : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		alert = dictionary["alert"] as? AnyObject
		precipitation = dictionary["precipitation"] as? AnyObject
		sunrise = dictionary["sunrise"] as? String
		sunset = dictionary["sunset"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if alert != nil{
			dictionary["alert"] = alert
		}
		if precipitation != nil{
			dictionary["precipitation"] = precipitation
		}
		if sunrise != nil{
			dictionary["sunrise"] = sunrise
		}
		if sunset != nil{
			dictionary["sunset"] = sunset
		}
		return dictionary
	}

}