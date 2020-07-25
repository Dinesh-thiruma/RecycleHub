//
//  LogViewController.swift
//  RecycleHub
//
//  Created by Dinesh on 7/24/20.
//  Copyright © 2020 RecycleHub. All rights reserved.
//

import UIKit

class LogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let cellReuseIdentifier = "cell"
    
    let defaults = UserDefaults.standard

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaults.array(forKey: "logPriceText")!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:MyCustomCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MyCustomCell
        
        cell.logImageView.image = UIImage(named: defaults.array(forKey: "logImageName")![indexPath.row] as! String)
        cell.logDateLabel.text = defaults.array(forKey: "logDateText")![indexPath.row] as! String
        cell.logTitleLabel.text = defaults.array(forKey: "logTitleText")![indexPath.row] as! String
        cell.logPriceLabel.text = defaults.array(forKey: "logPriceText")![indexPath.row] as! String

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var logImageName = defaults.array(forKey: "logImageName")
            logImageName!.remove(at: indexPath.row)
            defaults.set(logImageName, forKey: "logImageName")
            
            var logDateText = defaults.array(forKey: "logDateText")
            logDateText!.remove(at: indexPath.row)
            defaults.set(logDateText, forKey: "logDateText")
            
            var logTitleText = defaults.array(forKey: "logTitleText")
            logTitleText!.remove(at: indexPath.row)
            defaults.set(logTitleText, forKey: "logTitleText")
            
            var logPriceText = defaults.array(forKey: "logPriceText")
            logPriceText!.remove(at: indexPath.row)
            defaults.set(logPriceText, forKey: "logPriceText")
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
