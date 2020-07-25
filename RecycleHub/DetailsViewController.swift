//
//  DetailsViewController.swift
//  RecycleHub
//
//  Created by Dinesh on 7/21/20.
//  Copyright © 2020 RecycleHub. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var materialsView: UIView!
    @IBOutlet weak var logButton: UIButton!
    
    @IBOutlet weak var pictureView: UIView!
    @IBOutlet weak var pictureImageView: UIImageView!
    
    @IBOutlet weak var materialsImageView: UIImageView!
    @IBOutlet weak var materialsLabel: UILabel!
    @IBOutlet weak var materialsPrice: UILabel!
    
    var viewColor = "Red"
    var viewImage = UIImage(named: "Jar")
    var prediction = "Plastic"
    var imageTitle = "plasticStatistics"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailsView.layer.cornerRadius = 70
        detailsView.layer.masksToBounds = true
        materialsView.layer.cornerRadius = 30
        materialsView.layer.masksToBounds = true
        logButton.layer.cornerRadius = 20
        logButton.showsTouchWhenHighlighted = true
        pictureView.layer.cornerRadius = 30
        pictureView.layer.masksToBounds = true
        
        pictureImageView.image = viewImage
        if(viewColor == "Red") {
            pictureView.backgroundColor = UIColor(red: 255/255, green: 172/255, blue: 172/255, alpha: 1)
            materialsView.backgroundColor = UIColor(red: 255/255, green: 172/255, blue: 172/255, alpha: 1)
            materialsImageView.image = UIImage(named: "glassIcon")
            materialsPrice.text = "$0.00"
            materialsLabel.text = "GLASS"
            imageTitle = "glassStatistics"
        }else if(viewColor == "Blue") {
            pictureView.backgroundColor = UIColor(red: 188/255, green: 214/255, blue: 255/255, alpha: 1)
            materialsView.backgroundColor = UIColor(red: 188/255, green: 214/255, blue: 255/255, alpha: 1)
            materialsImageView.image = UIImage(named: "cardboardIcon")
            materialsPrice.text = "$0.00"
            materialsLabel.text = "CARDBOARD"
            imageTitle = "cardboardStatistics"
        }else if(viewColor == "Green") {
            pictureView.backgroundColor = UIColor(red: 196/255, green: 255/255, blue: 202/255, alpha: 1)
            materialsView.backgroundColor = UIColor(red: 52/255, green: 199/255, blue: 89/255, alpha: 1)
            materialsImageView.image = UIImage(named: "plasticIcon")
            materialsPrice.text = "$0.05"
            materialsLabel.text = "PLASTIC"
        }else if(viewColor == "Purple") {
            pictureView.backgroundColor = UIColor(red: 243/255, green: 190/255, blue: 255/255, alpha: 1)
            materialsView.backgroundColor = UIColor(red: 243/255, green: 190/255, blue: 255/255, alpha: 1)
            materialsImageView.image = UIImage(named: "metalIcon")
            materialsPrice.text = "$0.05"
            materialsLabel.text = "METAL"
            imageTitle = "metalStatistics"
        }else if(viewColor == "Yellow") {
            pictureView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 182/255, alpha: 1)
            materialsView.backgroundColor = UIColor(red: 255/255, green: 172/255, blue: 172/255, alpha: 1)
            materialsImageView.image = UIImage(named: "glassIcon")
            materialsPrice.text = "$0.00"
            materialsLabel.text = "GLASS"
            imageTitle = "glassStatistics"
        }else if(viewColor == "Orange") {
            pictureView.backgroundColor = UIColor(red: 255/255, green: 224/255, blue: 190/255, alpha: 1)
            materialsView.backgroundColor = UIColor(red: 255/255, green: 224/255, blue: 190/255, alpha: 1)
            materialsImageView.image = UIImage(named: "paperIcon")
            materialsPrice.text = "$0.00"
            materialsLabel.text = "PAPER"
            imageTitle = "paperStatistics"
        }else if(viewColor == "Camera") {
            pictureView.backgroundColor = UIColor(red: 255/255, green: 224/255, blue: 190/255, alpha: 0)
            pictureImageView.layer.cornerRadius = 20
            pictureImageView.clipsToBounds = true
            prediction = prediction.trimmingCharacters(in: .whitespacesAndNewlines)
            materialsLabel.text = prediction.uppercased()
            
            if(prediction == "paper") {
                materialsView.backgroundColor = UIColor(red: 255/255, green: 224/255, blue: 190/255, alpha: 1)
                materialsImageView.image = UIImage(named: "paperIcon")
                materialsPrice.text = "$0.00"
                imageTitle = "paperStatistics"
            }else if(prediction == "cardboard") {
                materialsView.backgroundColor = UIColor(red: 188/255, green: 214/255, blue: 255/255, alpha: 1)
                materialsImageView.image = UIImage(named: "cardboardIcon")
                materialsPrice.text = "$0.00"
                imageTitle = "cardboardStatistics"
            }else if(prediction == "glass") {
                materialsView.backgroundColor = UIColor(red: 255/255, green: 172/255, blue: 172/255, alpha: 1)
                materialsImageView.image = UIImage(named: "glassIcon")
                materialsPrice.text = "$0.00"
                imageTitle = "glassStatistics"
            }else if(prediction == "metal") {
                materialsView.backgroundColor = UIColor(red: 243/255, green: 190/255, blue: 255/255, alpha: 1)
                materialsImageView.image = UIImage(named: "metalIcon")
                materialsPrice.text = "$0.05"
                imageTitle = "metalStatistics"
            }else if(prediction == "plastic") {
                materialsView.backgroundColor = UIColor(red: 52/255, green: 199/255, blue: 89/255, alpha: 1)
                materialsImageView.image = UIImage(named: "plasticIcon")
                materialsPrice.text = "$0.05"
                imageTitle = "plasticStatistics"
            }
        }
    }
    
    @IBAction func logButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Log Item Title", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input your item's title here..."
        })

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in

            if let name = alert.textFields?.first?.text {
                let defaults = UserDefaults.standard
                
                var logPriceText = defaults.array(forKey: "logPriceText")
                logPriceText!.insert(self.materialsPrice.text!, at: 0)
                defaults.set(logPriceText, forKey: "logPriceText")
                
                var logTitleText = defaults.array(forKey: "logTitleText")
                logTitleText!.insert(name, at: 0)
                defaults.set(logTitleText, forKey: "logTitleText")
                
                var logDateText = defaults.array(forKey: "logDateText")
                logDateText!.insert("July 25", at: 0)
                defaults.set(logDateText, forKey: "logDateText")
                
                var logImageName = defaults.array(forKey: "logImageName")
                logImageName!.insert(self.imageTitle, at: 0)
                defaults.set(logImageName, forKey: "logImageName")
            }
        }))

        self.present(alert, animated: true)
    }
    
}
