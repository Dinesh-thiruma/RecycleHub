//
//  MyCustomCell.swift
//  RecycleHub
//
//  Created by Dinesh on 7/24/20.
//  Copyright © 2020 RecycleHub. All rights reserved.
//

import Foundation
import UIKit

class MyCustomCell: UITableViewCell {
    
    @IBOutlet weak var logImageView: UIImageView!
    @IBOutlet weak var logTitleLabel: UILabel!
    @IBOutlet weak var logDateLabel: UILabel!
    @IBOutlet weak var logPriceLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 20))
    }
    
}
