//
//  Restaurant.swift
//  Restaurant
//
//  Created by Patricio Benavente on 19/02/21.
//

import Foundation

struct Restaurant: Decodable {
	
	var id: Int?
	var name: String?
	var address: String?
	var city: String?
	var zipcode: String?
	var currency_code: String?
	var speciality: String?
	var card_price: Int?
	var avg_rate: Float?
	var rate_count: Int?
	var tripadvisor_avg_rate: Int?
	var tripadvisor_rate_count: Int?
	var gps_lat: Float?
	var gps_long: Float?
	var url: URL?
	var pics_diaporama: [String]?
	
	mutating func decodeJson(jsonData: Data)->Restaurant? {
		print("Decode Json")
		do {
			let restaurant = try JSONDecoder().decode(Restaurant.self, from: jsonData)
			return restaurant
		} catch {
			print(error)
			return nil
		}
	}
	
}
