//
//  Restaurant.swift
//  Restaurant
//
//  Created by Patricio Benavente on 19/02/21.
//

import Foundation

struct Restaurant {
	
	var images: Array<String>?
	var name: String? = "Katmandou Café"
	var address: String? = "14, rue Bréguet, Paris"
	var typeOfFood: String? = "Indian"
	var price: String? = "Average price €27"
	var forkScore: Float? = 9.2
	var forkReviews: Int? = 5552
	var tripAdvisorScore: Int? = 4
	var tripAdvisorReviews: Int? = 205
	var geolocation: (lat:String, long:String)?

}
