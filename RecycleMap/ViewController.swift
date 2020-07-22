//
//  ViewController.swift
//  RecycleMap
//
//  Created by Nikhil Pitta on 7/20/20.
//  Copyright © 2020 Nikhil Pitta. All rights reserved.

import UIKit
import GoogleMaps

class RecyclingCenter: NSObject {
    
    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    let snippet: String
    
    init(name: String, location: CLLocationCoordinate2D, zoom: Float, snippet: String){
        self.name = name
        self.location = location
        self.zoom = zoom
        self.snippet = snippet
    }
}

class ViewController: UIViewController {

    var mapView: GMSMapView?
    
    var currentDestination: RecyclingCenter?
    
    let destinations = [
        RecyclingCenter(name: "Danny's Recycling Center", location: CLLocationCoordinate2D(latitude: 37.369861, longitude: -121.957853), zoom: 18, snippet: "Plastic, Paper"),
        RecyclingCenter(name: "MRH Recycling", location: CLLocationCoordinate2D(latitude: 37.323760, longitude: -122.047478), zoom: 18, snippet: "Plastic, Metal, Paper, Cardboard, Glass"),
        RecyclingCenter(name: "SMaRT Station", location: CLLocationCoordinate2D(latitude: 37.418103, longitude: -122.011764), zoom: 18, snippet: "Plastic, Metal"),
        RecyclingCenter(name: "Story Road Recycling", location: CLLocationCoordinate2D(latitude:  37.334917, longitude: -121.851380), zoom: 18, snippet: "Paper, Cardboard, Glass"),
        RecyclingCenter(name: "Leo Recycle", location: CLLocationCoordinate2D(latitude: 37.310782, longitude: -121.865113), zoom: 18, snippet: "Paper, Cardboard")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyA__FDkkz51E9ufvifNozLxCJB7pxQEINk")
        let camera = GMSCameraPosition.camera(withLatitude: 37.308967, longitude: -122.038853, zoom: 18)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        view = mapView
      
        let currentLocation = CLLocationCoordinate2D(latitude: 37.308967, longitude: -122.038853)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "Current Location"
        marker.map = mapView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(ViewController.next as (ViewController) -> () -> ()))
        
    }

    @objc func next() {
        
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
    }
    
    private func setMapCamera() {
        
        CATransaction.begin()
        CATransaction.setValue(4, forKey: kCATransactionAnimationDuration)
        
        mapView?.animate(to: GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom:currentDestination!.zoom))
        
        CATransaction.commit()
        
        let marker = GMSMarker(position: currentDestination!.location)
        marker.title = currentDestination!.name
        marker.snippet = currentDestination!.snippet
        marker.map = mapView
    }
    
    
}

