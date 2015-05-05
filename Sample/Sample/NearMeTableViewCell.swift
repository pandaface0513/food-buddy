//
//  NearMeTableViewCell.swift
//  Project Foodie
//
//  Created by Victor on 2015-02-21.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import UIKit

class NearMeTableViewCell: UITableViewCell {

    @IBOutlet weak var PlacePhoto: UIImageView!
    @IBOutlet weak var PlaceName: UILabel!
    @IBOutlet weak var PlaceType: UILabel!
    @IBOutlet weak var PlaceDist: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadItem(placename: String, placephoto: String, placedist: Double, placetype: String){
        
        PlaceName.text = placename
        PlaceType.text = placetype
        PlaceDist.text = String(format:"%.1f", placedist) + " km"
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            var imageURL = NSURL(string: placephoto)
            var imageData = NSData(contentsOfURL: imageURL!)
            dispatch_async(dispatch_get_main_queue()){
                self.PlacePhoto.image = UIImage(data: imageData!)
            }
        }
    }

}
