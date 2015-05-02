//
//  TableFriendsTableViewCell.swift
//  Project Foodie
//
//  Created by Stardustxx on 2015-05-01.
//  Copyright (c) 2015 Victor. All rights reserved.
//

import UIKit

class TableFriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var friendSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadItem(image:String, friend : String){
        username.text = friend
        friendSwitch.setOn(false, animated: true)
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            var imageURL = NSURL(string: image)
            var imageData = NSData(contentsOfURL: imageURL!)
            dispatch_async(dispatch_get_main_queue()){
                self.profileImage.image = UIImage(data: imageData!)
            }
        }
    }
    
    func getSwitchState() -> Bool{
        var onOrOff : Bool
        if (friendSwitch.on){
            onOrOff = true
        }
        else {
            onOrOff = false
        }
        return onOrOff
    }
}
