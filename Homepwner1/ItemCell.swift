//
//  ItemCell.swift
//  Homepwner1
//
//  Created by STEVE DURAN on 9/28/17.
//  Copyright © 2017 All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet  var nameLabel: UILabel!
    @IBOutlet  var serialNumber: UILabel!
    @IBOutlet  var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.adjustsFontForContentSizeCategory = true
        serialNumber.adjustsFontForContentSizeCategory = true
        valueLabel.adjustsFontForContentSizeCategory = true
    }
    
}
