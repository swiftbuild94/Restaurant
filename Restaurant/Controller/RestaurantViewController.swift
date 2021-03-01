//
//  ViewController.swift
//  Restaurant
//
//  Created by Patricio Benavente on 9/02/21.
//

import UIKit

class RestaurantViewController: UIViewController {
	
	private var restaurant: Restaurant?
	private let url = "https://ptitchevreuil.github.io/test.json"
	
	
	
	private func displayName() {
//		let layout = view.layoutMarginsGuide
		if let name = restaurant?.name {
			print("Restaurant: \(String(describing: restaurant?.name!))")
			let textLabel = UILabel()
			textLabel.text = name
			view.addSubview(textLabel)
			textLabel.center = view.center
		}
	}
	
	
	private func displayView() {
		view.backgroundColor = .white
//		displayImages()
		displayName()
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
		guard let url = URL(string: self.url) else { return }
		let task = URLSession.shared.dataTask(with: url){
			(data, response, error) in
			guard let newData = data else { return }
			self.restaurant = Restaurant()
			self.restaurant = self.restaurant?.decodeJson(jsonData: newData)
			if self.restaurant != nil {
				print("GName: \(String(describing: self.restaurant?.name))")
				DispatchQueue.main.async{
					self.loadingSpinner.stopAnimating()
					self.displayView()
				}
			}
		}
		task.resume()
	}
	
	
	// MARK: - View Lifecycle
	override func viewDidLoad() {
		view.backgroundColor = .orange
		self.showSpinner()
		getJson()
		super.viewDidLoad()
	}

}

