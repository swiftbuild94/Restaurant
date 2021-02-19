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
	
	private let displayView() {
	
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
		DispatchQueue.global(qos: .userInitiated).async {
			guard let url = URL(string: self.url) else { return }
			guard let data = try? Data(contentsOf: url) else { return }
			do {
				let serializedData = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
				print(serializedData)
				guard let json_data = serializedData as? String else { return }
				print(json_data)
				let gotData = self.restaurant.decodeJson(data: json_data)
				if gotData {
					DispatchQueue.main.async {
						self.loadingSpinner.stopAnimating()
						self.displayView()
					}
				}
			} catch {
				debugPrint(error)
			}
		}
	}
	
	
	// MARK: - View Lifecycle
	override func viewDidLoad() {
		showSpinner()
		getJson()
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

}

