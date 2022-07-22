//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct WeatherData{

	var list : [List]!
	var logoUrl : String!
	var sourceName : String!
	var total : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		list = [List]()
		if let listArray = dictionary["list"] as? [[String:Any]]{
			for dic in listArray{
				let value = List(fromDictionary: dic)
				list.append(value)
			}
		}
		logoUrl = dictionary["logoUrl"] as? String
		sourceName = dictionary["sourceName"] as? String
		total = dictionary["total"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if list != nil{
			var dictionaryElements = [[String:Any]]()
			for listElement in list {
				dictionaryElements.append(listElement.toDictionary())
			}
			dictionary["list"] = dictionaryElements
		}
		if logoUrl != nil{
			dictionary["logoUrl"] = logoUrl
		}
		if sourceName != nil{
			dictionary["sourceName"] = sourceName
		}
		if total != nil{
			dictionary["total"] = total
		}
		return dictionary
	}

}
