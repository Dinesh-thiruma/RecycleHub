//
//  StatisticsSubViewController.swift
//  RecycleHub
//
//  Created by Dinesh on 7/25/20.
//  Copyright © 2020 RecycleHub. All rights reserved.
//

import UIKit

class StatisticsSubViewController: UIViewController {

    @IBOutlet weak var moneyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMoney()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMoney()
    }
    
    private func getMoney() {
        let defaults = UserDefaults.standard
        
        var totalAmount: Double = 0.00
        if(defaults.array(forKey: "logPriceText") != nil)
        {
            for money in defaults.array(forKey: "logPriceText") as! [String] {
                if(money == "$0.05") {
                    totalAmount += 0.05
                }
            }
            moneyLabel.text = "$" + String(format: "%.2f", totalAmount)
        }
        else{
            moneyLabel.text = "$0.00"
        }
    }
}

class PlasticSubViewController: UIViewController {
    
    @IBOutlet weak var plasticLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlastic()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPlastic()
    }
    
    private func getPlastic() {
        let defaults = UserDefaults.standard
        
        var count: Int = 0
        if(defaults.array(forKey: "logImageName") != nil)
        {
            for plastic in defaults.array(forKey: "logImageName") as! [String] {
                if(plastic == "plasticStatistics") {
                    count += 1
                }
            }
            plasticLabel.text = String(count)
        }
        else{
            plasticLabel.text = "0"
        }
    }
}

class PaperSubViewController: UIViewController {
    @IBOutlet weak var paperLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPaper()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPaper()
    }
    
    private func getPaper() {
        let defaults = UserDefaults.standard
        
        var count: Int = 0
        if(defaults.array(forKey: "logImageName") != nil)
        {
            for paper in defaults.array(forKey: "logImageName") as! [String] {
                if(paper == "paperStatistics") {
                    count += 1
                }
            }
            paperLabel.text = String(count)
        }
        else{
            paperLabel.text = "0"
        }
    }
}

class CardboardSubViewController: UIViewController {
    @IBOutlet weak var cardboardLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCardboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCardboard()
    }
    
    private func getCardboard() {
        let defaults = UserDefaults.standard
        
        var count: Int = 0
        if(defaults.array(forKey: "logImageName") != nil)
        {
            for cardboard in defaults.array(forKey: "logImageName") as! [String] {
                if(cardboard == "cardboardStatistics") {
                    count += 1
                }
            }
            cardboardLabel.text = String(count)
        }
        else{
            cardboardLabel.text = "0"
        }
    }
}

class GlassSubViewController: UIViewController {
    @IBOutlet weak var glassLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGlass()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getGlass()
    }
    
    private func getGlass() {
        let defaults = UserDefaults.standard
        
        var count: Int = 0
        if(defaults.array(forKey: "logImageName") != nil)
        {
        for glass in defaults.array(forKey: "logImageName") as! [String] {
            if(glass == "glassStatistics") {
                count += 1
            }
        }
        glassLabel.text = String(count)
        }
        else{
            glassLabel.text = "0"
        }
    }
}

class MetalSubViewController: UIViewController {
    @IBOutlet weak var metalLabel: UILabel!
    
    override func viewDidLoad() {
         super.viewDidLoad()
         getMetal()
     }
     
     override func viewWillAppear(_ animated: Bool) {
         getMetal()
     }
     
     private func getMetal() {
         let defaults = UserDefaults.standard
         
         var count: Int = 0
         if(defaults.array(forKey: "logImageName") != nil)
         {
             for metal in defaults.array(forKey: "logImageName") as! [String] {
                 if(metal == "metalStatistics") {
                     count += 1
                 }
             }
             metalLabel.text = String(count)
        }
         else{
            metalLabel.text = "0"
        }
        
     }
}
