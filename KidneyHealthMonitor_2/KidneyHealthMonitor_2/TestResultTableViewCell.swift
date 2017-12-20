//
//  TestResultTableViewCell.swift
//  KidneyHealthMonitor_2
//
//  Created by Rathna Ramesh on 11/16/17.
//  Copyright © 2017 Rathna Ramesh. All rights reserved.
//

import UIKit

class TestResultTableViewCell: UITableViewCell {
    
    //properties
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
   
    @IBOutlet weak var resultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
