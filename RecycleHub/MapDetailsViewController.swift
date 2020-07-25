//
//  MapDetailsViewController.swift
//  RecycleHub
//
//  Created by Dinesh on 7/23/20.
//  Copyright © 2020 RecycleHub. All rights reserved.
//

import UIKit

class MapDetailsViewController: UIViewController {

    @IBOutlet weak var locationImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var openLabel1: UILabel!
    @IBOutlet weak var carTimeLabel: UILabel!
    @IBOutlet weak var walkTimeLabel: UILabel!
    
    @IBOutlet var acceptImages: [UIImageView]!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var openLabel2: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    
    var url: String? = nil
    var mapDetailsTitleText: String? = nil
    var acceptableMaterials: [String]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editDetails()
        editMaterials()
    }
    
    private func editMaterials() {
        for index in 0...acceptableMaterials!.count - 1 {
            let imageName = (acceptableMaterials?[index].lowercased())! + "Statistics"
            acceptImages[index].image = UIImage(named:imageName)
        }
        
        if(acceptableMaterials!.count < 4) {
            for index in acceptableMaterials!.count...3 {
                acceptImages[index].image = UIImage(named:" ")
            }
        }
    }
    
    private func editDetails() {
        if(mapDetailsTitleText == "Danny's Recycling Center") {
            titleLabel.text = "Danny's Recycling Center"
            carTimeLabel.text = "18 min"
            walkTimeLabel.text = "2 hr 49 min"
            openLabel1.text = "Open"
            openLabel2.text = "Open"
            locationLabel.text = "1745 Walsh Ave, Santa Clara, CA 95050"
            hoursLabel.text = "7 AM - 2:30 PM"
            acceptableMaterials = ["Plastic", "Paper"]
            locationImageView.image = UIImage(named: "Danny's Recycling Center")
        }else if(mapDetailsTitleText == "SMaRT Station") {
            titleLabel.text = "SMaRT Station"
            carTimeLabel.text = "17 min"
            walkTimeLabel.text = "3 hr 4 min"
            openLabel1.text = "Open"
            openLabel2.text = "Open"
            locationLabel.text = "301 Carl Rd, Sunnyvale, CA 94089"
            hoursLabel.text = "8 AM - 5 PM"
            acceptableMaterials = ["Plastic", "Metal"]
            locationImageView.image = UIImage(named: "SMaRT Station")
        }else if(mapDetailsTitleText == "Story Road Recycling") {
            titleLabel.text = "Story Road Recycling"
            carTimeLabel.text = "21 min"
            walkTimeLabel.text = "3 hr 59 min"
            openLabel1.text = "Open"
            openLabel2.text = "Open"
            locationLabel.text = "1303 Story Road, San Jose, CA 95122"
            hoursLabel.text = "9 AM - 5 PM"
            acceptableMaterials = ["Paper", "Cardboard", "Glass", "Plastic"]
            locationImageView.image = UIImage(named: "Story Road Recycling")
        }else if(mapDetailsTitleText == "Leo Recycle") {
            titleLabel.text = "Leo Recycle"
            carTimeLabel.text = "20 min"
            walkTimeLabel.text = "3 hr 44 min"
            openLabel1.text = "Open"
            openLabel2.text = "Open"
            locationLabel.text = "215 Leo Ave, San Jose, CA 95112"
            hoursLabel.text = "7AM - 5PM"
            acceptableMaterials = ["Paper", "Cardboard"]
            locationImageView.image = UIImage(named: "Leo Recycle")
        }else if(mapDetailsTitleText == "MRH Recycling") {
            titleLabel.text = "MRH Recycling"
            carTimeLabel.text = "6 min"
            walkTimeLabel.text = "43 min"
            openLabel1.text = "Open"
            openLabel2.text = "Open"
            locationLabel.text = "21268 Santa Clara Blvd, Cupertino, CA 95014"
            hoursLabel.text = "10AM - 1PM"
            acceptableMaterials = ["Plastic", "Metal", "Cardboard", "Glass"]
            locationImageView.image = UIImage(named: "MRH Recycling")
        }
    }

    @IBAction func mapDetailsDirectionButtonPressed(_ sender: Any) {
        if(UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
                    UIApplication.shared.open(URL(string:url!)!, options: [:], completionHandler: nil)
               } else {
                   print("Can't use comgooglemaps://")
              }
    }
    
}
