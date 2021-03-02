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
	
	private enum typeOfInfo {
		case address
		case typeOfFood
		case price
	}
	
	
	// MARK: - DisplayView
	private let photoImageView = UIImageView()
	private let nameTextView =  UITextView()
	private let addressTextView = UITextView()
	
	let button: UIButton = {
		let button = UIButton()
		button.setTitle("Book a table", for: .normal)
		return button
	}()
	
	
	private func displayView() {
		if let images = restaurant?.pics_diaporama, images.count > 0 {
			displayImages(images)
			view.addSubview(photoImageView)
		}
		if let name = restaurant?.name {
			print(name)
			nameTextView.text = name
			view.addSubview(nameTextView)
		}
		if let address = restaurant?.address {
			var fullAddress = address
			if let city = restaurant?.city {
				fullAddress = fullAddress + ", " + city
			}
			print(fullAddress)
			showInfo(.address, text: fullAddress)
		} else if let city = restaurant?.city {
			showInfo(.address, text: city)
		}
		if let foodType = restaurant?.speciality {
			print(foodType)
			showInfo(.address, text: foodType)
		}
		if let price = restaurant?.card_price {
			let currency_code = restaurant?.currency_code ?? "$"
			let fullPrice = "Average price " + currency_code + String(price)
			print(fullPrice)
			showInfo(.price, text: fullPrice)
		}
		displayMap()
		view.addSubview(button)
		view.bringSubviewToFront(button)
		setupLayout()
	}
	
	
	private func displayImages(_ images: [String]){
//			print("Images: \(String(describing: images))")
//			var imagesData: [UIImage]

			// TODO: Load all Images
			let index = 0
			let imageUrlString = images[index]
			guard let imageUrl: URL = URL(string: imageUrlString) else { return }
			
			photoImageView.loadImage(withUrl: imageUrl)
			
			// TODO: Gesture Recognizer
	}
	
	
	private func showInfo(_ typeOfInfo: typeOfInfo, text: String){
		var icon: String
		switch typeOfInfo {
			case .address:
				icon = "location"
			case .typeOfFood:
				icon = "food"
			case .price:
				icon = "cash"
		}
		let image = UIImage(named: icon)
		let myImgageView: UIImageView = UIImageView()
		myImgageView.image = image
		let label = UILabel()
		label.text = text
		view.addSubview(myImgageView)
		view.addSubview(label)
	}
	
	private func displayMap() {
	
	}
	
	// MARK: - Setup Layout
	private func setupLayout() {
//		let layout = view.layoutMarginsGuide

		photoImageView.translatesAutoresizingMaskIntoConstraints = false
		photoImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		photoImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		photoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
		photoImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
		photoImageView.contentMode = UIView.ContentMode.scaleAspectFit
		
		nameTextView.translatesAutoresizingMaskIntoConstraints = false
		nameTextView.font = UIFont.boldSystemFont(ofSize: 24)
		nameTextView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 0).isActive = true
//		nameTextViewnameTextView.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 150).isActive = true
		nameTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
		nameTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		nameTextView.isEditable = false
		nameTextView.isScrollEnabled = false
		
		button.translatesAutoresizingMaskIntoConstraints = false
		button.topAnchor.constraint(equalTo: nameTextView.topAnchor, constant: 10).isActive = true
		button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 150).isActive = true
		button.setTitleColor(.white, for: .normal)
		button.backgroundColor = .green
		button.layer.cornerRadius = 5
		button.layer.borderWidth = 1
		button.layer.borderColor = UIColor.black.cgColor
		
	}
	
	
	// MARK: - Spinner
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
	private func getJson() {
		guard let url = URL(string: self.url) else { return }
		let task = URLSession.shared.dataTask(with: url){
			(data, response, error) in
			guard let newData = data else { return }
			self.restaurant = Restaurant()
			self.restaurant = self.restaurant?.decodeJson(jsonData: newData)
			if self.restaurant != nil {
				DispatchQueue.main.async {
					self.loadingSpinner.stopAnimating()
					self.displayView()
				}
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
	}
}


// MARK: - Extension UIImageView
extension UIImageView {
	func loadImage(withUrl url: URL) {
		DispatchQueue.global().async { [weak self] in
			if let imageData = try? Data(contentsOf: url) {
				if let image = UIImage(data: imageData) {
					DispatchQueue.main.async {
						self?.image = image
					}
				}
			}
		}
	}
}
