//
//  MapViewController.swift
//  RecycleHub
//
//  Created by Dinesh on 7/22/20.
//  Copyright © 2020 RecycleHub. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class RecyclingCenter: NSObject {

    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    let snippet: String
    let carTime: String
    let walkTime: String
    let latitude: Float
    let longitude: Float

    init(name: String, location: CLLocationCoordinate2D, zoom: Float, snippet: String, carTime: String, walkTime: String, latitude: Float, longitude: Float){
        self.name = name
        self.location = location
        self.zoom = zoom
        self.snippet = snippet
        self.carTime = carTime
        self.walkTime = walkTime
        self.latitude = latitude
        self.longitude = longitude
    }
}

class MapViewController: UIViewController {

    var mapView: GMSMapView?

    var currentDestination: RecyclingCenter?
    
    var infoView: UIView = UIView()
    var infoLabel: UILabel = UILabel()
    var carLabel: UILabel = UILabel()
    var walkLabel: UILabel = UILabel()

    @IBOutlet weak var searchButton: UIButton!
    let destinations = [
        RecyclingCenter(name: "Danny's Recycling Center", location: CLLocationCoordinate2D(latitude: 37.369861, longitude: -121.957853), zoom: 18, snippet: "Plastic, Paper", carTime: "18 min", walkTime: "2 hr 49 min", latitude: 37.369861, longitude: -121.957853),
        RecyclingCenter(name: "MRH Recycling", location: CLLocationCoordinate2D(latitude: 37.323760, longitude: -122.047478), zoom: 18, snippet: "Plastic, Metal, Paper, Cardboard, Glass", carTime: "6 min", walkTime: "43 min", latitude: 37.323760, longitude: -122.047478),
        RecyclingCenter(name: "SMaRT Station", location: CLLocationCoordinate2D(latitude: 37.418103, longitude: -122.011764), zoom: 18, snippet: "Plastic, Metal", carTime: "17 min", walkTime: "3 hr 4 min", latitude: 37.418103, longitude: -122.011764),
        RecyclingCenter(name: "Story Road Recycling", location: CLLocationCoordinate2D(latitude:  37.334917, longitude: -121.851380), zoom: 18, snippet: "Paper, Cardboard, Glass", carTime: "21 min", walkTime: "3 hr 59 min", latitude: 37.334917, longitude: -121.851380),
        RecyclingCenter(name: "Leo Recycle", location: CLLocationCoordinate2D(latitude: 37.310782, longitude: -121.865113), zoom: 18, snippet: "Paper, Cardboard", carTime: "20 min", walkTime: "3 hr 44 min", latitude: 37.310782, longitude: -121.865113)]


