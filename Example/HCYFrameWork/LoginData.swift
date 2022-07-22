//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct LoginData{

	var captcha : String!
	var captchaKey : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		captcha = dictionary["captcha"] as? String
		captchaKey = dictionary["captchaKey"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if captcha != nil{
			dictionary["captcha"] = captcha
		}
		if captchaKey != nil{
			dictionary["captchaKey"] = captchaKey
		}
		return dictionary
	}

}
