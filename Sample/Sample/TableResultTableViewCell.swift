//
//  TableResultTableViewCell.swift
//  Project Foodie
//
//  Created by Stardustxx on 2015-05-01.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import UIKit

class TableResultTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantScore: UILabel!
    @IBOutlet weak var restaurantDist: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadItem(name: String, score: Double, dist: Double){
        restaurantName.text = name
        restaurantScore.text = String(format:"%.1f", score)
        restaurantDist.text = String(format:"%.1f", dist) + " km"
    }

}