    override func viewDidLoad() {
        super.viewDidLoad()

        GMSServices.provideAPIKey("AIzaSyASh13hNbc5ypfi19e8ydNJoofGskJbdOY")

        let camera = GMSCameraPosition.camera(withLatitude: 37.308967, longitude: -122.038853, zoom: 18)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        
        let button = UIButton()
        button.backgroundColor = UIColor(red: 103/255, green: 210/255, blue: 104/255, alpha: 1)
        button.tintColor = .white
        button.frame = CGRect(x: 295, y: 70, width: 75, height: 75)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.layer.cornerRadius = 35
        button.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        button.showsTouchWhenHighlighted = true
        mapView?.addSubview(button)
        
        infoView = UIView(frame: CGRect(x: 30, y: 630, width: 350, height: 130))
        infoView.backgroundColor = .white
        infoView.layer.cornerRadius = 40
        mapView?.addSubview(infoView)
        
        infoLabel = UILabel(frame: CGRect(x: 0, y: 15, width: 350, height: 30))
        infoLabel.text = "Danny's Recycling Center"
        infoLabel.textAlignment = NSTextAlignment.center
        infoLabel.font = UIFont(name: "Futura", size: 20)
        infoView.addSubview(infoLabel)
        
        let carImageView = UIImageView(frame: CGRect(x: 25, y: 50, width: 30, height: 25))
        carImageView.image = UIImage(systemName: "car.fill")
        carImageView.tintColor = .gray
        infoView.addSubview(carImageView)
        
        let walkImageView = UIImageView(frame: CGRect(x: 25, y: 80, width: 30, height: 25))
        walkImageView.image = UIImage(named: "walk")
        walkImageView.tintColor = .gray
        infoView.addSubview(walkImageView)
        
        carLabel = UILabel(frame: CGRect(x: 65, y: 47, width: 100, height: 30))
        carLabel.text = "15 min"
        carLabel.font = UIFont(name: "Futura", size: 15)
        carLabel.textColor = .gray
        infoView.addSubview(carLabel)
        
        walkLabel = UILabel(frame: CGRect(x: 65, y: 77, width: 100, height: 30))
        walkLabel.text = "30 min"
        walkLabel.font = UIFont(name: "Futura", size: 15)
        walkLabel.textColor = .gray
        infoView.addSubview(walkLabel)
        
        let directionsButton = UIButton()
        directionsButton.backgroundColor = UIColor(red: 103/255, green: 210/255, blue: 104/255, alpha: 1)
        directionsButton.tintColor = .white
        directionsButton.frame = CGRect(x: 156, y: 55, width: 154, height: 50)
        directionsButton.setTitle("   Directions", for: .normal)
        directionsButton.contentHorizontalAlignment = .left
        directionsButton.titleLabel?.font = UIFont(name: "Futura", size: 16)
        directionsButton.layer.cornerRadius = 20
        directionsButton.addTarget(self, action: #selector(directionsButtonClicked), for: .touchUpInside)
        directionsButton.showsTouchWhenHighlighted = true
        infoView.addSubview(directionsButton)
        
        let detailsButton = UIButton()
        detailsButton.backgroundColor = .white
        detailsButton.tintColor = .gray
        detailsButton.frame = CGRect(x: 297, y: 14, width: 30, height: 30)
        detailsButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        detailsButton.addTarget(self, action: #selector(detailsButtonClicked), for: .touchUpInside)
        detailsButton.showsTouchWhenHighlighted = true
        infoView.addSubview(detailsButton)
        
        let directionsImageView = UIImageView(frame: CGRect(x: 266, y: 67, width: 30, height: 25))
        directionsImageView.image = UIImage(systemName: "car.fill")
        directionsImageView.tintColor = .white
        infoView.addSubview(directionsImageView)
        
        infoView.isHidden = true
        
        view = mapView

        let currentLocation = CLLocationCoordinate2D(latitude: 37.308967, longitude: -122.038853)
        let marker = GMSMarker(position: currentLocation)
        marker.icon = UIImage(named: "currentLocation")
        marker.map = mapView
    }
    
    @objc func detailsButtonClicked(sender: UIButton) {
        performSegue(withIdentifier: "mapDetailsSegue", sender: nil)
    }
    
    @objc func searchButtonClicked(sender: UIButton) {
        if currentDestination == nil {
            currentDestination = destinations.first
            
        } else {
            
            if let index = destinations.firstIndex(of: currentDestination!) {
                if (index + 1) < destinations.count {
                    currentDestination = destinations[index + 1]
                } else {
                    currentDestination = destinations.first
                }
            }
        }
        
        setMapCamera()
        
        infoLabel.text = currentDestination?.name
        carLabel.text = currentDestination?.carTime
        walkLabel.text = currentDestination?.walkTime
        infoView.isHidden = false
    }
    
    @objc func directionsButtonClicked(sender: UIButton) {
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(37.308967),\(-122.038853)&zoom=14&views=traffic&q=\(currentDestination!.location.latitude),\(currentDestination!.location.longitude)")!, options: [:], completionHandler: nil)
        } else {
            print("Can't use comgooglemaps://")
        }
    }
    
    private func setMapCamera() {
        CATransaction.begin()
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        
        mapView?.animate(to: GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom:currentDestination!.zoom))
        
        CATransaction.commit()
        
        let marker = GMSMarker(position: currentDestination!.location)
        marker.icon = UIImage(named: "Pin")
        marker.map = mapView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? MapDetailsViewController
        
        vc?.mapDetailsTitleText = currentDestination!.name
        vc?.url = "comgooglemaps://?center=\(37.308967),\(-122.038853)&zoom=14&views=traffic&q=\(currentDestination!.location.latitude),\(currentDestination!.location.longitude)"
    }
}
