//
//  ViewController.swift
//  Restaurant
//
//  Created by Patricio Benavente on 9/02/21.
//

import UIKit
import MapKit

class RestaurantViewController: UIViewController, MKMapViewDelegate {
	
	private var restaurant: Restaurant?
	private let url = "https://ptitchevreuil.github.io/test.json"
	
	private enum typeOfInfo {
		case address
		case typeOfFood
		case price
	}
	
	
	// MARK: - DisplayView
	let topContainerView = UIView()
	private let shareButton: UIButton = {
		let shareButton = UIButton(type: .custom)
		shareButton.setImage(UIImage(named: "share"), for: .normal)
		return shareButton
	}()
	private let loveButton: UIButton = {
		let loveButton = UIButton(type: .custom)
		loveButton.setImage(UIImage(named: "solid-heart"), for: .normal)
		return loveButton
	}()
	private let photoImageView = UIImageView()
	private let countImagesButton = UIButton()
	private let nameTextView =  UITextView()
	private let addressTextView = UITextView()
	private let bottomContainerView = UIView()
	private let mapView = MKMapView()
	private let bookTableButton: UIButton = {
		let bookTableButton = UIButton()
		bookTableButton.setTitle("Book a table", for: .normal)
		return bookTableButton
	}()
	
	
	private func displayView() {
		var countImages: Int?
		view.addSubview(topContainerView)
		if let images = restaurant?.pics_diaporama, images.count > 0 {
			displayImages(images)
			countImages = images.count
			topContainerView.addSubview(photoImageView)
			topContainerView.bringSubviewToFront(photoImageView)
		}
		if countImages != nil, countImages! > 1 {
			countImagesButton.titleLabel!.text = "See all " + String(countImages!) + " photos >"
			countImagesButton.setTitleColor(.white, for: .normal)
			photoImageView.addSubview(countImagesButton)
			photoImageView.bringSubviewToFront(countImagesButton)
		}
		// TODO: Back Button
//		view.addSubview(photoImageView)
//		view.bringSubviewToFront(bookTableButton)
		photoImageView.addSubview(shareButton)
		photoImageView.bringSubviewToFront(shareButton)
		photoImageView.addSubview(loveButton)
		photoImageView.bringSubviewToFront(loveButton)
		
		if let name = restaurant?.name {
			print(name)
			nameTextView.text = name
			view.addSubview(nameTextView)
			view.bringSubviewToFront(nameTextView)
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
			var currency_code = restaurant?.currency_code ?? "$"
			if currency_code == "EUR" {
				currency_code = "€"
			}
			let fullPrice = "Average price " + currency_code + String(price)
			print(fullPrice)
			showInfo(.price, text: fullPrice)
		}
		view.addSubview(bottomContainerView)
		if let lat = restaurant?.gps_lat, let long = restaurant?.gps_long {
			displayMap(lat: lat, long: long)
			view.addSubview(mapView)
		}
		view.addSubview(bookTableButton)
		view.bringSubviewToFront(bookTableButton)
		setupLayout()
	}
	
	
	private func displayImages(_ images: [String]){
			// TODO: Load all Images
//			print("Images: \(String(describing: images))")
//			var imagesData: [UIImage]
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
	
	private func displayMap(lat: Double, long: Double) {
		mapView.mapType = MKMapType.standard
		mapView.isZoomEnabled = true
		mapView.isScrollEnabled = true
		let location = CLLocationCoordinate2DMake(lat, long)
		let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
		mapView.region = region
	}
	
	// MARK: - Setup Layout
	private func setupLayout() {
		topContainerView.backgroundColor = .gray
		topContainerView.translatesAutoresizingMaskIntoConstraints = false
		topContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		topContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
		topContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		topContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		
		photoImageView.translatesAutoresizingMaskIntoConstraints = false
		photoImageView.topAnchor.constraint(equalTo: topContainerView.topAnchor, constant: 0).isActive = true
		photoImageView.leftAnchor.constraint(equalTo: topContainerView.leftAnchor).isActive = true
		photoImageView.rightAnchor.constraint(equalTo: topContainerView.rightAnchor).isActive = true
		photoImageView.heightAnchor.constraint(equalTo: topContainerView.heightAnchor).isActive = true
		photoImageView.contentMode = UIView.ContentMode.scaleAspectFit

		countImagesButton.translatesAutoresizingMaskIntoConstraints = false
		countImagesButton.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: 100).isActive = true
		countImagesButton.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: 10).isActive = true
		countImagesButton.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor).isActive = true

		shareButton.translatesAutoresizingMaskIntoConstraints = false
		shareButton.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor).isActive = true
		shareButton.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 10).isActive = true
		shareButton.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: 50).isActive = true
		shareButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

		loveButton.translatesAutoresizingMaskIntoConstraints = false
		loveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		loveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 60).isActive = true
		loveButton.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: 10).isActive = true
		loveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

		nameTextView.translatesAutoresizingMaskIntoConstraints = false
		nameTextView.font = UIFont.boldSystemFont(ofSize: 24)
		nameTextView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 0).isActive = true
		nameTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
		nameTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		nameTextView.isEditable = false
		nameTextView.isScrollEnabled = false
		
		bottomContainerView.backgroundColor = .yellow
		bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
		bottomContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor).isActive = true
		bottomContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
		bottomContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		bottomContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		
		mapView.translatesAutoresizingMaskIntoConstraints = false
		mapView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor).isActive = true
		mapView.leftAnchor.constraint(equalTo: bottomContainerView.leftAnchor).isActive = true
		mapView.rightAnchor.constraint(equalTo: bottomContainerView.rightAnchor).isActive = true
		mapView.heightAnchor.constraint(equalTo: bottomContainerView.heightAnchor).isActive = true
		mapView.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor).isActive = true
		
//		bookTableButton.translatesAutoresizingMaskIntoConstraints = false
//		bookTableButton.topAnchor.constraint(equalTo: nameTextView.topAnchor, constant: 50).isActive = true
//		bookTableButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//		bookTableButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 30).isActive = true
//		bookTableButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
//		bookTableButton.setTitleColor(.white, for: .normal)
//		bookTableButton.backgroundColor = .green
//		bookTableButton.layer.cornerRadius = 5
//		bookTableButton.layer.borderWidth = 1
//		bookTableButton.layer.borderColor = UIColor.black.cgColor
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
