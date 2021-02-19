//
//  Restaurant.swift
//  Restaurant
//
//  Created by Patricio Benavente on 19/02/21.
//

import Foundation

struct Restaurant: Decodable {
	
	var id: Int?
	var name: String? = "Katmandou Café"
	var address: String? = "14, rue Bréguet"
	var city: String? = "Paris"
	var zipcode: Int?
	var currency_code: String?
	var speciality: String? = "Indian"
	var card_price: Int? = 27
	var avg_rate: Float? = 9.2
	var rate_count: Int? = 5552
	var tripadvisor_avg_rate: Int? = 4
	var tripadvisor_rate_count: Int? = 205
	var gps_lat: Float?
	var gps_long: Float?
	var url: String?
	var pics_diaporama: [String]?
	
	mutating func decodeJson(data: String)-> Bool {
		let jsonData = data.data(using: .utf8)!
		let restaurant = try? JSONDecoder().decode(Restaurant.self, from: jsonData)
		if let result = restaurant {
			print(result)
			return true
		}else{
			return false
		}
	}
	
}
