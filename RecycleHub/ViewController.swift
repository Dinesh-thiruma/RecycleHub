//
//  ViewController.swift
//  RecycleHub
//
//  Created by Dinesh on 7/20/20.
//  Copyright © 2020 RecycleHub. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var enterButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        enterButton.layer.cornerRadius = 20
        enterButton.showsTouchWhenHighlighted = true
    }

    @IBAction func enterButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "enterSegue", sender: self)
    }
    
}

