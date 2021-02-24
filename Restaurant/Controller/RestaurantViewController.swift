//
//  ViewController.swift
//  Restaurant
//
//  Created by Patricio Benavente on 9/02/21.
//

import UIKit

class RestaurantViewController: UIViewController {
	
	private var restaurant = Restaurant()
	private let url = "https://ptitchevreuil.github.io/test.json"
	
	
	
	private func displayView() {
//		displayImages()
//		displayName()
		/*
		if let address = restaurant.address {
			let fullAddress = address + ", " + restaurant.city!
			showInfo(.address, text: fullAddress)
		}
		if let foodType = restaurant.speciality {
			showInfo(.address, text: foodType)
		}
		if let price = restaurant.card_price {
			let currency_code = restaurant.currency_code ?? "$"
			let fullPrice = "Average price " + currency_code + String(price)
			showInfo(.price, text: fullPrice)
		}
		displayMap()
		*/
	}
	
	
	private let loadingSpinner: UIActivityIndicatorView = {
		let loadingSpinner = UIActivityIndicatorView(style: .gray)
		loadingSpinner.hidesWhenStopped = true
		return loadingSpinner
	}()
	
	private func showSpinner() {
		view.addSubview(loadingSpinner)
		loadingSpinner.center = view.center
		loadingSpinner.startAnimating()
	}

	
	// MARK: - Get Json
	private func getJson(){
		print("getJson")
		guard let url = URL(string: self.url) else { return }
		let task = URLSession.shared.dataTask(with: url){
			(data, response, error) in
			guard let data = data else { return }
			print("Data: \(data)")
			let serializedData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
			guard let json_data = serializedData as? String else { return }
			let gotData = self.restaurant.decodeJson(data: json_data)
			print("Zip code: \(String(describing: self.restaurant.zipcode))")
			if gotData {
				self.loadingSpinner.stopAnimating()
				self.displayView()s
			}
		}
		task.resume()
	}
	
	
	// MARK: - View Lifecycle
	override func viewDidLoad() {
		view.backgroundColor = .white
		self.showSpinner()
		getJson()
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

}

